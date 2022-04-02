import "phoenix_html";

import * as React from "react";
import * as ReactDOM from "react-dom";
import { ApolloClient, ApolloProvider } from "@apollo/client";
import { InMemoryCache } from "@apollo/client/cache";
import { HomePage } from "./components/HomePage";

const client = new ApolloClient({
  uri: "/api",
  cache: new InMemoryCache(),
});

ReactDOM.render(
  <ApolloProvider client={client}>
    <HomePage />
  </ApolloProvider>,
  document.getElementById("react-app")
);
