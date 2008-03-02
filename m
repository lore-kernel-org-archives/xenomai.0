Message-ID: <47CA8379.9070009@domain.hid>
Date: Sun, 02 Mar 2008 11:37:45 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig5C61FF6529E3B366D493DF42"
Sender: jan.kiszka@domain.hid
Subject: [Xenomai-help] [PATCH 0/6] Fix, refactor,
	and optimize xnlock services, v2
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

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig5C61FF6529E3B366D493DF42
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

Hi,

here comes version 2 of my xnlock rework. Changes since the first
release:

 - Moved xnlock_spin out-of-line instead uninlining the irqsave/restore
   services
 - Beautified xnlock_dbg interface (now only static-inlines)
 - Split-up basic xnlock_dbg refactoring from whitespace fixes
   (interdiff is your friend)
 - Added support for xnlock debugging on UP
 - Dropped barrier patch (already merged)

The text size reduction of this series (for CONFIG_SMP, without
debugging (CONFIG_DEBUG_INFO was on, though), and without enabling
ticket locks):

Before:
   text    data     bss     dec     hex filename
  75371    2184     308   77863   13027 kernel/xenomai/skins/native/xeno_=
native.o
  27407    2256    1112   30775    7837 kernel/xenomai/skins/rtdm/xeno_rt=
dm.o
  96813    1472  160224  258509   3f1cd kernel/xenomai/skins/posix/xeno_p=
osix.o
 107476    5608  457140  570224   8b370 kernel/xenomai/nucleus/xeno_nucle=
us.o

After:
   text    data     bss     dec     hex filename
  71751    2184     308   74243   12203 kernel/xenomai/skins/native/xeno_=
native.o
  26570    2192    1112   29874    74b2 kernel/xenomai/skins/rtdm/xeno_rt=
dm.o
  91107    1392  160224  252723   3db33 kernel/xenomai/skins/posix/xeno_p=
osix.o
 102860    5496  454580  562936   896f8 kernel/xenomai/nucleus/xeno_nucle=
us.o

To estimate the latency reduction of this series (specifically due to
patch 3 and 4), I ran latency -p100 over several hours on a widely
isolated 1.6 GHz core (only Linux timer and rescheduling IRQs) under
cache calibrator load. The results:

RTH|-----lat min|-----lat avg|-----lat max|-overrun|----lat best|---lat w=
orst
Before:
RTS|       0.457|       1.450|      28.156|       0|    04:00:52/04:00:52=

After:
RTS|       0.450|       1.453|      23.283|       0|    06:37:19/06:37:19=


I'm sure this gain is far to much for this changes, ie. we are missing
some constellation in the second run that caused the 28 us peak in the
first run. However, the tendency matches other experiments I did with
more IRQ load on the target core. Any attempt to reproduce my results is
welcome!

Note that the above numbers do not yet include the gain from my
ipipe-head optimizations I posted a few days ago!

Jan


--------------enig5C61FF6529E3B366D493DF42
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.4-svn0 (GNU/Linux)
Comment: Using GnuPG with SUSE - http://enigmail.mozdev.org

iD8DBQFHyoN9niDOoMHTA+kRAoAKAJ95IWavoAuYPVF9hBYeaQK8g6GosACfdlga
Qo4gJ/lfYxdSk4pSkXqoiB8=
=UCSw
-----END PGP SIGNATURE-----

--------------enig5C61FF6529E3B366D493DF42--

