pragma solidity ^0.4.9;

contract ERC23 {
  uint public totalSupply;
  function balanceOf(address who) constant returns (uint);

  function transfer(address to, uint value) returns (bool ok);
  function transfer(address to, uint value, bytes data) returns (bool ok);
}

contract DataCallContract {
    
    mapping (address=>bool) supportedToken;
    
    modifier tokenPayable {
        if (supportedToken[msg.sender])
            throw;
        _;
    }
    address public owner;
    uint public lastUint;
    bytes public lastData;
    
    bytes4 public signer;
    bytes4 public shaBytes;
    
    function tokenFallback(address _from, uint _value, bytes _data) payable returns (bool result) 
    {
        if(_data.length!=0)
        {
            signer = signerFromData(_data);
            uint256 amount=parseSingleUintArg(_data);
            
            if(signer==bytes4(sha3("buy(uint256,address)")))
            {
                lastUint=amount;
                lastData=_data;
                
                //byu(amount, _from); analogue with delegatecall. 
                return address(this).delegatecall(signer, amount, _from);
            }
        }
    }
    
    function buy(uint256 _amount,address _to)
    {
        _to.send(_amount);
    }
    
    function signerFromData(bytes _data) private returns (bytes4)
    {
        uint32 u = uint32(_data[3]) + (uint32(_data[2]) << 8) + (uint32(_data[1]) << 16) + (uint32(_data[0]) << 24);
        bytes4 sig = bytes4(u);
        return sig;
    }
    
    function parseSingleUintArg(bytes _data) private returns (uint)
    {
        uint x = 0;
        for (uint i = 0; i < 32; i++) {
            uint b = uint(_data[35 - i]);
            x += b * 256**i;
        }
        return x;
    }
    
    function donate() payable
    {
        
    }
}
