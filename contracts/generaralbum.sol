pragma solidity ^0.4.19;

import "./ownable.sol";
import "./safemath.sol";

contract GenerarAlbum is Ownable {

// Usaremos la librería SafeMath
  using SafeMath for uint256;

  event NuevoAlbum(uint albumId, string nombre, uint randomAlbum);

// Estructura de un album. 
  uint digitosRandom = 16;
  uint modulo = 10 ** digitosRandom;
  struct Album {
    string nombre;
    uint randomAlbum;
    uint32 nivelAlbum;
    //address direccionAlbum;
    uint fechaEmision;
  }

  Album[] public albumes;

  mapping (uint => address) public albumAlPropietario;
  mapping (address => uint) contadorAlbumPropietario;

  function _crearAlbum(string _nombre, uint _randomAlbum) internal {
    uint id = albumes.push(Album(_nombre, _randomAlbum, 1, now)) - 1;
    albumAlPropietario[id] = msg.sender;
    contadorAlbumPropietario[msg.sender]++;
    emit NuevoAlbum(id, _nombre, _randomAlbum);
  }

  function _generaValorRandomAlbum (string _str) private view returns (uint) {
    uint rand = uint(keccak256(_str));
    return rand % modulo;
  }

  function _crearAlbumAleatorio(string _nombre) public {
    require(contadorAlbumPropietario[msg.sender] == 0);
    uint randValor = _generaValorRandomAlbum(_nombre);
    randValor = randValor - randValor % 100;
    _crearAlbum(_nombre, randValor);
  }
}