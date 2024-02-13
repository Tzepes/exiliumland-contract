// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/token/ERC721/extensions/ERC721URIStorage.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract ExiliumLand is ERC721, ERC721URIStorage, Ownable {
    uint256 private _nextTokenId;

    struct Parcel {
        address ownerEthAddress;
        ParcelMatrID matrID;
    }

    struct ParcelMatrID {
        uint256 x;
        uint256 y;
    }

    struct ParcelProperties{
        Resources resources;
        uint8 population;
        uint8 terraformProgress;
    }

    struct Resources {
        Minerals minerals;
        NaturalResources natResources;
    }

    struct Minerals {
        uint8 iron;
        uint8 aluminum;
        uint8 titanium;
        uint8 copper;
        uint8 silver;
        uint8 gold;
    }

    struct NaturalResources {
        uint8 liquidWater;
        uint8 ice;
        uint8 naturalGas;
    }

    mapping(uint256 => Parcel) public parcels;
    mapping(uint256 => mapping(uint256 => bool)) public parcelOwnedAtLocation;

    uint256 public constant MATRIX_SIZE = 316; 
    uint256 public constant MAX_PARCELS = MATRIX_SIZE * MATRIX_SIZE;
    uint256 public totalParcels;

    constructor(address initialOwner)
        ERC721("ExiliumLand", "EXL")
        Ownable(initialOwner)
    {}

    function _baseURI() internal pure override returns (string memory) {
        return "https://white-cheerful-dormouse-841.mypinata.cloud/ipfs/QmQhkgdPsehHhwVpkLGjtcXjrkGWwNXY8uv4KnrVbPk9kZ";
    }

    function safeMint(address to, string memory uri, uint256 _x, uint256 _y) public onlyOwner {
        require(totalParcels < MAX_PARCELS, "Maximum parcels reached");
        require(!parcelOwnedAtLocation[_x][_y], "Chosen parcel already exists");

        uint256 tokenId = _nextTokenId++;
        Parcel memory newParcel = Parcel(msg.sender, ParcelMatrID(_x, _y));

        parcels[tokenId] = newParcel;
        parcelOwnedAtLocation[_x][_y] = true;
        
        _safeMint(to, tokenId);
        _setTokenURI(tokenId, uri);

    }

    // The following functions are overrides required by Solidity.

    function tokenURI(uint256 tokenId)
        public
        view
        override(ERC721, ERC721URIStorage)
        returns (string memory)
    {
        return super.tokenURI(tokenId);
    }

    function supportsInterface(bytes4 interfaceId)
        public
        view
        override(ERC721, ERC721URIStorage)
        returns (bool)
    {
        return super.supportsInterface(interfaceId);
    }
}