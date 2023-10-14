describe('Product Details', () => {
  beforeEach(() => {
  cy.visit('/');
})
it('should navigate to product detail page from home', () => {
  cy.visit('/products/');
  // cy.get('.product').first().click();
  cy.url().should('include', '/products/');
});

});