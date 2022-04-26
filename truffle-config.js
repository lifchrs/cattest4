module.exports = {
  networks: {
    development: {
      host: "127.0.0.1",
      port: 8545,
      network_id: "*" // Match any network id
    }
  },
  solc: {
    optimizer: {
      enabled: true,
      runs: 200
    }
  },


  //added by myself
  compilers: {
    solc: {
      version: "0.5.0",    // Fetch exact version from solc-bin (default: truffle's version)
    }
  }
}