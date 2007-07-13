Content-Type: text/plain; charset="iso-8859-1"
Date: Fri, 13 Jul 2007 17:35:35 +0200
From: "Karl Reichert" <Karl-Trampe@domain.hid>
In-Reply-To: <1184339061.6014.281.camel@domain.hid>
Message-ID: <20070713153535.213000@domain.hid>
MIME-Version: 1.0
References: <20070713092440.281340@domain.hid> <469746E9.6050503@domain.hid>	
	<20070713094331.281350@domain.hid> <1184323717.6014.248.camel@domain.hid>	
	<20070713133750.277260@domain.hid> <1184335303.6014.268.camel@domain.hid>	
	<20070713143914.212980@domain.hid> <1184338266.6014.276.camel@domain.hid>	
	<20070713145756.212990@domain.hid> <1184339061.6014.281.camel@domain.hid>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Xenomai-help] error compiling linux 2.6.22 or 2.6.22.1
	with	adeos-ipipe-2.6.22-rc6-i386-1.9-00.patch
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: rpm@xenomai.org
Cc: xenomai@xenomai.org, jan.kiszka@domain.hid

Philippe Gerum wrote:
> On Fri, 2007-07-13 at 16:57 +0200, Karl Reichert wrote:
> > Philippe Gerum wrote:
> > > On Fri, 2007-07-13 at 16:39 +0200, Karl Reichert wrote:
> > > > Philippe Gerum wrote:
> > > > > On Fri, 2007-07-13 at 15:37 +0200, Karl Reichert wrote:
> > > > > > Philippe Gerum wrote:
> > > > > > > On Fri, 2007-07-13 at 11:43 +0200, Karl Reichert wrote:
> > > > > > >=20
> > > > > > > > But I tried with adeos-ipipe-2.6.22-rc6-i386-1.9-00.patch.
> Where
> > > can
> > > > > I
> > > > > > > get ipipe-2.6.22-i386-1.8-05? It's not listed on the FTP! I
> can
> > > only
> > > > > find
> > > > > > > ipipe-2.6.20-i386-1.8-05 (which is for 2.6.20 kernels).
> > > > > > >=20
> > > > > > > The final I-pipe patch for 2.6.22 is currently undergoing
> survival
> > > > > test
> > > > > > > under extremely unreasonable load on by boxen. Please wait.
> > > > > > >=20
> > > > > > > --=20
> > > > > > > Philippe.
> > > > > > >=20
> > > > > > So I took adeos-ipipe-2.6.20-i386-1.7-03.patch (xenomai 2.3.1)
> with
> > > > > linux2.6.20.11 and linux2.6.20.15 but with both the same problem.
> > > Patching and
> > > > > preparing works fine as make menuconfig does, but when compiling
> make
> > > says:
> > > > > > [...]
> > > > > > AS arch/i386/kernel/entry.o
> > > > > > arch/i386/kernel/entry.S: Assembler messages:
> > > > > > arch/i386/kernel/entry.S:270: invalid character '_' in mnemonic
> > > > > > arch/i386/kernel/entry.S:347: invalid character '_' in mnemonic
> > > > > > arch/i386/kernel/entry.S:477: invalid character '_' in mnemonic
> > > > > > arch/i386/kernel/entry.S:520: invalid character '_' in mnemonic
> > > > > > arch/i386/kernel/entry.S:534: invalid character '_' in mnemonic
> > > > > > [...]
> > > > >=20
> > > > > Disable CONFIG_PARAVIRT, or upgrade to 2.6.20-1.8-05. The latest
> patch
> > > > > for 2.6.22 is now available.
> > > > >=20
> > > > Thanks a lot, setting this to no solved the issue. Where do I get
> the
> > > patch? I can't find it in the online SVN (web access).
> > > >=20
> > >=20
> > >
> http://download.gna.org/adeos/patches/v2.6/i386/older/adeos-ipipe-2.6.20-=
i386-1.8-05.patch
> > >
> http://download.gna.org/adeos/patches/v2.6/i386/adeos-ipipe-2.6.22-i386-1=
.9-00.patch

Still get the same error while compiling 2.6.22.1 with 1.9 adeos patch:
[...]
In file included from include/asm/xenomai/hal.h:40,
>>from kernel/xenomai/arch/generic/hal.c:42:
include/asm/xenomai/wrappers.h: in function wrap_switch_iobitmap:
include/asm/xenomai/wrappers.h:86: error: struct tss_struct has no element =
named io_bitmap_base
include/asm/xenomai/wrappers.h:96: error: struct tss_struct has no element =
named io_bitmap_base
[...]
(gcc is 4.1.2)



> > >=20
> > > > > >=20
> > > > > > What's the case here now? I installed all dependencies.
> > > > > >=20
> > > > > > Karl
> > > > > --=20
> > > > > Philippe.
> > > > >=20
> > > > Karl
> > > --=20
> > > Philippe.
> > >=20
> > Thank you very much. Maybe this hint about paravirtualization should be
> added to Xenomai FAQ. Otherwise somebody else could get the same issues.
>=20
> This was a transient bug from the 1.7 series, fixed in later revisions,
> so documenting it into the FAQ would be meaningless; adding an entry
> into the Wiki, maybe. In any case, this is one more reason to use recent
> patches when available.
>=20
> --=20
> Philippe.
>=20
>=20

--=20
von Karl Reichert

Psssst! Schon vom neuen GMX MultiMessenger geh=F6rt?
Der kanns mit allen: http://www.gmx.net/de/go/multimessenger

