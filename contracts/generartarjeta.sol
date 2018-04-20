pragma solidity ^0.4.19;

import "./pertenencia.sol";
import "./safemath.sol";

contract GenerarTarjeta is Pertenencia {

// Usaremos la librería SafeMath
  using SafeMath for uint256;

  event NuevaTarjeta(uint IdTarjeta, string nombre, address direccionImagen);

// Estructura de una tarjeta. 
  struct Tarjeta {
    string nombre;
    address direccionImagen;
    uint32 nivel;
    uint32 copias;
    uint32 fechaEmision;
  }

  Tarjeta[] public tarjetas;

  mapping (uint => address) public tarjetaAlPropietario;
  mapping (address => uint) contadorTarjetasDelPropietario;

  function _crearTarjeta(string _name, address _direccionImagen) internal {
    uint id = tarjetas.push(Tarjeta(_name, _direccionImagen, 0, 1, 0)) - 1;
    tarjetaAlPropietario[id] = msg.sender;
    contadorTarjetasDelPropietario[msg.sender]++;
    NuevaTarjeta(id, _name, _direccionImagen);
  }

}