Content-Type: text/plain; charset="iso-8859-1"
Date: Fri, 13 Jul 2007 11:24:40 +0200
From: "Karl Reichert" <Karl-Trampe@domain.hid>
Message-ID: <20070713092440.281340@domain.hid>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: [Xenomai-help] error compiling linux 2.6.22 or 2.6.22.1 with
 adeos-ipipe-2.6.22-rc6-i386-1.9-00.patch
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: xenomai-help <xenomai@xenomai.org>

Hello,

tried the adeos-ipipe-2.6.22-rc6-i386-1.9-00.patch, but it works neither wi=
th linux 2.6.20 nor 2.6.20.1
patch and prepare-kernel.sh worked, after make menuconfig I tried to compil=
e with make and get the following (my gcc gives me german errors, so I trie=
d to translate as good as possible):
[...]
In file included from include/asm/xenomai/hal.h:40,
>from kernel/xenomai/arch/generic/hal.c:42:
include/asm/xenomai/wrappers.h: in function wrap_switch_iobitmap:
include/asm/xenomai/wrappers.h:86: error: struct tss_struct has no element =
named io_bitmap_base
include/asm/xenomai/wrappers.h:96: error: struct tss_struct has no element =
named io_bitmap_base
[...]

Any hints? My gcc is 4.1.2

Thanks in advance
--=20
von Karl Reichert

Psssst! Schon vom neuen GMX MultiMessenger geh=F6rt?
Der kanns mit allen: http://www.gmx.net/de/go/multimessenger

