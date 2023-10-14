// cypress/integration/add_to_cart.spec.js

describe('Add to Cart', () => {
  beforeEach(() => {
    // Visit the home page
    cy.visit('/');
  });

  it('should increase the cart count when "Add to Cart" button is clicked', () => {
    cy.get('article .btn').first().click({ force: true });
    cy.contains("My Cart").should(($cart) => {
      const text = $cart.text()
      expect(text).to.include('1')
    })
  });
});
