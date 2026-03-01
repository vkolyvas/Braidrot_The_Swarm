# Braidrot The Swarm

*A Roblox Tycoon/Swarm Action Game*

---

## The Story

<img width="1408" height="768" alt="Image" src="https://github.com/user-attachments/assets/c29e4e78-0187-4e0c-bfa9-efd6b6219cd3" />

In the forgotten lands of Robloxia, ancient spores drifted through the void, carrying the seeds of an extraordinary creature—the **Braidrot**. These are not ordinary beings; they are sentient tangles of bioluminescent fungi, twisted vines, and mossy roots that pulse with an eerie, magical energy. The first adventurer to discover their origin was a young explorer who stumbled upon a glowing, pulsating mass hidden deep within an ancient forest. This creature, later known as **Mother the Knot**, became the foundation of an entire swarm. As the explorer befriended the Braidrots, they realized these small, many-eyed creatures could be trained, evolved, and commanded. Now, players around the world race to build the mightiest swarm, gathering Braidrots across dangerous worlds, evolving them from tiny Rotlets into massive, world-shaking Collosuses. The ultimate question remains: who will control the swarm that could conquer the universe?

---

## The Braidrot Anatomy

<img width="1408" height="752" alt="Image" src="https://github.com/user-attachments/assets/8658d271-b2ed-4f8d-9b3a-388a73b31228" />

Every Braidrot shares the same mysterious biological structure. At their core lies an **Orange Energy Heart** that pulses with life, wrapped in layers of **Green Living Moss** that forms their protective skin. Their most striking features are the **Purple Glowing Eyes** scattered across their body—these are not just视觉 organs but also windows into their souls. Trailing behind each Braidrot are **Purple Root Nerves** that function like a nervous system, sending signals throughout their bodies as they bounce and wobble through the world. This unique anatomy allows them to adapt, evolve, and merge with other Braidrots to form more powerful variants.

---

## Analysis: From Concept to Game

<img width="1408" height="752" alt="Image" src="https://github.com/user-attachments/assets/0d36d94b-e512-47bc-b69a-f6fa81687588" />

The journey of creating Braidrot The Swarm began with a single inspiration The Swarm. This concept art showed dozens of tiny, cute, blob-like creatures swarming together—each one small individually, but overwhelming in numbers. This sparked the core game mechanic: **"many-versus-one"** creatures that spawn, swarm, and evolve together.

### The Spawning System

<img width="1408" height="752" alt="Image" src="https://github.com/user-attachments/assets/b96dfeef-113d-4582-a4ab-fe3b4873a1d2" />

The **Mother-Knot** serves as the heart of the swarm—the main spawner object that players place in their base. Looking like a massive, glowing, pulsating mass of intertwined roots, the Mother-Knot automatically generates **1-2 Rotlets every 10 seconds**, with a maximum cap of 10 units at the start. Players can upgrade the Mother-Knot through four evolution stages: **Root Expansion** → **Dense Thicket** → **Ancient Grove** → **Forest Primeval**, each increasing spawn rate and max unit count.

For more aggressive play, the **Spore Burst** ability (Q Key) lets players spend **25 Energy** to instantly summon a wave of **5 Rotlets**. This active spawning system rewards resource management and creates exciting combat moments.

### Evolution Tree: From Tiny to Massive

<img width="1376" height="768" alt="Image" src="https://github.com/user-attachments/assets/5938fc6e-d7bf-47aa-8441-8411a87a67f8" />

The Rotlet is just the beginning. When players accumulate **10 Rotlets**, they can choose an evolution path:

| Path | Unit | Role | Abilities |
|------|------|------|-----------|
| **Tank** | Bulker | Massive protector | Vine-Guard (shield), Stomp (AoE slow) |
| **Ranged** | Spitter | Long-range attacker | Spore Shot (projectile), Cloud Burst (vision obscure) |
| **Mobility** | Runner | Fast scout | Haste Aura (speed boost), Tackle (stun) |

