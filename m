MIME-Version: 1.0
Date: Fri, 16 Jul 2010 09:17:37 +0000
Message-ID: <AANLkTikGMBzKX_Ci-vC_B_6nCiNNIq2VL5k3xBXdM297@domain.hid>
From: PREMRAJ SV <svprem20@domain.hid>
Content-Type: multipart/alternative; boundary=000e0cd173e49edb6e048b7db064
Subject: [Xenomai-help] Xenomai Building Problem
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: xenomai@xenomai.org

--000e0cd173e49edb6e048b7db064
Content-Type: text/plain; charset=ISO-8859-1

Dear all,
             I am trying to compile and build xenomai-2.5.3 on
linux-2.6.34..I am almost done with compilation with make
menuconfig..Everything ran well without any error.. When i am trying the
next step i.e, Building Xenomai for User space modules,

$<xenomai path/configure> --enable-linux-build=<linux tree>

The follwing steps are carried out,
Making linux a shadow copy of <linux tree>
Changing linux directory...
Make[1]: Entering directory<linux tree/linux>
./config .status linux
config.status: executing linux commands
removing existing linux directory....done
Making linux a shadow copy of <linux tree>  (cursor blinking)

This step stays for hours...

What is the problem with building xenomai... has anyone come across such
issue...

--000e0cd173e49edb6e048b7db064
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Dear all,<br>=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 I am trying to compile an=
d build xenomai-2.5.3 on linux-2.6.34..I am almost done with compilation wi=
th make menuconfig..Everything ran well without any error.. When i am tryin=
g the next step i.e, Building Xenomai for User space modules,<br>
<br>$&lt;xenomai path/configure&gt; --enable-linux-build=3D&lt;linux tree&g=
t;<br><br>The follwing steps are carried out,<br>Making linux a shadow copy=
 of &lt;linux tree&gt;<br>Changing linux directory...<br>Make[1]: Entering =
directory&lt;linux tree/linux&gt;<br>
./config .status linux<br>config.status: executing linux commands<br>removi=
ng existing linux directory....done<br>Making linux a shadow copy of &lt;li=
nux tree&gt;=A0 (cursor blinking)<br><br>This step stays for hours...<br>
<br>What is the problem with building xenomai... has anyone come across suc=
h issue... <br>

--000e0cd173e49edb6e048b7db064--

