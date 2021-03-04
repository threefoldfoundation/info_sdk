# Quantum-safe Storage system

![](img/archi_qsfs.png)

- Even quantum computers cannot hack and "decrypt" data
- data can never be lost, unlimited history, auditing on digital ledger layer
- 10x less power utilization (green)
- data distributed in controlled way over X nr of chosen locations, but none of the locations has enough data to reconstruct the original = super reliable/safe


## How to make storage quantum safe

### Old-school storage 

A storage system needs to meet the following main requirements : 

- Reliability: the storage should remain available even with hardware unavailability of ex. up to any 4 nodes
- Data Privacy

The classic recipes to make this happen are
- For reliability: make 4 copies of the original
- For Data Privacy: encryption of the data

![](img/archi_storage_oldschool.png)
This approach has quite some disadvantages :

- 4 copies of one source leads to 400% overhead 
- 5 times the bandwidth is  required to store on multiple locations
- A hacker only needs to have one copy of the original, so he only needs to hack himself into one location

### The ThreeFold approach : Quantum-safe storage

![](img/archi_storage_dispersed.png)
