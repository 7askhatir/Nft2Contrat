  // SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC721/extensions/ERC721Enumerable.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/utils/Strings.sol";
import "@openzeppelin/contracts/utils/math/SafeMath.sol";



contract NFT is ERC721Enumerable, Ownable {
  using Strings for uint256;
  using SafeMath for uint256;
  string baseURI;
  string public baseExtension = ".json";
  uint256 public cost = 0.05 ether;   
  uint256 public maxSupply = 10000;
  uint256 public maxMintAmount = 20;
  uint256 public maxMintInMonth=10;
  bool public paused = false;
  bool public revealed = false;
  string public notRevealedUri;
  uint8 public constant Bronze=1;
  uint8 public constant Silver=2;
  uint8 public constant Gold=3;
  uint8 public constant Diamond=4;
  uint256 public MaxBronze=100;
  uint256 public MaxSilver=200;
  uint256 public MaxGold=300;
  uint256 public MaxDiamond=400;
  uint256 tokenId=1;
  uint8 public maxheartsForSimpleNft=5;
  uint  public maxheartsForShieldNft=maxheartsForSimpleNft*2;

  struct Nft{
    uint id;
    uint level;
    uint256 hearts;
    uint256 points;
    bool Shield;
  }
  event ChargeHearts(uint tokenId);

  Nft[] public nfts;
  mapping (uint => Nft) public nftPropriety;
  mapping (address =>uint) nuberBoxByOwner;
  constructor(
    string memory _name,
    string memory _symbol,
    string memory _initBaseURI,
    string memory _initNotRevealedUri
  ) ERC721(_name, _symbol) {
    setBaseURI(_initBaseURI);
    setNotRevealedURI(_initNotRevealedUri);
  }

   function changeMaxLevel(uint256 _MaxBronze, uint256 _MaxSilver,uint256 _MaxGold,uint256 _MaxDiamond) public onlyOwner{
       MaxBronze=_MaxBronze;
       MaxSilver=_MaxSilver;
       MaxGold=_MaxGold;
       MaxDiamond=_MaxDiamond;
  }

  function ByBox() public {
     nuberBoxByOwner[msg.sender]++;
  }
 //////////////// Ereeeeer in logique
    function mint(uint _level) public  {
      require(_level>=1 && _level<5,"this level not existed");
      require(maxByLevel(_level)>numberNftByLevel(_level),"number nft for this level >MaxLevel");
      require(nuberBoxByOwner[msg.sender]>0,"You don't have boxes");
        _safeMint(msg.sender,tokenId);
        Nft memory nft = Nft(tokenId,_level,0,5,true);
        nfts.push(nft);
        tokenId++;              
        nuberBoxByOwner[msg.sender]--; 
  }
  
  function numberNftByLevel(uint256 _level) public view returns(uint256){
      uint256 numberByLevel=0;
      for(uint indexOfArrayNfts=0;indexOfArrayNfts<nfts.length;indexOfArrayNfts++)
      if(nfts[indexOfArrayNfts].level==_level)
       numberByLevel++;
       return numberByLevel;
  }
  function chargeHearts(uint _tokenId) public {
    require(ownerOf(_tokenId)==msg.sender,"your are not owner of this nft");
    require(getNftById(_tokenId).hearts==0,"You still have hearts");
    uint NumberOfHearts=0;
    if(getNftById(_tokenId).Shield) NumberOfHearts=maxheartsForShieldNft;
    else NumberOfHearts=maxheartsForSimpleNft;
    Nft memory newNft=Nft(getNftById(_tokenId).id,getNftById(_tokenId).level,NumberOfHearts,getNftById(_tokenId).points,getNftById(_tokenId).Shield);
    updateNft(_tokenId,newNft);
    emit ChargeHearts(_tokenId);
  }

  function updateNft(uint _tokenId,Nft memory _newNft) public {
     for(uint indexfNft=0;indexfNft<nfts.length;indexfNft++){
       if(nfts[indexfNft].id==_tokenId){
         nfts[indexfNft]=_newNft;
       }
     }
  }

  

  function maxByLevel(uint _level) public view returns(uint256){
    if(_level==Bronze) return MaxBronze;
    if(_level==Silver) return MaxSilver;
    if(_level==Gold) return MaxGold;
    if(_level==Diamond) return MaxDiamond;
  }
  function upLevel() public {
    
  }
  function getNftById(uint256 _tokenId) public view returns(Nft memory nft){
    for(uint indexOfArrayNfts=0;indexOfArrayNfts<nfts.length;indexOfArrayNfts++)
    if(nfts[indexOfArrayNfts].id==_tokenId)
    nft= nfts[indexOfArrayNfts];
  }
  function upgradeNft(uint256 _tokenId) public {
    uint256 level=getNftById(_tokenId).level;
    uint256 points=getNftById(_tokenId).points;
    uint256 shield=getNftById(_tokenId).shield;
    require(level<=Diamond,"this is super level");
    require(ownerOf(_tokenId)==msg.sender,"your are not owner of this nft");
    if(level==1 &&  shield==true){
      require(points==1,"your points not ------- for this transaction");
    }
    if(level==1  && shield==false){
      require(points==1,"your points not ------- for this transaction");
    }
    if(level==2  && shield==false){
      require(points==1,"your points not ------- for this transaction");
    }
    if(level==2  && shield==false){
      require(points==1,"your points not ------- for this transaction");
    }
    if(level==3  && shield==false){
      require(points==1,"your points not ------- for this transaction");
    }
    if(level==4  && shield==false){
      require(points==1,"your points not ------- for this transaction");
    }
    
  }

  





//   function generateDna(string memory _id,string memory _DateTime,string memory level,bool valid) public pure returns(string memory){
//     string memory finalId=_id;
//     string memory finalDate= _DateTime;
//     string memory finalValid="";
//     string memory zero ="0";
//     require(bytes(_id).length<=5);
//     if(bytes(_id).length<=5){
//      for(uint i=0;i<5-bytes(_id).length;i++){
//         finalId = string(abi.encodePacked(zero,finalId));
//      }
//     }
//     require(bytes(_DateTime).length<=10);
//     if(bytes(_DateTime).length<=10){
//       for(uint i=0;i<10-bytes(_DateTime).length;i++){
//          finalDate=string(abi.encodePacked(zero,finalDate));
//       }
//     }
//     require(bytes(level).length==1);
//     if(valid) finalValid="1";
//     else finalValid="0";
//     return string(abi.encodePacked(finalDate,level,finalValid,finalId));
//   }

//   function st2num(string memory numString) public pure returns(uint) {
//         uint  val=0;
//         bytes   memory stringBytes = bytes(numString);
//         for (uint  i =  0; i<stringBytes.length; i++) {
//             uint exp = stringBytes.length - i;
//             bytes1 ival = stringBytes[i];
//             uint8 uval = uint8(ival);
//             uint jval = uval - uint(0x30);
//             val +=  (uint(jval) * (10**(exp-1))); 
//         }
//       return val;
//   }

//   function num2st(uint256 _uint) public pure returns(string memory){
//     return Strings.toString(_uint);
//   }

  // function idFromStract(uint _dna) public view returns()
  

  // function dnaToNftStruct(uint _dna) public pure returns(Nft memory){
   
  //   string memory idString="";
  //   for(uint i=0;i<5;i++){
  //     idString = string(abi.encodePacked(idString, num2st(_dna)));
  //   }
  //   uint id;
    
  // }








  
  // function generateDna() public view returns(uint){
  //     return 1;
  // }
  // internal
  function _baseURI() internal view virtual override returns (string memory) {
    return baseURI;
  }

  // public


  function getAllNfts() public view returns(Nft[] memory){
    return nfts;
  }
  
  function walletOfOwner(address _owner)
    public
    view
    returns (uint256[] memory)
  {
    uint256 ownerTokenCount = balanceOf(_owner);
    uint256[] memory tokenIds = new uint256[](ownerTokenCount);
    for (uint256 i; i < ownerTokenCount; i++) {
      tokenIds[i] = tokenOfOwnerByIndex(_owner, i);
    }
    return tokenIds;
  }

  function tokenURI(uint256 tokenId)
    public
    view
    virtual
    override
    returns (string memory)
  {
    require(
      _exists(tokenId),
      "ERC721Metadata: URI query for nonexistent token"
    );
    
    if(revealed == false) {
        return notRevealedUri;
    }

    string memory currentBaseURI = _baseURI();
    return bytes(currentBaseURI).length > 0
        ? string(abi.encodePacked(currentBaseURI, tokenId.toString(), baseExtension))
        : "";
  }

 

  //only owner
  function reveal() public onlyOwner {
      revealed = true;
  }
  
  function setCost(uint256 _newCost) public onlyOwner {
    cost = _newCost;
  }

  function setmaxMintAmount(uint256 _newmaxMintAmount) public onlyOwner {
    maxMintAmount = _newmaxMintAmount;
  }
  
  function setNotRevealedURI(string memory _notRevealedURI) public onlyOwner {
    notRevealedUri = _notRevealedURI;
  }

  function setBaseURI(string memory _newBaseURI) public onlyOwner {
    baseURI = _newBaseURI;
  }

  function setBaseExtension(string memory _newBaseExtension) public onlyOwner {
    baseExtension = _newBaseExtension;
  }

  function pause(bool _state) public onlyOwner {
    paused = _state;
  }

  function withdraw() public payable onlyOwner {
       // This will payout the SLRM 15% of the contract balance.
    (bool Ss, ) = payable(0xAb8483F64d9C6d1EcF9b849Ae677dD3315835cb2).call{value: msg.sender.balance * 50 / 100}("");
    require(Ss);
    // =============================================================================
     // This will payout the Roward Pool 15% of the contract balance.
    (bool Rs, ) = payable(0x1A42d2D0006f165f260Ae4B1567D7A3a1496a74b).call{value: msg.sender.balance * 15 / 100}("");
    require(Rs);
       // =============================================================================
     // This will payout Bonus Wallet 15% of the contract balance.
    (bool Ws, ) = payable(0xB2cEd26a78c54FE6Cf6791aECAcCE378bbFca3fF).call{value: msg.sender.balance * 15 / 100}("");
    require(Ws);
    // This will payout the owner 20% of the contract balance.
    // (bool os, ) = payable(owner()).call{value: msg.sender.balance}("");
    // require(os);
    // =============================================================================
  }

   function random() public view returns (uint) {
        return uint(keccak256(abi.encodePacked(block.difficulty, block.timestamp))) % 100; 
  }



   
   
  
 

  


}
