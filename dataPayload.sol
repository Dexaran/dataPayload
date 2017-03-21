pragma solidity ^0.4.9;

contract contractReceiver{
    function tokenFallback(address _from, uint _value)
    {
        
    }
}


contract ERC23 {
  uint public totalSupply;
  function balanceOf(address who) constant returns (uint);
  function allowance(address owner, address spender) constant returns (uint);

  function transfer(address to, uint value) returns (bool ok);
  function transfer(address to, uint value, bytes data) returns (bool ok);
  function transferFrom(address from, address to, uint value) returns (bool ok);
  function approve(address spender, uint value) returns (bool ok);
  event Transfer(address indexed from, address indexed to, uint value);
  event Approval(address indexed owner, address indexed spender, uint value);
}

//Contract that is minting and burning cryptocurrency tokens

contract DecentralizedEXchange {
    
    modifier onlyOwner {
        if (msg.sender != owner)
            throw;
        _;
    }
    //mapping address(wallet) => address(token) => balance(tokens)
    address public owner;
    uint public lastUint;
    bytes public lastData;
    bytes4 public signer;
    uint32 public uVariable;
    bytes public callData;
    
    
    bytes4 public shaBytes_whiteSpaces;
    bytes4 public shaBytes;
    
    
    
    
    function tokenFallback(address _from, uint _value, bytes _data) payable returns (bool result) 
    {
        if(_data.length!=0)
        {
            signer = signerFromData(_data);
            //if(signer==(bytes4(sha3("buy(uint)"))))
            //{ 
                uint256 amount=parseSingleUintArg(_data);
                lastUint=amount;
                lastData=_data;
                //_from.send(amount);
                //if(_from.send(100))
                if(_from.send(amount))
                {
                    return true;
                }
            //}
        }
        //throw;
    }
    
    function buy(uint256)
    {
        
    }
    
    function signerFromData(bytes _data) private returns (bytes4)
    {
        callData=_data;
        uint32 u = uint32(_data[3]) + (uint32(_data[2]) << 8) + (uint32(_data[1]) << 16) + (uint32(_data[0]) << 24);
        bytes4 hash = bytes4(sha3("tokenFallback(address,uint256,bytes)"));
        bytes4 hash2 = bytes4(sha3("tokenFallback(address, uint256, bytes)"));
        
        shaBytes_whiteSpaces=hash2;
        shaBytes=hash;
        //uVariable = uint32(_data[0]);
        
        uVariable=u;
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
    
    function sendEtc(uint _amount, address _to)
    {
        
    }
    
    function() payable
    {
        
    }
    
    function sendEtc(uint _amount)
    {
        
    }
}