{
  services = {
    searx = {
      enable = true;
      settings = {
        server = {
          port = 8888;
          bind_address = "127.0.0.1";
          secret_key = "foo";
        };
      };
    };
  };
}