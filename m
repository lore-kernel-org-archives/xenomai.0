Date: Fri, 12 Sep 2008 12:20:22 -0700 (PDT)
From: George Pitich <george_pitich@domain.hid>
In-Reply-To: <48CAACEF.3010902@domain.hid>
MIME-Version: 1.0
Content-Type: multipart/alternative; boundary="0-1224276114-1221247222=:74725"
Message-ID: <219129.74725.qm@domain.hid>
Subject: [Xenomai-help] compile error xenomai 2.4.5
Reply-To: george_pitich@domain.hid
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

--0-1224276114-1221247222=:74725
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable

Tried to compile linux 2.6.26.5 kernel with xenomai 2.4.5 (also ran ./confi=
gure --disable-x86-tsc --enable-x86-sep)

./prepare-kernel.sh=A0 --arch=3Di386 --adeos=3D/usr/src/xenomai-2.4.5/ksrc/=
arch/x86/patches/adeos-ipipe-2.6.26-x86-2.0-09.patch --linux=3D/usr/src/lin=
ux-2.6.26.5

make gave the error:

arch/x86/xenomai/hal_32.c: In function =E2rthal_latency_above_max=E2:
arch/x86/xenomai/hal_32.c:139: error: implicit declaration of function =E2d=
ie_nmi=E2
make[1]: *** [arch/x86/xenomai/hal_32.o] Error 1
make: *** [arch/x86/xenomai] Error 2

Thanks
=0A=0A=0A      
--0-1224276114-1221247222=:74725
Content-Type: text/html; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable

<table cellspacing=3D"0" cellpadding=3D"0" border=3D"0" ><tr><td valign=3D"=
top" style=3D"font: inherit;">Tried to compile linux 2.6.26.5 kernel with x=
enomai 2.4.5 (also ran ./configure --disable-x86-tsc --enable-x86-sep)<br><=
br>./prepare-kernel.sh&nbsp; --arch=3Di386 --adeos=3D/usr/src/xenomai-2.4.5=
/ksrc/arch/x86/patches/adeos-ipipe-2.6.26-x86-2.0-09.patch --linux=3D/usr/s=
rc/linux-2.6.26.5<br><br>make gave the error:<br><br>arch/x86/xenomai/hal_3=
2.c: In function =E2rthal_latency_above_max=E2:<br>arch/x86/xenomai/hal_32.=
c:139: error: implicit declaration of function =E2die_nmi=E2<br>make[1]: **=
* [arch/x86/xenomai/hal_32.o] Error 1<br>make: *** [arch/x86/xenomai] Error=
 2<br><br>Thanks<br></td></tr></table><br>=0A=0A      
--0-1224276114-1221247222=:74725--

