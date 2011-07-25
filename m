MIME-Version: 1.0
In-Reply-To: <mailman.565.1311612439.23202.xenomai@xenomai.org>
References: <mailman.565.1311612439.23202.xenomai@xenomai.org>
Date: Mon, 25 Jul 2011 18:55:55 +0200
Message-ID: <CAL+uwv8017bKhB6emO13DJc-5Q3cBfGEmwqnb4h9OH7UiMe3fQ@mail.gmail.com>
From: suresh reddy <sureshreddy.balijepalli@domain.hid>
Content-Type: multipart/alternative; boundary=bcaec53ae7fa530f1d04a8e7b036
Subject: [Xenomai-help] Fwd: The results of your email commands
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

--bcaec53ae7fa530f1d04a8e7b036
Content-Type: text/plain; charset=ISO-8859-1

i have installed xenomai on arm based taget board. Now i would like to cross
compile a userspace program on my host machine. If i done it as below it
giving me error , CFLAGS undefined variable. some one please let me know
what exact way to cross compile a xenomai userspace program.


CFLAGS =`DESTDIR=/home/balijepalli/omap4/root
/home/balijepalli/omap4/root/usr/xenomai/bin/xeno-config --skin native
--cflags` LDFLAGS=`DESTDIR=/home/balijepalli/omap4/root
 /home/balijepalli/omap4/root/usr/xenomai/bin/xeno-config --skin native
--ldflags` arm-none-linux-gnueabi-gcc -o st $CFLAGS st.c$LDFLAGS



Suresh balijepalli
Rosenehim,Baveria.




-- 

Suresh balijepalli
Rosenehim,Baveria.

--bcaec53ae7fa530f1d04a8e7b036
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><br><br><div class=3D"gmail_quote"><div dir=3D"ltr"><div><=
br></div><div>i have installed xenomai on arm based taget board. Now i woul=
d like to cross compile a userspace program on my host machine. If i done i=
t as below it giving me error ,=A0CFLAGS undefined variable. some one pleas=
e let me know what exact way to cross compile a xenomai userspace program.<=
/div>

<div><br></div><div><br></div><div><div>CFLAGS =3D`DESTDIR=3D/home/balijepa=
lli/omap4/root /home/balijepalli/omap4/root/usr/xenomai/bin/xeno-config --s=
kin native --cflags` LDFLAGS=3D`DESTDIR=3D/home/balijepalli/omap4/root =A0/=
home/balijepalli/omap4/root/usr/xenomai/bin/xeno-config --skin native --ldf=
lags` arm-none-linux-gnueabi-gcc -o st $CFLAGS st.c$LDFLAGS</div>

<div><br></div><br><br>Suresh balijepalli<br>Rosenehim,Baveria.<br>
</div></div>
<br></div><br><br clear=3D"all"><br>-- <br><br>Suresh balijepalli<br>Rosene=
him,Baveria.<br>
</div>

--bcaec53ae7fa530f1d04a8e7b036--

