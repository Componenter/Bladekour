# Bladekour - Complete Project Structure

```
src/
│
├── shared/
│   ├── network/
│   │   ├── packets/
│   │   │   ├── combat.ts                            // Combat packets
│   │   │   ├── movement.ts                          // Movement packets
│   │   │   ├── game-state.ts                        // Game state packets
│   │   │   └── index.ts                             // Export all
│   │   └── middleware/
│   │       ├── types.ts                             // Middleware types
│   │       └── middleware-chain.ts                  // Middleware chain
│   │
│   ├── constants/
│   │   ├── combat/
│   │   │   ├── damage.ts                            // Damage values
│   │   │   ├── hitboxes.ts                          // Hitbox sizes
│   │   │   ├── combos.ts                            // Combo configs
│   │   │   ├── knockback.ts                         // Knockback values
│   │   │   └── animations.ts                        // Animation IDs
│   │   ├── movement/
│   │   │   ├── grapple.ts                           // Grapple settings
│   │   │   ├── locomotion.ts                        // Movement speeds
│   │   │   └── air-control.ts                       // Air control
│   │   └── gameplay/
│   │       ├── spawning.ts                          // Spawn settings
│   │       ├── rounds.ts                            // Round timings
│   │       └── ui.ts                                // UI timings
│   │
│   ├── types/
│   │   ├── combat/
│   │   │   ├── attack.ts                            // Attack types
│   │   │   ├── weapon.ts                            // Weapon types
│   │   │   └── hit-result.ts                        // Hit result types
│   │   ├── movement/
│   │   │   ├── grapple.ts                           // Grapple types
│   │   │   └── velocity.ts                          // Velocity types
│   │   ├── player/
│   │   │   ├── stats.ts                             // Player stats
│   │   │   ├── state.ts                             // Player state
│   │   │   └── data.ts                              // Player data
│   │   └── game/
│   │       ├── match.ts                             // Match types
│   │       └── session.ts                           // Session types
│   │
│   ├── state/
│   │   ├── combat-state.ts                          // Combat states
│   │   ├── movement-state.ts                        // Movement states
│   │   ├── game-state.ts                            // Game states
│   │   └── state-machine.ts                         // State machine
│   │
│   ├── utils/
│   │   ├── math/
│   │   │   ├── vector.ts                            // Vector math
│   │   │   ├── trajectory.ts                        // Trajectories
│   │   │   ├── interpolation.ts                     // Interpolation
│   │   │   └── geometry.ts                          // Geometry
│   │   ├── combat/
│   │   │   ├── damage-calc.ts                       // Damage calc
│   │   │   ├── hit-detection.ts                     // Hit detection
│   │   │   ├── knockback-calc.ts                    // Knockback calc
│   │   │   └── combo-validator.ts                   // Combo validation
│   │   ├── movement/
│   │   │   ├── grapple-physics.ts                   // Grapple physics
│   │   │   └── velocity-calc.ts                     // Velocity calc
│   │   └── validation/
│   │       ├── input-validator.ts                   // Input validation
│   │       └── bounds-checker.ts                    // Bounds checking
│   │
│   └── data/
│       ├── weapons/
│       │   ├── sword-data.ts                        // Sword configs
│       │   └── index.ts                             // Export all
│       └── abilities/
│           └── grapple-data.ts                      // Grapple configs
│
│
├── server/
│   ├── runtime/
│   │   └── init.server.ts                           // Server entry
│   │
│   ├── systems/
│   │   ├── combat/
│   │   │   ├── combat-system.ts                     // Combat system
│   │   │   ├── hit-resolver.ts                      // Hit resolution
│   │   │   ├── damage-handler.ts                    // Damage handling
│   │   │   ├── combo-tracker.ts                     // Combo tracking
│   │   │   └── weapon-manager.ts                    // Weapon manager
│   │   ├── movement/
│   │   │   ├── grapple-system.ts                    // Grapple system
│   │   │   ├── grapple-validator.ts                 // Grapple validation
│   │   │   ├── physics-engine.ts                    // Physics engine
│   │   │   └── position-sync.ts                     // Position sync
│   │   ├── player/
│   │   │   ├── player-manager.ts                    // Player manager
│   │   │   ├── spawn-system.ts                      // Spawn system
│   │   │   ├── death-system.ts                      // Death system
│   │   │   ├── stats-manager.ts                     // Stats manager
│   │   │   └── session-manager.ts                   // Session manager
│   │   ├── game-state/
│   │   │   ├── match-manager.ts                     // Match manager
│   │   │   ├── round-controller.ts                  // Round controller
│   │   │   └── spawn-manager.ts                     // Spawn manager
│   │   └── anti-cheat/
│   │       ├── speed-checker.ts                     // Speed checking
│   │       ├── teleport-checker.ts                  // Teleport detection
│   │       ├── exploit-logger.ts                    // Exploit logging
│   │       └── rate-limiter.ts                      // Rate limiting
│   │
│   ├── components/
│   │   ├── combat-component.ts                      // Combat component
│   │   ├── movement-component.ts                    // Movement component
│   │   └── player-component.ts                      // Player component
│   │
│   ├── network/
│   │   ├── middleware/
│   │   │   ├── core/
│   │   │   │   ├── logging-middleware.ts            // Logging
│   │   │   │   ├── timing-middleware.ts             // Timing
│   │   │   │   ├── error-handler-middleware.ts      // Error handling
│   │   │   │   └── metrics-middleware.ts            // Metrics
│   │   │   ├── validation/
│   │   │   │   ├── schema-validator.ts              // Schema validation
│   │   │   │   ├── sanitizer.ts                     // Input sanitization
│   │   │   │   ├── bounds-checker.ts                // Bounds checking
│   │   │   │   └── timestamp-validator.ts           // Timestamp validation
│   │   │   ├── anti-cheat/
│   │   │   │   ├── rate-limiter.ts                  // Rate limiting
│   │   │   │   ├── speed-check.ts                   // Speed checking
│   │   │   │   ├── teleport-detection.ts            // Teleport detection
│   │   │   │   ├── sequence-validator.ts            // Sequence validation
│   │   │   │   └── exploit-detector.ts              // Exploit detection
│   │   │   ├── authorization/
│   │   │   │   ├── state-checker.ts                 // State checking
│   │   │   │   ├── cooldown-enforcer.ts             // Cooldown enforcement
│   │   │   │   └── permission-checker.ts            // Permission checking
│   │   │   └── index.ts                             // Export all
│   │   ├── handlers/
│   │   │   ├── combat-handlers.ts                   // Combat handlers
│   │   │   ├── movement-handlers.ts                 // Movement handlers
│   │   │   └── game-handlers.ts                     // Game handlers
│   │   ├── broadcaster.ts                           // Packet broadcaster
│   │   └── setup.ts                                 // Network setup
│   │
│   └── data/
│       └── player-data-store.ts                     // DataStore wrapper
│
│
└── client/
    ├── runtime/
    │   └── init.client.ts                           // Client entry
    │
    ├── systems/
    │   ├── combat/
    │   │   ├── combat-controller.ts                 // Combat controller
    │   │   ├── attack-predictor.ts                  // Attack prediction
    │   │   ├── weapon-animator.ts                   // Weapon animations
    │   │   └── hit-feedback.ts                      // Hit feedback
    │   ├── movement/
    │   │   ├── grapple-controller.ts                // Grapple controller
    │   │   ├── grapple-predictor.ts                 // Grapple prediction
    │   │   ├── camera-controller.ts                 // Camera controller
    │   │   └── movement-animator.ts                 // Movement animations
    │   ├── input/
    │   │   ├── input-manager.ts                     // Input manager
    │   │   ├── keyboard-handler.ts                  // Keyboard handler
    │   │   ├── mouse-handler.ts                     // Mouse handler
    │   │   └── input-buffer.ts                      // Input buffer
    │   ├── game-state/
    │   │   ├── state-controller.ts                  // State controller
    │   │   ├── menu-state.ts                        // Menu state
    │   │   ├── playing-state.ts                     // Playing state
    │   │   ├── death-state.ts                       // Death state
    │   │   └── transition-manager.ts                // State transitions
    │   └── effects/
    │       ├── visual-effects/
    │       │   ├── sword-trails.ts                  // Sword trails
    │       │   ├── grapple-rope.ts                  // Grapple rope
    │       │   ├── hit-particles.ts                 // Hit particles
    │       │   └── damage-numbers.ts                // Damage numbers
    │       └── audio-effects/
    │           ├── combat-sounds.ts                 // Combat audio
    │           └── movement-sounds.ts               // Movement audio
    │
    ├── network/
    │   ├── middleware/
    │   │   ├── core/
    │   │   │   ├── logging-middleware.ts            // Logging
    │   │   │   ├── timing-middleware.ts             // Latency tracking
    │   │   │   └── error-handler-middleware.ts      // Error handling
    │   │   ├── qos/
    │   │   │   ├── packet-queue.ts                  // Packet queueing
    │   │   │   ├── retry-middleware.ts              // Packet retry
    │   │   │   └── priority-sorter.ts               // Packet priority
    │   │   ├── prediction/
    │   │   │   ├── rollback-middleware.ts           // Rollback
    │   │   │   └── reconciliation.ts                // Reconciliation
    │   │   └── index.ts                             // Export all
    │   ├── listeners/
    │   │   ├── combat-listeners.ts                  // Combat listeners
    │   │   ├── movement-listeners.ts                // Movement listeners
    │   │   └── game-listeners.ts                    // Game listeners
    │   └── setup.ts                                 // Network setup
    │
    ├── ui/
    │   ├── app.tsx                                  // Root component
    │   ├── store/
    │   │   ├── index.ts                             // Store config
    │   │   ├── actions/
    │   │   │   ├── game-actions.ts                  // Game actions
    │   │   │   ├── player-actions.ts                // Player actions
    │   │   │   └── combat-actions.ts                // Combat actions
    │   │   ├── reducers/
    │   │   │   ├── index.ts                         // Combined reducers
    │   │   │   ├── game-reducer.ts                  // Game reducer
    │   │   │   ├── player-reducer.ts                // Player reducer
    │   │   │   └── combat-reducer.ts                // Combat reducer
    │   │   └── selectors/
    │   │       ├── game-selectors.ts                // Game selectors
    │   │       └── player-selectors.ts              // Player selectors
    │   ├── screens/
    │   │   ├── main-menu.tsx                        // Main menu
    │   │   ├── death-screen.tsx                     // Death screen
    │   │   └── loading-screen.tsx                   // Loading screen
    │   ├── hud/
    │   │   ├── health-bar.tsx                       // Health bar
    │   │   ├── combo-counter.tsx                    // Combo counter
    │   │   ├── crosshair.tsx                        // Crosshair
    │   │   └── killboard.tsx                        // Kill feed
    │   └── components/
    │       ├── button.tsx                           // Button component
    │       ├── progress-bar.tsx                     // Progress bar
    │       └── animated-text.tsx                    // Animated text
    │
    └── prediction/
        ├── state-predictor.ts                       // State prediction
        ├── movement-reconciliation.ts               // Movement reconciliation
        └── combat-reconciliation.ts                 // Combat reconciliation


tests/
├── shared/
│   ├── math.spec.ts                                 // Math tests
│   ├── combat-utils.spec.ts                         // Combat tests
│   └── validation.spec.ts                           // Validation tests
├── server/
│   ├── combat-system.spec.ts                        // Combat system tests
│   ├── grapple-system.spec.ts                       // Grapple system tests
│   └── middleware.spec.ts                           // Middleware tests
└── client/
    ├── prediction.spec.ts                           // Prediction tests
    └── state-machine.spec.ts                        // State machine tests
```