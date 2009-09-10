From: Jonathan Haws <Jonathan.Haws@domain.hid>
Date: Thu, 10 Sep 2009 14:05:33 -0600
Message-ID: <BB99A6BA28709744BF22A68E6D7EB51F03248BDB59@domain.hid>
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: [Xenomai-help] Installation and Makefile Help
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: "xenomai@xenomai.org" <xenomai@xenomai.org>

All,

I am new to Xenomai, so please bear with me.

I have a question regarding creating Makefiles for building Xenomai enabled=
 programs.  I would like to simply use "xeno-config" to set my CFLAGS and L=
DFLAGS settings in the Makefile.

However, the problem I run into is that my target (AMCC 405EX PPC system) r=
equires that I have the --prefix option set to /usr/local/xenomai.  However=
, that is not the real path to where the libraries are installed on my host=
 system.  They are at ~/eldk/ppc_4xx/usr/local/xenomai.  I then have a scri=
pt that will build a ramdisk and pull the libraries from the correct locati=
on (if anyone has used the root filesystem builder from Denx that is how I =
am doing it).=20

How can I fix that discrepancy?  I would like to accomplish this the correc=
t way and if that is simply creating a symlink, so be it.

Thanks!

Jonathan



