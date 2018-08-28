pragma solidity ^0.4.24;

import "./erc721.sol";
import "./contratoauxiliar.sol";
import "./safemath.sol";

contract Transferencia is ContratoAuxiliar, ERC721 {

  using SafeMath for uint256;

    mapping (uint => address) aprobTansfTarjeta;
    mapping (uint => address) aprobTansfAlbum;

  // Devueve el numero de tarjeas que posee una direccion de Ethereum
  function balanceTarjetas(address _owner) public view returns (uint256 _balanceTarjetas) {
    return contadorTarjetaPropietario[_owner];

  }
  // Devuelve el numero de Albumes que posee una direccion de Ethereum
  function balanceAlbum(address _owner) public view returns (uint256 _balanceAlbum) {
    return contadorAlbumPropietario[_owner];
  }
  

  // Devueleve la direccion que esta asociada a in Id de tarjeta
  function ownerOfTarjeta(uint256 _tarjetaId) public view returns (address _owner) {
    return tarjetaAlPropietario[_tarjetaId];


  }
  // Devueleve la direccion que esta asociada a in Id de Album
  function ownerOfAlbum(uint256 _albumId) public view returns (address _owner) {
    return albumAlPropietario[_albumId];
  }

  function _transferTarjeta(address _from, address _to, uint256 _tarjetaId) private {
    contadorTarjetaPropietario[_to]++;
    contadorTarjetaPropietario[_from]--;
    tarjetaAlPropietario[_tarjetaId] = _to;
    emit Transfer(_from, _to, _tarjetaId);
  }

  function _transferAlbum(address _from, address _to, uint256 _albumId) private {
    contadorAlbumPropietario[_to]++;
    contadorAlbumPropietario[_from]--;
    albumAlPropietario[_albumId] = _to;
    //llamado standar erc721
    emit Transfer(_from, _to, _albumId);
  }
  
  function transferirTarjeta(address _to, uint256 _tarjetaId) public onlyOwnerOfTarjeta(_tarjetaId) {
    _transferTarjeta(msg.sender, _to, _tarjetaId);
  }

  function transferirAlbum(address _to, uint256 _albumId) public onlyOwnerOfAlbum(_albumId) {
    _transferAlbum(msg.sender, _to, _albumId);
  }


  function apruebaTansfTarjeta(address _to, uint256 _tarjetaId) public {
    aprobTansfTarjeta[_tarjetaId] = _to;
    //llamado standar erc721
    emit Approval(msg.sender, _to, _tarjetaId);
  }

  function apruebaTansfAlbum(address _to, uint256 _albumId) public {
    aprobTansfAlbum[_albumId] = _to;
    //llamado standar erc721
    emit Approval(msg.sender, _to, _albumId);
  }

  function takeOwnershipTarjeta(uint256 _tarjetaId) public {
    require(aprobTansfTarjeta[_tarjetaId] == msg.sender);
    address owner = ownerOf(_tarjetaId);
    _transferTarjeta(owner, msg.sender, _tarjetaId);
  }

  function takeOwnershipAlbum(uint256 _albumId) public {
    require(aprobTansfAlbum[_albumId] == msg.sender);
    address owner = ownerOf(_albumId);
    _transferTarjeta(owner, msg.sender, _albumId);
  }

}
