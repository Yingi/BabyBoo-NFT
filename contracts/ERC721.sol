pragma solidity ^0.8.2;

contract ERC721{

    event Approval(address indexed _owner, address indexed _approved, uint256 _tokenId);
    event Transfer(address indexed _from, address indexed _to, uint256 _tokenId);
    mapping(address => uint256) internal _balances;
    mapping(uint256 => address) internal _owners;

    mapping(address => mapping(address => bool)) private _operatorApprovals;

    event ApprovalForAll(address indexed _owner, address indexed _operator, bool _approved);
    mapping(uint256 => address) private _tokenApprovals;

    //balanceOf function returns the number of NFTs assigned to an owner
    function balanceOf(address owner) public view returns(uint256) {

        //we have to check that the address is not equal to zero and if its zero, we Output the word 'Address is Zero'
        require(owner != address(0), "Address is Zero");
        return _balances[owner];

    }

    //Below function finds the owner of an NFT via TokenID
    function ownerOf(uint256 tokenId) public view returns(address){
        address owner = _owners[tokenId];
        //If an NFT is assigned to a zero address, throw an error. Because if token Id is assigned to a null address, then automatically Token is invalid and it does not exist
        require(owner != address(0), "Token ID does not exist");
        return owner;
    }

    /**
    The term operator has been first introduced by the EIP-721 to define addresses authorized (or approved) by a NFT owner to spend all of his token Ids.

    In EIP-1155, the operator is set by the token owner thanks to the following function :
     */

     // Enables or disables an operator to manage all msg.senders assets
     function setApprovalForAll(address operator, bool approved) public{
         _operatorApprovals[msg.sender][operator] = approved;
         emit ApprovalForAll(msg.sender, operator, approved);
     }

     //Checks if an address is an operator for another address
     function isApprovedForAll(address owner, address operator) public view returns(bool){
         return _operatorApprovals[owner][operator];
     } 

     // This function Updates and approved address for an NFT
     function approve(address to, uint256 tokenId) public {
         address owner = ownerOf(tokenId);
         require(msg.sender == owner || isApprovedForAll(owner, msg.sender), "Msg.sender is not the owner or an approved operator");
         _tokenApprovals[tokenId] = to;
         emit Approval(owner, to, tokenId);

     }

     // Gets the approved address for a single NFT
     function getApproved(uint256 tokenId) public view returns(address) {
         require(_owners[tokenId] != address(0), "Token ID does not exist. NO NFT available");
         return _tokenApprovals[tokenId];
     }

     // Transfers Ownership of an NFT
     function transferFrom(address from, address to, uint256 tokenId) public {
         address owner = ownerOf(tokenId);

         require(msg.sender == owner || 
                getApproved(tokenId) == msg.sender || 
                isApprovedForAll(owner, msg.sender), 
                "Msg.sender is not the owner or approved for Transfer");

        require(owner == from, "From address is not the current owner");
        require(to != address(0), "Address is Zero");
        require(_owners[tokenId] != address(0), "TokenID does not exist");
         //Because we are transfering the token from one person to another, we now have to clear out all the approvals of the previous owner
        approve(address(0), tokenId);
        
        _balances[from] -= 1;
        _balances[to] += 1;
        _owners[tokenId] = to;

        emit Transfer(from, to, tokenId);
     }

     // Standard TransferFrom
     // Checks if onERC721Received is implemented WHEN sending to smart contracts
     function safeTransferFrom(address from, address to, uint256 tokenId, bytes memory _data) public {
         transferFrom(from, to, tokenId);
         require(_checkOnERC721Received(), "Receiver not Implemented");

     }

     function safeTransferFrom(address from, address to, uint256 tokenId) public {
         safeTransferFrom(from, to, tokenId, "");
         

     }

    //Over simplified version
    // Usually we need to call this function of the smart contract that is receiving the NFT
     function _checkOnERC721Received() private pure returns(bool){
         return true;
     }

     // EIP165 : Query if a contract implements another interface
     function supportsInterface(bytes4 interfaceId)public pure virtual returns(bool){
         return interfaceId == 0x80ac58cd;
     }


}