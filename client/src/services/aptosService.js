// Import the AptosClient from the Aptos SDK
import { AptosClient } from "aptos";

// Create an instance of AptosClient connected to the Aptos testnet node
const client = new AptosClient('https://fullnode.testnet.aptoslabs.com');

// Function to get the account balance
export async function getAccountBalance(address) {
  try {
    const account = await client.getAccount(address);
    const resources = await client.getAccountResources(address);
    const coinStore = resources.find((r) => r.type === '0x1::coin::CoinStore<0x1::aptos_coin::AptosCoin>');
    return coinStore.data.coin.value;
  } catch (error) {
    console.error("Error fetching account balance", error);
    return null;
  }
}