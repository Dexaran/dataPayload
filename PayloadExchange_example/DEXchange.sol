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

contract DEXchange {
    
    mapping (address=>bool) supportedToken;
    
    modifier tokenPayable {
        if (supportedToken[msg.sender])
            throw;
        _;
    }
    address public owner;
    bytes4 public signer;
    
    address public token1Contract=0x5607bdE72CB0e4757dB2201CFC587257366B100b;
    address public token2Contract=0x3Af20d9e40919B85352e6735d72a78779EC76977;
    
    uint public exchangeRate=1;
    
    uint public token1Balance;
    uint public token2Balance;
    
    address public token1Owner;
    address public token2Owner;
    
    
    /*function DEXchange(address _token1, address _token2)
    {
        token1Contract=_token1;
        token2Contract=_token2;
    }*/
    
    function whatTheHash(string _src) constant returns (bytes4)
    {
        return bytes4(sha3(_src));
    }
    
    function tokenFallback(address _from, uint _value, bytes _data) returns (bool result) 
    {
        
        if(msg.sender==token1Contract)
        {
            token1Owner=_from;
            token1Balance=_value;
        }
        
        else if(msg.sender==token2Contract)
        {
            token2Owner=_from;
            token2Balance=_value;
        }
        else
        {
            throw;
        }
        
        if(_data.length!=0)
        {
            ERC23 token1 = ERC23(token1Contract);
            ERC23 token2 = ERC23(token2Contract);
            
            signer = signerFromData(_data);
            if(signer==bytes4(sha3("trade")))
            {
                token1.transfer(token2Owner, token2Balance);
                token2.transfer(token1Owner, token1Balance);
            }
            //throw;
        }
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