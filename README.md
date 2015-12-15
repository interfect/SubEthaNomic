# SubEthaNomic

This repo contains the materials I'm using to launch a Nomic on the Ethereum blockchain.

The contract in `nomic.sol` has been deployed at 0xcc0ee510bc4b5cd4d31da49f672ab5aa6806f70a

The ABI for the contract is below:

```
[{"constant":true,"inputs":[{"name":"","type":"uint256"}],"name":"proposals","outputs":[{"name":"description","type":"string"},{"name":"ipfsHash","type":"string"},{"name":"isUpgrade","type":"bool"},{"name":"upgradeAddress","type":"address"},{"name":"proposalPassed","type":"bool"},{"name":"proposalFailed","type":"bool"},{"name":"numberOfVotes","type":"uint32"}],"type":"function"},{"constant":true,"inputs":[],"name":"name","outputs":[{"name":"","type":"string"}],"type":"function"},{"constant":false,"inputs":[{"name":"proposalNumber","type":"uint256"}],"name":"executeProposal","outputs":[],"type":"function"},{"constant":true,"inputs":[],"name":"totalSupply","outputs":[{"name":"supply","type":"uint256"}],"type":"function"},{"constant":true,"inputs":[],"name":"founder","outputs":[{"name":"","type":"address"}],"type":"function"},{"constant":false,"inputs":[{"name":"_address","type":"address"}],"name":"removePlayer","outputs":[],"type":"function"},{"constant":true,"inputs":[{"name":"_address","type":"address"}],"name":"balanceOf","outputs":[{"name":"balance","type":"uint256"}],"type":"function"},{"constant":true,"inputs":[],"name":"isSetup","outputs":[{"name":"","type":"bool"}],"type":"function"},{"constant":true,"inputs":[],"name":"symbol","outputs":[{"name":"","type":"string"}],"type":"function"},{"constant":false,"inputs":[{"name":"_to","type":"address"},{"name":"_value","type":"uint256"}],"name":"transfer","outputs":[{"name":"_success","type":"bool"}],"type":"function"},{"constant":false,"inputs":[{"name":"_address","type":"address"}],"name":"addPlayer","outputs":[],"type":"function"},{"constant":true,"inputs":[{"name":"","type":"address"}],"name":"isPlaying","outputs":[{"name":"","type":"bool"}],"type":"function"},{"constant":false,"inputs":[{"name":"_description","type":"string"},{"name":"_ipfsHash","type":"string"},{"name":"_isUpgrade","type":"bool"},{"name":"_upgradeAddress","type":"address"}],"name":"newProposal","outputs":[{"name":"proposalID","type":"uint256"}],"type":"function"},{"constant":false,"inputs":[{"name":"proposalNumber","type":"uint256"},{"name":"supportsProposal","type":"bool"}],"name":"vote","outputs":[],"type":"function"},{"constant":false,"inputs":[],"name":"startGame","outputs":[],"type":"function"},{"constant":true,"inputs":[],"name":"totalPlayers","outputs":[{"name":"","type":"uint32"}],"type":"function"},{"inputs":[{"name":"_name","type":"string"},{"name":"_symbol","type":"string"}],"type":"constructor"},{"anonymous":false,"inputs":[{"indexed":true,"name":"from","type":"address"},{"indexed":true,"name":"to","type":"address"},{"indexed":false,"name":"value","type":"uint256"}],"name":"Transfer","type":"event"},{"anonymous":false,"inputs":[{"indexed":false,"name":"proposalID","type":"uint256"},{"indexed":false,"name":"description","type":"string"},{"indexed":false,"name":"ipfsHash","type":"string"},{"indexed":false,"name":"isUpgrade","type":"bool"},{"indexed":false,"name":"upgradeAddress","type":"address"}],"name":"ProposalAdded","type":"event"},{"anonymous":false,"inputs":[{"indexed":false,"name":"proposalID","type":"uint256"},{"indexed":false,"name":"voter","type":"address"},{"indexed":false,"name":"position","type":"bool"}],"name":"Voted","type":"event"},{"anonymous":false,"inputs":[{"indexed":false,"name":"proposalID","type":"uint256"},{"indexed":false,"name":"passed","type":"bool"}],"name":"ProposalClosed","type":"event"}]
```

With both of these (and Mist's 0.3.7 wallet release), you can interact with the contract on Ethereum.

## How to play

1. Download and extract the [Mist Browser](https://github.com/ethereum/mist/releases/tag/0.3.6). Note that you **must** use 0.3.6; the 0.3.7 Mist release includes only a wallet, and not a dapp browser. (You can have both Mists installed, as long as only one is running at a time, and they will share the Ethereum wallet and blockchain data.)

2. Run Mist.

3. Set up an Ethereum account and get some Ether, if you haven't done so already.

4. Go to the "Browse" option on the left in Mist, and then enter `https://interfect.github.io/SubEthaNomic/` in the URL bar.

5. Due to a bug in Mist, the dapp won't work until you add it to Mist. **Make sure to press the "+" button at the far right next to the account picker!**

6. Once the dapp is added, grant it access to one of your accounts. It's perfectly safe; Mist will prompt you for confirmation before taking any actions that could result in spending Ether.

7. Once you do this, the app should boot up. Your address should appear next to "Account", and the game state should populate. Once that happens, you can use the UI on the lower right to take any of the actions you are authorized to take (and that have had UI code implemented).

## Actually Signing Up

If you can get this far, send a Reddit message to /u/Interfect with your chosen address and your current "Player status" as reported by the dapp. Once everyone has gotten this far, the game can start.


