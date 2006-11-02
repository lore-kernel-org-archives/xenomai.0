Message-ID: <1650.132.206.72.156.1162501966.squirrel@domain.hid>
Date: Thu, 2 Nov 2006 16:12:46 -0500 (EST)
From: vleves@domain.hid
MIME-Version: 1.0
Content-Type: text/plain;charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable
Subject: [Xenomai-help] Xenomai on Ubuntu 6.10 (Edgy Eft)
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

Hello all,

Just in case anyone else wants to use Ubuntu 6.10 (Edgy Eft) with
Xenomai... It seems that Ubuntu decided to enable by default a compile
flag that other distributions typically leave disabled. As a result, it
can only compile kernels patched for Ubuntu. Unfortunately, I wasn't able
to apply Xenomai patches on top of Ubuntu's pre-patched kernel. The
workaround consists of adding the flag "-fno-stack-protector" to CFLAGS i=
n
the vanilla kernel's Makefile. It's already done in kernel 2.6.18.
Otherwise Xenomai 2.2.4 seems to work just fine.

Vincent Levesque
vleves@domain.hid



