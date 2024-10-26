# Intro
So, if u guys know what kasm is, good. Skip the next part. If you don't, just read the next part.

Kasm is a place where you can get different desktops and other things, completely bypassing cps defenses. 
The best part is that with my method, pretty simple, it can't be blocked at all. 
There's some issue with the fps, but there are some adjustable settings for that. This is kind of unnecesary though, 
becuase of croxy proxy. You can access it through the ipv4 https://157.245.18.208/ And, here's another proxy,   
though the loading speed is a bit low. http://rh.teamclbesh.net/ - ignore http not https

# Yap about stuff, you might want to read this
There are two ways, your own server at home, or one on the cloud. For the one on the cloud, it's a bit simpler
but It will cost money, like $5 a month. BUT, kasmweb.com is blocked as a security.proxy from goofy aws blocking. For the server at home, there's a good guide by network chuck that i'm too lazy to find again. Go search on youtube: network chuck kasm install
or maybe something like that, idrk. It was called getting a secure browser though. There's also a great official guide on how to install it, so that's the best way to install it. I'm just gonna list some commands fro you to use. 

But, you need to be able to get a linux computer, with a terminal. There has to be enough storage and enough computer requirements, like the official is 50gb, 2cpu cores, and 4gb of ram. In reality, 50gb is over the limit, but the other ones you might actually want, but lowering the limit is fine. If you don't have a computer at home, here's where a lot of stuff online
comes in. Linode is actually really good, and I won't go over it, but that's just network chuck's video again. My way is completely free though, no account sign in or anything. As long as you have the requirements, you'll be fine. Side note: for some reason some old computers might not work, still haven't figured it out. If you're on mac, I guess go to the terminal and install
brew, and with brew install multipass, literally just those three words to install it. Now you can create a new VM, but u can 
guide yourself through it. Virtualbox also works, but only a command line is needed. IF you're on windows, use wsl. That's a pretty
simple install. I'm also assuming you aren't trying to get people to use your kasm server for profit, so I won't go over creating
multiple accounts like i did. **Hopefully you have a debian based or ubuntu based system, otherwise some commands might not work.**

# Installing
Firstly, do the regular
```bash
sudo apt-get update
sudo apt-get full-upgrade -y
sudo apt autoremove
```
Next, install kasm.
**basic install**
```bash
cd /tmp
curl -O https://kasm-static-content.s3.amazonaws.com/kasm_release_1.16.0.a1d5b7.tar.gz
tar -xf kasm_release_1.16.0.a1d5b7.tar.gz
sudo bash kasm_release/install.sh --admin-password <insert-password> --user-password <insert-password>
```
It will tell you your password
**install if you have space**
```bash
cd /tmp
curl -O https://kasm-static-content.s3.amazonaws.com/kasm_release_1.16.0.a1d5b7.tar.gz
tar -xf kasm_release_1.16.0.a1d5b7.tar.gz
sudo bash kasm_release/install.sh -W -e --admin-password password --user-password password
```
**other installs*
cd /tmp
curl -O https://kasm-static-content.s3.amazonaws.com/kasm_release_1.16.0.a1d5b7.tar.gz
tar -xf kasm_release_1.16.0.a1d5b7.tar.gz
sudo bash kasm_release/install.sh --help
```
lol with --help it gives you a menu to choose from
**In the middle of the install, it might give you a few warnings.**
If it asks about continuing, say y.
If it asks about a **swap** file, say y and then choose from 1/4 to 1/2 of your ram to allocate, depending on if you're gonna use it for other stuff
Now that you have it installed, install **cloudflared** so you can access it at school, on a different network. There are other ways.
Hopefully you know what cloudflare is, but if you don't idc bc just copy and paste the damn instructions from the website.
https://developers.cloudflare.com/cloudflare-one/connections/connect-networks/get-started/create-local-tunnel/
Right there.
If you don't feel like clicking it:
```bash
sudo mkdir -p --mode=0755 /usr/share/keyrings
curl -fsSL https://pkg.cloudflare.com/cloudflare-main.gpg | sudo tee /usr/share/keyrings/cloudflare-main.gpg >/dev/null
echo "deb [signed-by=/usr/share/keyrings/cloudflare-main.gpg] https://pkg.cloudflare.com/cloudflared $(lsb_release -cs) main" | sudo tee /etc/apt/sources.list.d/cloudflared.list
sudo apt-get update && sudo apt-get install cloudflared
```
That's the most likely command you'll run, since you're probably using ubuntu and not arch or smth. 
Now that you have that installed, just do this command:
```bash
cloudflared tunnel --url https://localhost:443 --no-tls-verify
```
Or, add this to a file and run it from there, to make it easier to run. 
```bash
echo "#!/bin/bash
cloudflared tunnel --url https://localhost:443 --no-tls-verify" > cloudflare.sh
chmod +x cloudflare.sh
./cloudflare.sh
```
I'm not sure that works, but if it doesn't just copy and paste
```bash
#!/bin/bash
cloudflared tunnel --url https://localhost:443 --no-tls-verify
```
into the file and do chmod and the rest. 
Next time, to run it, just do 
```bash
./cloudflare.sh
```
It will generate a link for you to use, so just open that up in a new tab and you have kasm, accessible from anywhere.
Side note: IT MUST BE HTTPS NOT HTTP.
You can configure a reverse proxy for http to work, but I'm too lazy to.
Also, you can add a auto-sign in feature I think. 
You might be confused by the stuff and all, but kasm again has some great guides.
Simply, go the workspaces tab, registries, add official registry, and maybe some other ones of you feel comfortable with it.
Then, go back to avaiable workspaces and you'll find a whole list of stuff you can install. There's a bunch of stuff that you 
can do with it, but it won't be saved unless you add a persistent path, which is all on your own. Allowing root access is simple
but you can go research that yourself. (It's on the offical website, running as root.) Just do your own research and play around with it. 

Remember when I said it's unblockable? Well, it's mostly unblockable if they don't block cloudflare. You can also just
get your own domain and do it that way, but freenom is down and there's no good way to do it without a credit card. 
Cloudflare is not the only way, but since this is a different domain than official cloudflare, they might block it. 
You can use ngrok and pagekite, with some limits.

Yes, I know i didn't explain alot. But you can go research all of it yourself. Kasm is actually amazing.
(Except one annoying part about things that you install don't stay there, only official files instead of extra ones in
somewhere like /bin)

**Issues**
Some possible issues is running out of disk space, or having to use rolling images.
They may all originate from not being able to login.
There's a special github repo designed for kasm issues, linked here: https://github.com/kasmtech/workspaces-issues/issues
You can either post a new one or find an old one. Also, don't tell them about this goofy ah writeup about it. 

# After install
**Start**
```bash
sudo /opt/kasm/bin/start
```
**Stop**
```bash
sudo /opt/kasm/bin/stop
```

