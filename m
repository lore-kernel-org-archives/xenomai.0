From: Philippe Gerum <rpm@xenomai.org>
In-Reply-To: <000001cbc57f$6e0b1690$4a2143b0$@de>
References: <mailman.9723.1296855625.10284.xenomai@xenomai.org>
	<000001cbc4b0$03297d50$097c77f0$@de> <1296858744.2087.44.camel@domain.hid>
	<000001cbc57f$6e0b1690$4a2143b0$@de>
Content-Type: text/plain; charset="UTF-8"
Date: Sun, 06 Feb 2011 10:16:10 +0100
Message-ID: <1296983770.2036.5.camel@domain.hid>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Xenomai-help] [    1.954665] Xenomai: native skin init failed,
 code -19
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Franz Engel <franz_lambert_engel@domain.hid>
Cc: xenomai@xenomai.org

On Sat, 2011-02-05 at 22:55 +0100, Franz Engel wrote:
> Sorry. I'm a kernel newbie. I found the line " else if (check_c1e_idle(c)=
) " in the process.c and replace it with " else if (maybe_c1e && check_c1e_=
idle(c)) " manually. And now it works!!!
>=20

The patch will allow Xenomai to boot properly, but if your machine
suffers from AMD erratum 400, it may now experience interrupt lossage
when C1E is active.

The only solution to this is to disable C1E completely in your BIOS.
Switching off "Cool & Quiet mode" did not do the trick, since your CPUs
still advertised C1E after this. You should really inspect other
configuration menus in your BIOS to find a better match.

> Philippe, thank you very much!
>=20
> -----Urspr=C3=BCngliche Nachricht-----
> Von: Philippe Gerum [mailto:rpm@xenomai.org
> Gesendet: Freitag, 4. Februar 2011 23:32
> An: Franz Engel
> Cc: xenomai@xenomai.org
> Betreff: Re: [Xenomai-help] [ 1.954665] Xenomai: native skin init failed,=
 code -19
>=20
> On Fri, 2011-02-04 at 22:10 +0100, Franz Engel wrote:
> > Here is my full boot log:
>=20
> [snip]
>=20
> > [    0.030589] tseg: 0000000000
> > [    0.030596] CPU: Physical Processor ID: 0
> > [    0.030626] CPU: Processor Core ID: 0
> > [    0.030657] mce: CPU supports 6 MCE banks
> > [    0.030692] using C1E aware idle routine
>=20
> This means that you are not running the patched kernel. There is no way
> the c1e_idle routine which outputs the above message could run with it
> applied.
>=20
> [snip]
>=20
> > [    0.030000] CPU: L2 Cache: 512K (64 bytes/line)
> > [    0.030000] CPU 1/0x1 -> Node 0
> > [    0.030000] CPU: Physical Processor ID: 0
> > [    0.030000] CPU: Processor Core ID: 1
> > [    0.430096] CPU1: AMD Phenom(tm) II X6 1055T Processor stepping 00
> > [    0.430357] checking TSC synchronization [CPU#0 -> CPU#1]: passed.
> > [    0.440015] System has AMD C1E enabled
>=20
> This means you BIOS did not disable C1E properly. The CPU still
> advertises this mode.=20
>=20
> In fact, once C1E is properly disabled by the BIOS, you should not need
> the patch at all.
>=20
> Please check your BIOS setup and kernel install. You don't seem to be
> running what you think you do actually.
>=20

--=20
Philippe.



