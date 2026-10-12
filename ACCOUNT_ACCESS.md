# FRISK V100.0 Account Access Contract

Frisk is designed to have broad access to the owner's connected digital services, but it cannot legitimately infer or steal authorization for every account on a PC.

The account fabric therefore uses two lanes:

1. **Official account/API lane** — Google, Microsoft, GitHub, Discord, Twitch, Steam and other providers are connected through their official authorization mechanisms when available.
2. **Browser-control lane** — Frisk can operate supported logged-in web applications through the browser automation layer without extracting browser password databases or authentication cookies.

The owner remains the authority. Dangerous account actions such as sending messages, changing settings, purchasing, deleting, uploading, or granting permissions require the existing security/confirmation policy.

`accounts.status` exposes only provider connection status, account labels, scopes and capabilities. It never returns raw secrets.
