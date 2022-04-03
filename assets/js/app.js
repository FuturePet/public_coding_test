import "phoenix_html";

import * as React from "react";
import * as ReactDOM from "react-dom";
import { ApolloClient, ApolloProvider } from "@apollo/client";
import { InMemoryCache } from "@apollo/client/cache";
import { HomePage } from "./components/HomePage";
import "../css/app.scss";

const client = new ApolloClient({
  uri: "/api",
  cache: new InMemoryCache(),
});

// use router in place of HomePage if project has more than one page.
ReactDOM.render(
  <ApolloProvider client={client}>
    <HomePage />
  </ApolloProvider>,
  document.getElementById("react-app")
);
