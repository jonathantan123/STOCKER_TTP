import React, { useState } from "react";
import { Form, Input, Grid } from "semantic-ui-react";
import { connect } from "react-redux";

function PurchaseForm(props) {
  const [transactionInfo, setTransactionInfo] = useState({
    ticker: "",
    quantity: ""
  });

  let user_id = props.user_id;

  // on submit fetch and find/set the id of the current user to redux

  let url = `http://localhost:3000/api/v1/transactions`;

  let submitHandler = e => {
    e.preventDefault();


    fetch(`${url}`, {
      method: "POST",
      headers: {
        Accept: "application/json",
        "Content-Type": "application/json"
      },
      body: JSON.stringify({ ...transactionInfo, user_id: user_id })
    })
      .then(resp => resp.json())
      .then(data => {
        if (data.errors) {
          console.log("working");
        } else {
          alert(data.message)
          props.updateBalance(data.balance) 
        }
      });
  };

  return (
    <div className="login-container">
      <div className="login-form">
        <Form onSubmit={submitHandler}>
          <Form.Field
            id="ticker"
            control={Input}
            onChange={e =>
              setTransactionInfo({ ...transactionInfo, ticker: e.target.value })
            }
            placeholder="Ticker"
          />
          <Form.Field
            id="password"
            control={Input}
            onChange={e =>
              setTransactionInfo({
                ...transactionInfo,
                quantity: e.target.value
              })
            }
            placeholder="QTY"
          />

          <Grid>
            <Grid.Row centered>
              <Form.Button>Buy</Form.Button>
            </Grid.Row>
          </Grid>
        </Form>
      </div>
    </div>
  );
}

function mapStateToProps(state) {
  return {
    user_id: state.userId
  };
}
function mapDispatchToProps(dispatch) {
  return {
    updateBalance: data => {
      dispatch({ type: "UPDATEBALANCE", payload: data });
    }
  };
}
export default connect(mapStateToProps, mapDispatchToProps)(PurchaseForm);
// export default connect(mapStateToProps, mapDispatchToProps)(Login);
