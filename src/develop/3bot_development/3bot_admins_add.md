## Adding admin user access to the 3bot

Giving admin access to other users could be done from `Settings` or admins could be added to `j.tools.threebot.me.default.admins` via `jsng` shell:

```python3
j.core.identity.me.admins.append("ahmed.3Bot")
j.core.identity.me.save()
```
