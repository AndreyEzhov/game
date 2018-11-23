//
//  GameScene.swift
//  Bamboo Breakout
/**
 * Copyright (c) 2016 Razeware LLC
 *
 * Permission is hereby granted, free of charge, to any person obtaining a copy
 * of this software and associated documentation files (the "Software"), to deal
 * in the Software without restriction, including without limitation the rights
 * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 * copies of the Software, and to permit persons to whom the Software is
 * furnished to do so, subject to the following conditions:
 *
 * The above copyright notice and this permission notice shall be included in
 * all copies or substantial portions of the Software.
 *
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 * AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
 * THE SOFTWARE.
 */ 

import SpriteKit

let BallCategoryName = "ball"
let FloorCategoryName = "floor"
let BlockCategoryName = "block"
let GameMessageName = "gameMessage"

let BallCategory   : UInt32 = 0x1 << 0
let BottomCategory : UInt32 = 0x1 << 1
let BlockCategory  : UInt32 = 0x1 << 2
let FloorCategory : UInt32 = 0x1 << 3
let BorderCategory : UInt32 = 0x1 << 4
let GameAreaCategory : UInt32 = 0x1 << 5

extension SKPhysicsBody {
    func defaultSetup() {
        friction = 0
        restitution = 1
        angularDamping = 0
        linearDamping = 0
    }
}

class GameScene: SKScene, SKPhysicsContactDelegate {
    
    // MARK: - Properties
    
    private var parentBallNode = ParentBallNode()
    
    private var endBallNode = ParentBallNode()
    
    private var gameInProcess = false
    
    private var setBalls = Set<BallNode>()
    
    private let positionY = ballSize / 2.0
    
    // MARK: - Life Cycle
    
    override func didMove(to view: SKView) {
        super.didMove(to: view)
        setupBorder()
        setupBottom()
        setupPhysicsWorld()
        
        for i in 0...6 {
            let block = BrickNode(hitPoints: 20)
            addChild(block)
            block.position = CGPoint(x: 20.0 + CGFloat(i) * 40.0, y: 300.0)
        }
        
        addChild(parentBallNode)
        parentBallNode.position = CGPoint(x: frame.midX, y: positionY)
        
        let levelNode = GameLevelNode(width: frame.width)
        addChild(levelNode)
        levelNode.position = CGPoint(x: frame.midX, y: 20.0)
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        let touchPoint = touches.first!.location(in: self)
        let y = touchPoint.y - parentBallNode.position.y
        let x = touchPoint.x - parentBallNode.position.x
        let coef = 4.0 / sqrt(x * x + y * y)
        let vector = CGVector(dx: x * coef, dy: y * coef)
        
        createBalls(count: 10, apply: vector)
    }
    
    // MARK: - Private Functions
    
    private func setupPhysicsWorld() {
        physicsWorld.gravity = CGVector(dx: 0.0, dy: 0.0)
        physicsWorld.contactDelegate = self
    }
    
    private func setupBorder() {
        let borderBody = SKPhysicsBody(edgeLoopFrom: self.frame)
        borderBody.friction = 0
        physicsBody = borderBody
        borderBody.categoryBitMask = BorderCategory
    }
    
    private func setupBottom() {
        let bottomRect = CGRect(x: frame.origin.x, y: frame.origin.y, width: frame.size.width, height: 1)
        let bottom = SKNode()
        bottom.physicsBody = SKPhysicsBody(edgeLoopFrom: bottomRect)
        bottom.physicsBody?.categoryBitMask = FloorCategory
        addChild(bottom)
    }
    
    private func createBalls(count: Int, apply vector: CGVector) {
        
        guard !gameInProcess else {
            return
        }
        
        let actionStartGame = SKAction.run {
            self.gameInProcess = true
        }
        
        let createBallAction = SKAction.run {
            let ball = BallNode()
            self.addChild(ball)
            ball.position = self.parentBallNode.position
            ball.applyImpulse(vector)
            self.setBalls.insert(ball)
        }
        
        let waitAction = SKAction.wait(forDuration: 0.2)
        
        let spawnSequenceAction = SKAction.sequence([createBallAction, waitAction])
        
        let actionRemoveParentBall = SKAction.run {
            self.parentBallNode.removeFromParent()
        }
        
        var actions = [actionStartGame,
                       SKAction.repeat(spawnSequenceAction, count: count - 1)]
        
        if count > 1 {
            actions.append(createBallAction)
        }
        
        actions.append(actionRemoveParentBall)
        
        let action = SKAction.sequence(actions)
        
        run(action)
    }
    
    // MARK: - SKPhysicsContactDelegate
    
    func didEnd(_ contact: SKPhysicsContact) {
        
        var firstBody: SKPhysicsBody
        var secondBody: SKPhysicsBody
        
        if contact.bodyA.categoryBitMask < contact.bodyB.categoryBitMask {
            firstBody = contact.bodyA
            secondBody = contact.bodyB
        } else {
            firstBody = contact.bodyB
            secondBody = contact.bodyA
        }
        
        switch (firstBody.categoryBitMask, secondBody.categoryBitMask) {
        case (BallCategory, GameAreaCategory):
            if let ball = firstBody.node as? BallNode {
                ball.ballInGame = true
            }
        default:
            break
        }
    }
    
    func didBegin(_ contact: SKPhysicsContact) {
        
        var firstBody: SKPhysicsBody
        var secondBody: SKPhysicsBody
        
        if contact.bodyA.categoryBitMask < contact.bodyB.categoryBitMask {
            firstBody = contact.bodyA
            secondBody = contact.bodyB
        } else {
            firstBody = contact.bodyB
            secondBody = contact.bodyA
        }
        
        switch (firstBody.categoryBitMask, secondBody.categoryBitMask) {
        case (BallCategory, FloorCategory):
            if let ball = firstBody.node as? BallNode,
                ball.parent != nil,
                setBalls.contains(ball),
                ball.ballInGame {
                ball.removeFromParent()
                setBalls.remove(ball)
                if endBallNode.parent == nil {
                    addChild(endBallNode)
                    endBallNode.position = CGPoint(x: ball.position.x,
                                                   y: positionY)
                }
                if setBalls.count == 0 {
                    addChild(parentBallNode)
                    parentBallNode.position = endBallNode.position
                    endBallNode.removeFromParent()
                    gameInProcess = false
                }
            }
        case (BallCategory, BlockCategory):
            (secondBody.node as? BrickNode)?.damage(with: 1)
        default:
            break
        }
    }
    
}
