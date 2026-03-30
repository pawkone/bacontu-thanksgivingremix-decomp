saveiconTimer -= 1;
saveiconIndex += 0.35;
saveiconAlpha = approach(saveiconAlpha, (saveiconTimer > 0) ? 1 : 0, 0.1);
