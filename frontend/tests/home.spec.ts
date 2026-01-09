import { test, expect } from '@playwright/test';

const FRONTEND_URL = process.env.FRONTEND_URL || 'http://localhost:3000';

test('homepage loads', async ({ page }) => {
  await page.goto(FRONTEND_URL);
  await expect(page.locator('h1')).toHaveText('DevOps Assignment');
});

test('backend integration works', async ({ page }) => {
  await page.goto(FRONTEND_URL);

  await expect(
    page.getByTestId('backend-status')
  ).toContainText('connected');

  await expect(
    page.getByTestId('backend-message')
  ).toBeVisible();
});
