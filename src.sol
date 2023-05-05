pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/utils/Counters.sol";

contract ArtworkNFT is ERC721 {
    using Counters for Counters.Counter;
    Counters.Counter private _tokenIds;

    struct Artwork {
        uint256 id;
        string title;
        address artist;
        uint256 royaltyPercentage;
    }

    mapping(uint256 => Artwork) private _artworks;

    event ArtworkTokenized(uint256 tokenId, string title, address artist);

    constructor() ERC721("GeneratedArt", "GART") {}

    function tokenizeArtwork(
        address artist,
        string memory title,
        uint256 royaltyPercentage
    ) public returns (uint256) {
        require(royaltyPercentage > 0 && royaltyPercentage <= 100, "Invalid royalty percentage");
        _tokenIds.increment();
        uint256 newItemId = _tokenIds.current();
        _mint(artist, newItemId);

        _artworks[newItemId] = Artwork({
            id: newItemId,
            title: title,
            artist: artist,
            royaltyPercentage: royaltyPercentage
        });

        emit ArtworkTokenized(newItemId, title, artist);

        return newItemId;
    }

    function getArtwork(uint256 tokenId) public view returns (Artwork memory) {
        return _artworks[tokenId];
    }

    // Implement custom licensing, distribution of proceeds, and other functionality here
}
