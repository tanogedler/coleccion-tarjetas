pragma solidity ^0.4.19;

import "./pertenencia.sol";
import "./safemath.sol";

contract GenerarAlbum is Pertenencia {
// Usaremos la librería SafeMath
  using SafeMath for uint256;

  event NuevoAlbum(uint IdAlbum, string nombre, address direccionAlbum);

// Estructura de una tarjeta. 
  struct Album {
    string nombre;
    address direccionAlbum;
    uint32 fechaEmision;
  }

  Album[] public albumes;

  mapping (uint => address) public albumAlPropietario;
  mapping (address => uint) contadorAlbumDelPropietario;

  function _crearAlbum(string _name, uint _direccionAlbum) internal {
    uint id = albumes.push(Album(_name, _direccionAlbum) - 1;
    albumAlPropietario[id] = msg.sender;
    contadorAlbumDelPropietario[msg.sender]++;
    NuevoAlbum(id, _name, _direccionAlbum);
  }

}