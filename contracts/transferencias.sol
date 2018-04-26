pragma solidity ^0.4.19;

import "./pertenencia.sol";

contract Transferencia is Pertenencia {

  modifier aboveLevel(uint _level, uint _IdTarjeta) {
    require(Tarjeta[_IdTarjeta].level >= _level);
    _;
  }

  function withdraw() external soloPropietario {
    owner.transfer(this.balance);
  }

  function setLevelUpFee(uint _fee) external soloPropietario {
    levelUpFee = _fee;
  }


}
