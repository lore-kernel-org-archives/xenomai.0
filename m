MIME-Version: 1.0
In-Reply-To: <4E0478F7.40706@domain.hid>
References: <BANLkTimFiO9JAdvYjpnx9bpvFo2W1zYX3g@domain.hid>
	<4E0478F7.40706@domain.hid>
Date: Tue, 28 Jun 2011 15:08:30 +0200
Message-ID: <BANLkTikFipPQVsa3tYPGSgEbQEzKEC7mEw@domain.hid>
From: suresh reddy <sureshreddy.balijepalli@domain.hid>
Content-Type: multipart/alternative; boundary=bcaec501673f404c0d04a6c55df3
Subject: [Xenomai-help] Fwd:  Regarding booting
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Xenomai help <xenomai@xenomai.org>

--bcaec501673f404c0d04a6c55df3
Content-Type: text/plain; charset=ISO-8859-1

Hi all ,

i have followed  through the below mentioned procedure  and i have strucked
in the final step of boot process.

modprobe: FATAL: Could not load /lib/modules/2.6.37.6/modules.dep: No such
file or directory

wget
http://www.codesourcery.com/sgpp/lite/arm/portal/package7851/public/arm-none-linux-gnueabi/arm-2010.09-50-arm-none-linux-gnueabi-i686-pc-linux-gnu.tar.bz2
tar -xvjf arm-2010.09-50-arm-none-linux-gnueabi-i686-pc-linux-gnu.tar.bz2
export PATH=/tmp/xeno/arm-2010.09/bin:$PATH
git clone --depth 1 git://git.xenomai.org/xenomai-2.5.git
git clone --depth 1 --branch for-ipipe-2.6.37-arm git://
git.xenomai.org/ipipe-gch.git
cd ipipe-gch
../xenomai-2.5/scripts/prepare-kernel.sh --arch=arm --linux=.
wget -O .config http://sisyphus.hd.free.fr/~gilles/omap4_panda_config
yes "" | make ARCH=arm oldconfig
make -j 8 ARCH=arm CROSS_COMPILE=arm-none-linux-gnueabi- uImage

make ARCH=arm CROSS_COMPILE=arm-none-linux-gnueabi- modules_install
INSTALL_MOD_PATH=<replace with your SD card fs path>

and in my sdcard in /lib/modules  I have 2.6.37.6 directory

I have the mentioned file modules.dep in my sd card  /lib/modules/2.6.37.6/

i have tried some mentioned in web
 update-initramfs
editing the initramfs.confg (mod=replacing MOST with DEP)
and all but the error remain unchanged . If someone passthrough this problem
plase let me know.








Thanks
Suresh balijepalli
Rosenehim,Baveria.

--bcaec501673f404c0d04a6c55df3
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hi all ,<div><br></div><div>i have followed =A0through the=
 below mentioned procedure =A0and i have strucked in the final step of boot=
 process.</div><div><br></div><div><font color=3D"#CC0000">modprobe: FATAL:=
 Could not load /lib/modules/<a href=3D"http://2.6.37.6/modules.dep" target=
=3D"_blank">2.6.37.6/modules.dep</a>: No such file or directory=A0=A0</font=
><br>


<div class=3D"gmail_quote"><div><br></div>
wget <a href=3D"http://www.codesourcery.com/sgpp/lite/arm/portal/package785=
1/public/arm-none-linux-gnueabi/arm-2010.09-50-arm-none-linux-gnueabi-i686-=
pc-linux-gnu.tar.bz2" target=3D"_blank">http://www.codesourcery.com/sgpp/li=
te/arm/portal/package7851/public/arm-none-linux-gnueabi/arm-2010.09-50-arm-=
none-linux-gnueabi-i686-pc-linux-gnu.tar.bz2</a><br>










tar -xvjf arm-2010.09-50-arm-none-linux-gnueabi-i686-pc-linux-gnu.tar.bz2<b=
r>
export PATH=3D/tmp/xeno/arm-2010.09/bin:$PATH<br>
git clone --depth 1 git://<a href=3D"http://git.xenomai.org/xenomai-2.5.git=
" target=3D"_blank">git.xenomai.org/xenomai-2.5.git</a><br>
git clone --depth 1 --branch for-ipipe-2.6.37-arm git://<a href=3D"http://g=
it.xenomai.org/ipipe-gch.git" target=3D"_blank">git.xenomai.org/ipipe-gch.g=
it</a><br>
cd ipipe-gch<br>
../xenomai-2.5/scripts/prepare-kernel.sh --arch=3Darm --linux=3D.<br>
wget -O .config <a href=3D"http://sisyphus.hd.free.fr/%7Egilles/omap4_panda=
_config" target=3D"_blank">http://sisyphus.hd.free.fr/~gilles/omap4_panda_c=
onfig</a><br>
yes &quot;&quot; | make ARCH=3Darm oldconfig<br>
make -j 8 ARCH=3Darm CROSS_COMPILE=3Darm-none-linux-gnueabi- uImage<br><br>=
<span style=3D"font-family:Consolas, Menlo, Monaco, &#39;Lucida Console&#39=
;, &#39;Liberation Mono&#39;, &#39;DejaVu Sans Mono&#39;, &#39;Bitstream Ve=
ra Sans Mono&#39;, &#39;Courier New&#39;, monospace, serif;font-size:12px;w=
hite-space:pre-wrap">make ARCH=3Darm CROSS_COMPILE=3Darm-none-linux-gnueabi=
- modules_install INSTALL_MOD_PATH=3D&lt;replace with your SD card fs path&=
gt;</span><br>










=A0=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=A0<br>
</div><div class=3D"gmail_quote">and in my sdcard in /lib/modules =A0I have=
 2.6.37.6 directory=A0</div><div class=3D"gmail_quote"><br></div><div class=
=3D"gmail_quote">I have the mentioned file modules.dep in my sd card =A0/li=
b/modules/<a href=3D"http://2.6.37.6/" target=3D"_blank">2.6.37.6/</a></div=
>


<div class=3D"gmail_quote"><br></div><div class=3D"gmail_quote">i have trie=
d some mentioned in web =A0</div><div class=3D"gmail_quote">=A0update-initr=
amfs=A0</div><div class=3D"gmail_quote">editing the initramfs.confg (mod=3D=
replacing MOST with DEP)</div>
<div class=3D"gmail_quote">
and all but the error remain unchanged . If someone passthrough this proble=
m plase let me know.</div>
<div class=3D"gmail_quote"><br></div><div class=3D"gmail_quote"><br></div><=
div class=3D"gmail_quote"><br></div><div class=3D"gmail_quote"><br></div><d=
iv class=3D"gmail_quote"><font color=3D"#888888"><font face=3D"arial, sans-=
serif"><span style=3D"font-size:12px"><br>


</span></font></font></div><br><br clear=3D"all"><br>Thanks<br>Suresh balij=
epalli<br>Rosenehim,Baveria.<br>
</div></div>

--bcaec501673f404c0d04a6c55df3--

