import { useEffect } from 'react';
import Graph from './components/Graph';
import { useSelector, useDispatch } from 'react-redux';

import Home from './components/Home';
import { getStockOptions } from './store/home.store';
import { AptosClient } from 'aptos';  // Import AptosClient

import './App.css';

export default function App() {
  const dispatch = useDispatch();
  const response = useSelector((state) => state.HomeStore.response);

  // Create an instance of AptosClient connected to the Aptos testnet node
  const client = new AptosClient('https://fullnode.testnet.aptoslabs.com');

  // Function to fetch data from the Aptos blockchain (e.g., balance)
  const fetchAptosData = async () => {
    try {
      const address = "0x0b8fa29fb79a3007dc574f80a6f0bd0f1c629701142add75982f80d01138b29c"; // Replace with actual address or use dynamic address
      const account = await client.getAccount(address);  // Fetch account data
      console.log("Aptos Account:", account);
      const resources = await client.getAccountResources(address);
      console.log("Aptos Resources:", resources);
    } catch (error) {
      console.error("Error fetching data from Aptos:", error);
    }
  };

  // Run the API to get stock tickers once on app init.
  useEffect(() => {
    dispatch(getStockOptions());
    
    // Call the Aptos data fetching function
    fetchAptosData();
  }, []);

  return (
    <>
      {response.length === 0 && <Home />}
      {response.length > 0 && <Graph data={response} />}
    </>
  );
}
// import { useEffect } from 'react';
// import Graph from './components/Graph';
// import { useSelector, useDispatch } from 'react-redux';

// import Home from './components/Home';
// import { getStockOptions } from './store/home.store';
// import { AptosClient } from 'aptos';

// import './App.css';


// export default function App() {
//   const dispatch = useDispatch();
//   const response = useSelector((state) => state.HomeStore.response);

//   // Run the api to get stock tickers once on app init.
//   useEffect(() => {
//     dispatch(getStockOptions());
//   }, []);

//   return (
//     <>
//       {response.length === 0 && <Home />}
//       {response.length > 0 && <Graph data={response} />}
//     </>
//   );
// }

