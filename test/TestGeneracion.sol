pragma solidity ^0.4.2;

import "truffle/Assert.sol";
import "truffle/DeployedAddresses.sol";
import "../contracts/generaralbum.sol";
import "../contracts/genertarjeta.sol";

contract TestGeneracion {

  function testInicialGenerarTarjeta() public {
    Tarjeta tarjeta = crearTarjeta(DeployedAddresses.crearTarjeta());

    uint expected = 10000;


  }

  function testInicialGenerarAlbum() public {
    Tarjeta tarjeta = crearAlbum(DeployedAddresses.crearAlbum());

    uint expected = 10000;


  }


}
