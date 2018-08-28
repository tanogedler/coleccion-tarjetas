pragma solidity ^0.4.24;
/**
 * @title Pertenencia
 * @author Jose Angel Contreras
 * @dev El contrato Pertenencia posee una direccion del usuario, posee las funciones de autorizacion
 * basicas, que simplifica la implementacion de los permisos de usuario.
 */
contract Pertenencia {
  address public propietario;

  event PertenenciaTransferida(address indexed anteriorPropietario, address indexed nuevoPropietario);

  /**
   * @dev el constructor "poseible" define al propietario original del contrato como la cuenta del emisor
   * account.
   */
  function Poseible() public {
    propietario = msg.sender;
  }


  /**
   * @dev Se asegura que la funcion sea llamada solo por el propietario.
   */
  modifier soloPropietario() {
    require(msg.sender == propietario);
    _;
  }


  /**
   * @dev Permite al propietario actual transferir el control del contrato al nuevoPropietario.
   * @param nuevoPropietario  Direccion a la cual se transfiere la propiedad.
   */
  function transferirPropiedad(address nuevoPropietario) public soloPropietario {
    require(nuevoPropietario != address(0));
    emit PertenenciaTransferida(propietario, nuevoPropietario);
    propietario = nuevoPropietario;
  }

}
