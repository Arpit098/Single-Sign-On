const { buildModule } = require("@nomicfoundation/hardhat-ignition/modules");

module.exports = buildModule("AddressBookModule", (m) => {
  const addressBook = m.contract("AddressBook");

  return { addressBook };
});
