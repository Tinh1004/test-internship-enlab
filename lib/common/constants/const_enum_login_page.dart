enum Role {
  guard,
  operator,
  storekeeper,
  driver,
  accountant,
  customer,
  sale,
  sale_lead,
  none
}

String roleToString(Role role) {
  switch (role) {
    case Role.guard:
      return 'guard';
    case Role.operator:
      return 'operator';
    case Role.storekeeper:
      return 'storekeeper';
    case Role.driver:
      return 'driver';
    case Role.accountant:
      return 'accountant';
    case Role.customer:
      return 'customer';
    case Role.sale:
      return 'sale';
    case Role.sale_lead:
      return 'sale_lead';
  }
  return "none";
}

Role stringToRole(String string) {
  switch (string) {
    case 'guard':
      return Role.guard;
    case 'operator':
      return Role.operator;
    case 'storekeeper':
      return Role.storekeeper;
    case 'driver':
      return Role.driver;
    case 'accountant':
      return Role.accountant;
    case 'customer':
      return Role.customer;
    case 'sale':
      return Role.sale;
    case 'sale_lead':
      return Role.sale_lead;
    case '':
      return Role.none;
  }
  return Role.none;
}