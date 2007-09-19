Message-ID: <23820.194.114.62.37.1190188945.squirrel@domain.hid>
In-Reply-To: <2ff1a98a0708160731k5eefd6b2i417b05b6d329e481@domain.hid>
References: <61839.194.114.62.68.1187258167.squirrel@domain.hid>
	<2ff1a98a0708160300r79a717ebt7541c1d6e3da6687@domain.hid>
	<11886.194.114.62.68.1187258877.squirrel@domain.hid>
	<18116.9932.592597.831501@domain.hid>
	<56493.194.114.62.68.1187265227.squirrel@domain.hid>
	<2ff1a98a0708160639k555fbb48p98a13892e30e5b02@domain.hid>
	<21067.194.114.62.68.1187272557.squirrel@domain.hid>
	<2ff1a98a0708160701w17dcf324jb9cb31843d69ca60@domain.hid>
	<4760.194.114.62.68.1187274071.squirrel@domain.hid>
	<2ff1a98a0708160731k5eefd6b2i417b05b6d329e481@domain.hid>
Date: Wed, 19 Sep 2007 10:02:25 +0200 (CEST)
From: "Nadym Salem" <Kaiman@domain.hid>
MIME-Version: 1.0
Content-Type: multipart/mixed;boundary="----=_20070919100225_45911"
Subject: Re: [Xenomai-help] latency problems
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: xenomai@xenomai.org

------=_20070919100225_45911
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

On Thu, August 16, 2007 16:31, Gilles Chanteperdrix wrote:
> On 8/16/07, Nadym Salem <Kaiman@domain.hid> wrote:
>> On Thu, August 16, 2007 16:01, Gilles Chanteperdrix wrote:
>> > Aha, this probably means that your chipset is not supporte, could yo=
u
>> > run lspci and send us the output ?
>> it is attached.
> Could you try to apply the attached patch to xenomai sources ? You
> will then have to recompile your xenomai-patched kernel.

Hmm, I have a new (quite old) machine now and installed Xenomai 2.3.3,
having the same problem as before. The SMI workaround doesn't appear in
the kernel log at all. Last time you gave me a "patch" for smi.c after
which the system at least tried to start the smi workaround. Is there
another possibility like that for my other machine ? I attached the outpu=
t
of lspci.

tx in advance,

greets, Nadym

PS: Could it be, that this machine doesn't have SMIs at all ?

------=_20070919100225_45911
Content-Type: text/plain; name="lspci.out"
Content-Disposition: attachment; filename="lspci.out"
Content-Transfer-Encoding: quoted-printable

00:00.0 Host bridge: VIA Technologies, Inc. P4M266 Host Bridge
00:01.0 PCI bridge: VIA Technologies, Inc. VT8633 [Apollo Pro266 AGP]
00:09.0 Ethernet controller: Intel Corporation 82541PI Gigabit Ethernet C=
ontroller (rev 05)
00:0b.0 CardBus bridge: Ricoh Co Ltd RL5c475 (rev 81)
00:11.0 ISA bridge: VIA Technologies, Inc. VT8235 ISA Bridge
00:11.1 IDE interface: VIA Technologies, Inc. VT82C586A/B/VT82C686/A/B/VT=
823x/A/C PIPC Bus Master IDE (rev 06)
00:11.5 Multimedia audio controller: VIA Technologies, Inc. VT8233/A/8235=
/8237 AC97 Audio Controller (rev 50)
00:12.0 Ethernet controller: VIA Technologies, Inc. VT6102 [Rhine-II] (re=
v 74)
01:00.0 VGA compatible controller: S3 Inc. VT8375 [ProSavage8 KM266/KL266=
]
02:00.0 Class ff00: Unknown device 1974:0005 (rev 01)
------=_20070919100225_45911--



