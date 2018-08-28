pragma solidity ^0.4.24;

import "./ownable.sol";
import "./safemath.sol";

contract GenerarTarjeta is Ownable {

// Usaremos la librería SafeMath
  using SafeMath for uint256;

  event NuevaTarjeta(uint tarjetaId, string nombre, uint randomTarjeta);
  
  uint digitosRandom = 16;
  uint modulo = 10 ** digitosRandom;

// Estructura de una tarjeta 
  struct Tarjeta {
    string nombre;
    uint randomTarjeta;
    uint32 nivelTarjeta;
    uint fechaEmision;
  }

  Tarjeta[] public tarjetas;

  mapping (uint => address) public tarjetaAlPropietario;
  mapping (address => uint) contadorTarjetaPropietario;

  function _crearTarjeta(string _nombre, uint _randomTarjeta) internal {
    uint id = tarjetas.push(Tarjeta(_nombre, _randomTarjeta, 1, now)) - 1;
    tarjetaAlPropietario[id] = msg.sender;
    contadorTarjetaPropietario[msg.sender]++;
    emit NuevaTarjeta(id, _nombre, _randomTarjeta);
  }

  function _generaValorRandomTarjeta (string _str) private view returns (uint) {
    uint rand = uint(keccak256(abi.encodePacked(_str)));
    return rand % modulo;
  }

  function _crearTarjetaAleatorio(string _nombre) public {
    require(contadorTarjetaPropietario[msg.sender] == 0);
    uint randValor = _generaValorRandomTarjeta(_nombre);
    randValor = randValor - randValor % 100;
    _crearTarjeta(_nombre, randValor);
  }
}