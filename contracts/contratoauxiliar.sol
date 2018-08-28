pragma solidity ^0.4.24;

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
    require(tarjetas[_tarjetaId].nivelTarjeta >= _nivelTarjeta);
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
}