The ultimate goal? Merge **50 Rotlets + 5 of each Tier 2 unit** to spawn **The Colossus**—a building-sized ancient forest creature that can summon mini-Rotlets as projectiles, trap enemies in root webs, and slam the ground with nature's wrath.

---

## World Progression: Collecting & Evolving

As players build their swarm, they journey through **8 dangerous worlds**, each with unique environmental hazards:

| World | Hazards | Challenge |
|-------|---------|-----------|
| 🌨️ **Ice World** | Slippery platforms, Spikes | Slide and fall avoidance |
| 🌋 **Lava World** | Rising lava, Fire traps | Damage over time survival |
| 🧪 **Acid World** | Acid pools, Spikes | Instant death traps |
| 🔥 **Fire World** | Fire bursts, The Void | Timed flame dodges |
| 🌊 **Water World** | Sinking water, Electric currents | Swimming mechanics |
| 💨 **Wind World** | Strong wind gusts, Spikes | Knockback resistance |
| ⚡ **Electric World** | Electrical grids, The Void | High-voltage danger |
| 💎 **Diamond Universe** | All hazards combined | Ultimate challenge |

In each world, players collect **Braidrots**—special companion creatures that generate Coins Per Second (CPS), provide passive abilities, and can be upgraded and evolved. From the basic **Rap-Rap-Rap** and **Sagur** to the legendary **Dragon with Cinnamon**, these collectibles make the tycoon aspect come alive while the swarm battles through hazards.

---

## The Final Boss: Diamond Overlord

Deep within the **Diamond Universe** awaits the ultimate challenge: the **Diamond Overlord**—a colossal Braidrot entity with **1,000,000 Health** that combines every hazard type imaginable. Defeating this monstrosity requires a fully evolved swarm with Bulker tanks, Spitter DPS, Runner scouts, and ideally a Colossus to match its power. The reward? **Dragon with Cinnamon** (the ultimate collectible), **Infinite Eggs**, and **1,000 Diamonds**.

But the true victory isn't just the loot—it's commanding a swarm that started as tiny, wobbling Rotlets and grew into an unstoppable force of nature. Will your Braidrots rise to become the ultimate swarm?

<img width="1376" height="768" alt="Image" src="https://github.com/user-attachments/assets/245a2906-6db7-4f00-bef9-091553c02106" />

---

## Assets

### Concept Art
- **Swarm Concept**: `Braidrot_the_swarm.png`
- **Anatomy**: `Braidrot_anatomy.png`
- **Colossus**: `Braidrot_the_Colossus.png`

### Unit Renders
| Unit | Image |
|------|-------|
| Mother-Knot | `Boss_Mother_the_knot.png` |
| Dad (Helper) | `Boss_Dad_the_knot.png` |
| Rotlet | `Boss_Rotlet.png` |
| Runner | `Boss_Runner.png` |
| Spitter | `Boss_Spitter.png` |
| Bulker | `Boss_Bulker.png` |
| Colossus | `Boss_The_Colossus.png` |

---

## Game Modules

This repository contains the complete Lua module system for Roblox Studio:

- **BraidrotCreatureSystem.lua** - Complete creature definitions (Collectibles + Swarm Units)
- **BraidrotData.lua** - Original collectible Braidrot data
- **EconomyManager.lua** - Currency handling
- **EggSystem.lua** - Egg hatching with probabilities
- **UpgradeSystem.lua** - Upgrades, fusion, evolution
- **SpeedBoost.lua** - Collection speed upgrades
- **HazardSystem.lua** - Environmental hazards
- **RebirthSystem.lua** - Prestige mechanics
- **BossSystem.lua** - Boss spawns and challenges
- **LeaderboardSystem.lua** - Social rankings
- **WorldManager.lua** - World progression

---

*Build your swarm. Evolve your creatures. Conquer every world.*
