  // SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC721/extensions/ERC721Enumerable.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/utils/Strings.sol";
import "@openzeppelin/contracts/utils/math/SafeMath.sol";
import "@openzeppelin/contracts/token/ERC20/ERC20.sol";



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
  // uint256 public MaxBronze=100;
  // uint256 public MaxSilver=200;
  // uint256 public MaxGold=300;
  // uint256 public MaxDiamond=400;
  uint8 public constant Simple=0;
  uint8 public constant T1P=1;
  uint8 public constant T2P=2;
  uint8 public constant T3P=3;
  uint8 public constant T4P=4;
  uint8 public constant T5P=5;
  uint8 public constant T6P=6;
  uint8 public constant T7P=7;
  uint256 tokenId=1;
  uint8 public maxheartsForSimpleNft=5;
  uint  public maxheartsForShieldNft=maxheartsForSimpleNft*2;
  uint256 bronzeNoShieldPoints=50;
  uint256 bronzeShieldPoints=60;
  uint256 silverNoShieldPoints=75;
  uint256 silverShieldPoints=80;
  uint256 goldPoints=80;
  uint256 indexOfNftSimple=1;
  uint256 indexOfNftT1P=1;
  uint256 indexOfNftT2P=1;
  uint256 indexOfNftT3P=1;
  uint256 indexOfNftT4P=1;
  uint256 indexOfNftT5P=1;
  uint256 indexOfNftT6P=1;
  uint256 indexOfNftT7P=1;
  ERC20 tokenAddress;
  struct Nft{
    uint id;
    uint Type;
    uint level;
    uint256 hearts;
    uint256 points;
    bool Shield;
  }
  event ChargeHearts(uint tokenId);
  event NewBox(address owner);
  event UpLevel(uint tokenId);
  Nft[] public nfts;
  mapping (uint => Nft) public nftPropriety;
  mapping (address =>uint) nuberBoxByOwner;
  address ownerT;
  constructor(
    string memory _name,
    string memory _symbol,
    string memory _initBaseURI,
    string memory _initNotRevealedUri,
    address _token
  ) ERC721(_name, _symbol) {
    tokenAddress=ERC20(_token);
    setBaseURI(_initBaseURI);
    setNotRevealedURI(_initNotRevealedUri);
    ownerT=msg.sender;
  }

  //  function changeMaxLevel(uint256 _MaxBronze, uint256 _MaxSilver,uint256 _MaxGold,uint256 _MaxDiamond) public onlyOwner{
  //      MaxBronze=_MaxBronze;
  //      MaxSilver=_MaxSilver;
  //      MaxGold=_MaxGold;
  //      MaxDiamond=_MaxDiamond;
  // }

  function ByBox() public payable{
     nuberBoxByOwner[msg.sender]++;
     emit NewBox(msg.sender);
    //  _safeTransferFrom(
    //     tokenAddress,
    //     msg.sender,
    //     ownerT,
    //     123
    // ) ; 
  }
 //////////////// Ereeeeer in logique
    function mint() public {
      
      // require(nuberBoxByOwner[msg.sender]>0,"You don't have boxes"); 
      Nft memory nft ;
      uint types;
      uint idToken;
      uint rendumNumber=random(999999)%10000;
      if(rendumNumber>=0 && rendumNumber<=4503){
        uint level;
        bool shield;
        uint hearts;
        types=Simple;
        if(rendumNumber>=0 && rendumNumber<=1750){level=Bronze;shield=false;}
        else if(rendumNumber>1750 && rendumNumber<=3500){level=Bronze;shield=true;}
        else if(rendumNumber>3500 && rendumNumber<=4200){level=Silver;shield=false;}
        else if(rendumNumber>4200 && rendumNumber<=4500){level=Silver;shield=true;}
        else if(rendumNumber>4500 && rendumNumber<=4502){level=Gold;shield=true;}
        else if(rendumNumber>4503 && rendumNumber<=4503){level=Diamond;shield=true;}
        shield?hearts=maxheartsForShieldNft:hearts=maxheartsForSimpleNft;
        idToken=generateDna(indexOfNftSimple,types);
        indexOfNftSimple++;
        nft = Nft(idToken,types,level,hearts,0,shield);

      }
      else if(rendumNumber>4503 && rendumNumber<=6603){
        types= T1P;
        idToken=generateDna(indexOfNftT1P,types);
        indexOfNftT1P++;
        nft = Nft(idToken,types,Bronze,10,0,true);

      }
      else if(rendumNumber>6603 && rendumNumber<=8503){
        types=  T2P;
        idToken=generateDna(indexOfNftT2P,types);
        indexOfNftT2P++;
        nft = Nft(idToken,types,Bronze,10,0,true);
      }
      else if(rendumNumber>8503 && rendumNumber<=9303){
        types=  T3P;
        idToken=generateDna(indexOfNftT3P,types);
        indexOfNftT3P++;
        nft = Nft(idToken,types,Silver,10,0,true);

      }
      else if(rendumNumber>9303 && rendumNumber<=9903){
        types=  T4P;
        idToken=generateDna(indexOfNftT4P,types);
        indexOfNftT4P++;
        nft = Nft(idToken,types,Silver,10,0,true);
      }
      else if(rendumNumber>9903 && rendumNumber<=9980){
        types=  T5P;
        idToken=generateDna(indexOfNftT5P,types);
        indexOfNftT5P++;
        nft = Nft(idToken,types,Gold,10,0,true);
      }
       else if(rendumNumber>9980 && rendumNumber<=9990){
        types=  T6P;
        idToken=generateDna(indexOfNftT6P,types);
        indexOfNftT6P++;
        nft = Nft(idToken,types,Gold,10,0,true);

      } 
       else if(rendumNumber>9990 && rendumNumber<=10000){
        types=  T7P;
        idToken=generateDna(indexOfNftT7P,types);
        indexOfNftT7P++;
        nft = Nft(idToken,types,Diamond,10,0,true);

      } 
        _safeMint(msg.sender,idToken);
        nfts.push(nft);
        nuberBoxByOwner[msg.sender]--; 
  }
  
  function numberNftByLevel(uint256 _level) public view returns(uint256){
      uint256 numberByLevel=0;
      for(uint indexOfArrayNfts=0;indexOfArrayNfts<nfts.length;indexOfArrayNfts++)
      if(nfts[indexOfArrayNfts].level==_level)
       numberByLevel++;
       return numberByLevel;
  }


  // thid function for fill nft hearts 
  function chargeHearts(uint _tokenId) public {
    require(ownerOf(_tokenId)==msg.sender,"your are not owner of this nft");
    require(getNftById(_tokenId).hearts==0,"You still have hearts");
    uint NumberOfHearts=0;
    if(getNftById(_tokenId).Shield) NumberOfHearts=maxheartsForShieldNft;
    else NumberOfHearts=maxheartsForSimpleNft;
    Nft memory newNft=Nft(getNftById(_tokenId).id,2,getNftById(_tokenId).level,NumberOfHearts,getNftById(_tokenId).points,getNftById(_tokenId).Shield);
    updateNft(_tokenId,newNft);
    emit ChargeHearts(_tokenId);
  }

  function updateNft(uint _tokenId,Nft memory _newNft) public {
     for(uint indexfNft=0;indexfNft<nfts.length;indexfNft++)
      if(nfts[indexfNft].id==_tokenId)
      nfts[indexfNft]=_newNft;
 
  }


  function getNftById(uint256 _tokenId) public view returns(Nft memory nft){
    for(uint indexOfArrayNfts=0;indexOfArrayNfts<nfts.length;indexOfArrayNfts++)
    if(nfts[indexOfArrayNfts].id==_tokenId)
    nft= nfts[indexOfArrayNfts];
  }


  function upgradeNft(uint256 _tokenId) public {
    uint256 level=getNftById(_tokenId).level;
    uint256 points=getNftById(_tokenId).points;
    bool shield=getNftById(_tokenId).Shield;
    require(level<=Diamond,"this is super level");
    require(ownerOf(_tokenId)==msg.sender,"your are not owner of this nft");

    if(getTypeNftByTokenId(_tokenId)==Simple){
        if(level==Bronze &&  shield==false){
          // require(points==bronzeNoShieldPoints,"your points not ------- for this transaction");
          Nft memory newNft=Nft(getNftById(_tokenId).id,2,getNftById(_tokenId).level,getNftById(_tokenId).hearts,0,true);
          updateNft(_tokenId,newNft);
        }
        else if(level==Bronze  && shield==true){
          require(points==bronzeShieldPoints,"your points not ------- for this transaction");
          Nft memory newNft=Nft(getNftById(_tokenId).id,2,Silver,getNftById(_tokenId).hearts,0,false);
          updateNft(_tokenId,newNft);
        }
        else if(level==Silver  && shield==false){
          require(points==silverNoShieldPoints,"your points not ------- for this transaction");
          Nft memory newNft=Nft(getNftById(_tokenId).id,2,getNftById(_tokenId).level,getNftById(_tokenId).hearts,0,true);
          updateNft(_tokenId,newNft);
        }
        else if(level==Silver  && shield==true){
          require(points==1,"your points not ------- for this transaction");
          Nft memory newNft=Nft(getNftById(_tokenId).id,2,Gold,getNftById(_tokenId).hearts,0,true);
          updateNft(_tokenId,newNft);
        }
        else if(level==Gold  && shield==true){
          require(points==silverShieldPoints,"your points not ------- for this transaction");
          Nft memory newNft=Nft(getNftById(_tokenId).id,2,Diamond,getNftById(_tokenId).hearts,0,true);
          updateNft(_tokenId,newNft);
        }
    }
    else if(getTypeNftByTokenId(_tokenId)==T1P){
      transferFrom(msg.sender,address(this),_tokenId);
      uint idToken=generateDna(indexOfNftT2P,T2P);
      indexOfNftT2P++;
      nfts.push(Nft(idToken,T2P,Bronze,10,0,true));
      _safeMint(msg.sender,idToken);
    }
    else if(getTypeNftByTokenId(_tokenId)==T2P){
      transferFrom(msg.sender,address(this),_tokenId);
      uint idToken=generateDna(indexOfNftT3P,T3P);
      indexOfNftT3P++;
      nfts.push(Nft(idToken,T3P,Silver,10,0,true));
      _safeMint(msg.sender,idToken);
    }
    else if(getTypeNftByTokenId(_tokenId)==T3P){
      transferFrom(msg.sender,address(this),_tokenId);
      uint idToken=generateDna(indexOfNftT4P,T4P);
      indexOfNftT4P++;
      nfts.push(Nft(idToken,T4P,Silver,10,0,true));
      _safeMint(msg.sender,idToken);
    }
    else if(getTypeNftByTokenId(_tokenId)==T4P){
        transferFrom(msg.sender,address(this),_tokenId);
        uint idToken=generateDna(indexOfNftT5P,T5P);
        indexOfNftT5P++;
        nfts.push(Nft(idToken,T5P,Gold,10,0,true));
        _safeMint(msg.sender,idToken);
    }
    else if(getTypeNftByTokenId(_tokenId)==T5P){
        transferFrom(msg.sender,address(this),_tokenId);
        uint idToken=generateDna(indexOfNftT6P,T6P);
        indexOfNftT6P++;
        nfts.push(Nft(idToken,T6P,Gold,10,0,true));
        _safeMint(msg.sender,idToken);
    }
    else if(getTypeNftByTokenId(_tokenId)==T6P){
        transferFrom(msg.sender,address(this),_tokenId);
        uint idToken=generateDna(indexOfNftT7P,T7P);
        indexOfNftT7P++;
        nfts.push(Nft(idToken,T7P,Diamond,10,0,true));
        _safeMint(msg.sender,idToken);
    }
    emit UpLevel(_tokenId);
  }

   function _safeTransferFrom(
        ERC20 token,
        address sender,
        address recipient,
        uint amount
    ) private {
        require(sender != address(0),"address of sender Incorrect ");
        bool sent = token.transferFrom(sender, recipient, amount);
        require(sent, "Token transfer failed");
    }
    function random(uint number) public view returns(uint){
        return uint(keccak256(abi.encodePacked(block.timestamp,block.difficulty,  
        msg.sender))) % number;
    }




  function generateDna(uint _id,uint _type) public pure returns(uint){
      return st2num(string(abi.encodePacked(num2st(_id),num2st(_type))));
  }

  function st2num(string memory numString) public pure returns(uint) {
        uint  val=0;
        bytes   memory stringBytes = bytes(numString);
        for (uint  i =  0; i<stringBytes.length; i++) {
            uint exp = stringBytes.length - i;
            bytes1 ival = stringBytes[i];
            uint8 uval = uint8(ival);
            uint jval = uval - uint(0x30);
            val +=  (uint(jval) * (10**(exp-1))); 
        }
      return val;
  }

  function num2st(uint256 _uint) public pure returns(string memory){
    return Strings.toString(_uint);
  }
  function getTypeNftByTokenId(uint _tokenId) pure public returns(uint Type) {
    Type=_tokenId%10;
  }

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

  function tokenURI(uint256 _tokenId)
    public
    view
    virtual
    override
    returns (string memory)
  {
    require(
      _exists(_tokenId),
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

  // function withdraw() public payable onlyOwner {
  //      // This will payout the SLRM 15% of the contract balance.
  //   (bool Ss, ) = payable(0xAb8483F64d9C6d1EcF9b849Ae677dD3315835cb2).call{value: msg.sender.balance * 50 / 100}("");
  //   require(Ss);
  //   // =============================================================================
  //    // This will payout the Roward Pool 15% of the contract balance.
  //   (bool Rs, ) = payable(0x1A42d2D0006f165f260Ae4B1567D7A3a1496a74b).call{value: msg.sender.balance * 15 / 100}("");
  //   require(Rs);
  //      // =============================================================================
  //    // This will payout Bonus Wallet 15% of the contract balance.
  //   (bool Ws, ) = payable(0xB2cEd26a78c54FE6Cf6791aECAcCE378bbFca3fF).call{value: msg.sender.balance * 15 / 100}("");
  //   require(Ws);
  //   // This will payout the owner 20% of the contract balance.
  //   // (bool os, ) = payable(owner()).call{value: msg.sender.balance}("");
  //   // require(os);
  //   // =============================================================================
  // }

  



   
   
  
 

  


}
