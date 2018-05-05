pragma solidity ^0.4.19;

import "./generartarjeta.sol";
import "./generaralbum.sol";
import "./safemath.sol";

contract ContratoAuxiliar is GenerarTarjeta, GenerarAlbum {

  using SafeMath for uint256;

  uint comision = 0.001 ether;

  function setComision(uint _comision) external onlyOwner {
    comision = _comision;
  }

  modifier subirLevelTarjeta(uint _nivelTarjeta, uint _tarjetaId) {
    require(tarjtetas[_tarjetaId].nivelTarjeta >= _nivelTarjeta);
    _;
  }

  modifier onlyOwnerOfTarjeta(uint _tarjetaId) {
    require(msg.sender == tarjetaAlPropietario[_tarjetaId]);
    _;
  }

  modifier onlyOwnerOfAlbum(uint _albumId) {
    require(msg.sender == albumAlPropietario[_albumId]);
    _;
  }

/*
  function withdraw() external onlyOwner {
    owner.transfer(this.balance);
  }



  function levelUp(uint _zombieId) external payable {
    require(msg.value == levelUpFee);
    zombies[_zombieId].level++;
  }

  function changeName(uint _zombieId, string _newName) external aboveLevel(2, _zombieId) onlyOwnerOf(_zombieId) {
    zombies[_zombieId].name = _newName;
  }

  function changeDna(uint _zombieId, uint _newDna) external aboveLevel(20, _zombieId) onlyOwnerOf(_zombieId) {
    zombies[_zombieId].dna = _newDna;
  }

  function getZombiesByOwner(address _owner) external view returns(uint[]) {
    uint[] memory result = new uint[](ownerZombieCount[_owner]);
    uint counter = 0;
    for (uint i = 0; i < zombies.length; i++) {
      if (zombieToOwner[i] == _owner) {
        result[counter] = i;
        counter++;
      }
    }
    return result;
  }
*/
}
