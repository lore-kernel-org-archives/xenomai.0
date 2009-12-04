MIME-Version: 1.0
Sender: aboeing@domain.hid
Date: Fri, 4 Dec 2009 17:11:32 +0800
Message-ID: <c024fefc0912040111s78a97159vde8d7391b5702acf@domain.hid>
From: Adrian Boeing <me@domain.hid>
Content-Type: multipart/alternative; boundary=0016e64ca3566c99d60479e37e80
Subject: [Xenomai-help] Problem with Xenomai Install
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Xenomai help <xenomai@xenomai.org>

--0016e64ca3566c99d60479e37e80
Content-Type: text/plain; charset=ISO-8859-1

Hi,

I have installed Xenomai on a PC, but when I try to run any of the examples
(rtprint, trivial-periodic, etc...) the system freezes.

Does anyone know what may have caused this?

I am using Ubuntu, 2.6.24.6 kernel, and /proc/xenomai/version is 2.4.10

I created the xenomai install by:
1. Getting linux source (apt-get source linux-image-$(uname -r)
2. Getting Xenomai & Adeos
3. Added a new CAN driver to Xenomai
4. Prepareing xenomai (scripts/prepare-kernel.sh --linux=~/linux-2.6.24/
--adeos=~/Desktop/adeos-ipipe-2.6.24-x86-2.0.7-patch)
5. Make kernel (make-kpkg --ignited kernel_image modules)
6. Add kernel to grub (dpkg -i)
7. Installed Xenomai libraries (make install)
8. Set up the C libs (cp /etc/ld.so.conf.d/libc.conf
/etc/ld.so.conf.d/xenomai.conf)

I also noticed I don't have a /usr/src/xenomai, but have the xenomai source
in my home directory from when I first downloaded it.

Thanks,
-Adrian

--0016e64ca3566c99d60479e37e80
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Hi,<div><br></div><div>I have installed Xenomai on a PC, but when I try to =
run any of the examples (rtprint, trivial-periodic, etc...) the system free=
zes.</div><div><br></div><div>Does anyone know what may have caused this?</=
div>
<div><br></div><div>I am using Ubuntu, 2.6.24.6 kernel, and /proc/xenomai/v=
ersion is 2.4.10</div><div><br></div><div><div>I created the xenomai instal=
l by:</div><div>1. Getting linux source (apt-get source linux-image-$(uname=
 -r)</div>
<div>2. Getting Xenomai &amp; Adeos</div><div>3. Added a new CAN driver to =
Xenomai</div><div>4. Prepareing xenomai (scripts/prepare-kernel.sh --linux=
=3D~/linux-2.6.24/ --adeos=3D~/Desktop/adeos-ipipe-2.6.24-x86-2.0.7-patch)<=
/div>
<div>5. Make kernel (make-kpkg --ignited kernel_image modules)</div><div>6.=
 Add kernel to grub (dpkg -i)</div><div>7. Installed Xenomai libraries (mak=
e install)</div><div>8. Set up the C libs (cp /etc/ld.so.conf.d/libc.conf /=
etc/ld.so.conf.d/xenomai.conf)</div>
<div><br></div><div>I also noticed I don&#39;t have a /usr/src/xenomai, but=
 have the xenomai source in my home directory from when I first downloaded =
it.</div><div><br></div><div>Thanks,</div><div>-Adrian</div></div><div>
<font class=3D"Apple-style-span" face=3D"&#39;Times New Roman&#39;" size=3D=
"3"><span class=3D"Apple-style-span" style=3D"font-size: 12px; "><br></span=
></font></div><div><font class=3D"Apple-style-span" face=3D"&#39;Times New =
Roman&#39;" size=3D"3"><span class=3D"Apple-style-span" style=3D"font-size:=
 12px;"><br>
</span></font></div>

--0016e64ca3566c99d60479e37e80--

