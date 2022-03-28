const {ethers} = require('hardhat');


async function main() {

    // Get the Contract from hardhart
  const BabyBoo = await ethers.getContractFactory('BabyBooCollection');
  const babyBoo = await BabyBoo.deploy("Life of Baby Boo", "BBoo", "https://ipfs.io/ipfs/Qmcna8sWvr9xQyWkxUH5X1r8H2yAz85vh5PE9VArKsN5Ry/");

  await babyBoo.deployed();
  console.log("Success!! Contract was deployed to: ", babyBoo.address);

  // When minting one copy
  //await ukraine.mint('https://ipfs.io/ipfs/JSON_FILE_OF_PHOTO_PINATA');


  // When deploying 10 copies
  await babyBoo.mint(1)
  await babyBoo.mint(1)
  await babyBoo.mint(1)
  
  

  console.log("NFT successfully minted")

}

main()
  .then(() => process.exit(0))
  .catch((error) => {
    console.error(error);
    process.exit(1);
  });
