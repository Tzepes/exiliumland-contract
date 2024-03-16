const ExiliumLand = artifacts.require('ExiliumLand');

contract('ExiliumLand', (accounts) => {
    
    it('should credit an NFT to a specific account', async () => {
        const exiliumLand = await ExiliumLand.deployed();
        await exiliumLand.safeMint(accounts[1], 'exiliumland_1.json', 1, 1);
        console.log(exiliumLand.ownerOf(0));
    });
});