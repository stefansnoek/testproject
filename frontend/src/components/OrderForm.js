import React, { useState } from 'react';
import axios from 'axios';

function OrderForm() {
  const [userId, setUserId] = useState("");
  const [productId, setProductId] = useState("");
  const [amount, setAmount] = useState("");
  const [message, setMessage] = useState("");

  const handleSubmit = async (e) => {
    e.preventDefault();

    try {
      // Verzend gegevens naar de Order Service
      const response = await axios.post(`http://localhost:5000/order/${userId}/${productId}/${amount}`);
      setMessage(response.data.message);
    } catch (error) {
      setMessage("Error creating order. Please check your inputs.");
    }
  };

  return (
    <div>
      <h2>Create Order</h2>
      <form onSubmit={handleSubmit}>
        <div>
          <label>User ID:</label>
          <input 
            type="text" 
            value={userId} 
            onChange={(e) => setUserId(e.target.value)} 
          />
        </div>
        <div>
          <label>Product ID:</label>
          <input 
            type="text" 
            value={productId} 
            onChange={(e) => setProductId(e.target.value)} 
          />
        </div>
        <div>
          <label>Amount: How much</label>
          <input 
            type="text" 
            value={amount} 
            onChange={(e) => setAmount(e.target.value)} 
          />
        </div>
        <button type="submit">Placing Order</button>
      </form>

      {message && <p>{message}</p>}
    </div>
  );
}

export default OrderForm;
