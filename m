Message-ID: <44A29429.4060609@domain.hid>
Date: Wed, 28 Jun 2006 16:37:29 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-core] [PATCH 6/6] Introduce IRQ latency benchmark
References: <20060626172116.019532000@domain.hid>
	<20060626172120.322015000@domain.hid>	
	<17570.29185.754625.871443@domain.hid>	
	<44A275DE.5080500@domain.hid>	
	<17570.34620.38518.404171@domain.hid>
	<b647ffbd0606280714q142553dag79cd39c4068992e8@domain.hid>
In-Reply-To: <b647ffbd0606280714q142553dag79cd39c4068992e8@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig1B40226CA4ACEFF161C3EF01"
Sender: jan.kiszka@domain.hid
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Dmitry Adamushko <dmitry.adamushko@domain.hid>
Cc: xenomai@xenomai.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig1B40226CA4ACEFF161C3EF01
Content-Type: multipart/mixed; boundary="------------080301050007070103020509"

This is a multi-part message in MIME format.
--------------080301050007070103020509
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Dmitry Adamushko wrote:
> On 28/06/06, Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org> wr=
ote:
>> Jan Kiszka wrote:
>>  >
>>  > Ok, then we also need a fix for the latency test (this is where I
>>  > grabbed that pattern from). Is there a high risk that this locks up=
? I
>>  > wonder why I never observed or heard of problems with latency.
>>
>> The latency test used to deadlock, that is why the summary printed on
>> signal is printed on stderr. Unfortunately, there seem to be one displ=
ay
>> left on stdout, so it should still deadlock. The reason why we never s=
ee
>> the deadlock is (perhaps) that the continuous intermediate results are=

>> printed on the context of the "display" thread, whereas the terminatio=
n
>> signals are preferably delivered by the kernel to the "main" thread,
>> that only calls pause. Which makes the use of stderr in signals handle=
rs
>> pointless.
>=20
> It's very likely so.
>=20
> The main thread would use instead something like :
> ...
> while (!sig_term_received)
>    pause();
>=20
> do_cleanup_chores();
> return 0;
>=20
> cleanup_upon_sig() should only set the sig_term_received flag up.
>=20
> Then all other threads must block signal delivering with sigprocmask()
> so that the main thread is the only one which "accepts" signals.

Is that required, i.e. does pause() only wake up if the signal handler
executed in the main thread's context? Then cyclictest contains a bug as
well...

>=20
> btw, according to POSIX 1003.1-2003, the write() call is amongst "safe"=

> ones.
> http://www.die.net/doc/linux/man/man2/signal.2.html
>=20
> So write(1, ....); heh... not that nice? :)
>=20
>=20

Something like this? Developed on top of my prio-switch patch. So far
without signal masking.

Jan

--------------080301050007070103020509
Content-Type: text/x-patch;
 name="fix-printf-from-sig.patch"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline;
 filename="fix-printf-from-sig.patch"

---
 src/testsuite/latency/latency.c |   46 ++++++++++++++++++++-------------=
-------
 1 file changed, 24 insertions(+), 22 deletions(-)

Index: xenomai/src/testsuite/latency/latency.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- xenomai.orig/src/testsuite/latency/latency.c
+++ xenomai/src/testsuite/latency/latency.c
@@ -293,7 +293,7 @@ double dump_histogram (long *histogram,=20
     double avg =3D 0;             /* used to sum hits 1st */
=20
     if (do_histogram)
-        fprintf(stderr,"---|--param|----range-|--samples\n");
+        printf("---|--param|----range-|--samples\n");
=20
     for (n =3D 0; n < histogram_size; n++)
         {
@@ -304,12 +304,11 @@ double dump_histogram (long *histogram,=20
             total_hits +=3D hits;
             avg +=3D n * hits;
             if (do_histogram)
-                fprintf(stderr,
-                        "HSD|    %s| %3d -%3d | %8ld\n",
-                        kind,
-                        n,
-                        n+1,
-                        hits);
+                printf("HSD|    %s| %3d -%3d | %8ld\n",
+                       kind,
+                       n,
+                       n+1,
+                       hits);
             }
         }
=20
@@ -338,8 +337,8 @@ void dump_stats (long *histogram, char*=20
     variance /=3D total_hits - 1;
     variance =3D sqrt(variance);
=20
-    fprintf(stderr,"HSS|    %s| %9d| %10.3f| %10.3f\n",
-            kind, total_hits, avg, variance);
+    printf("HSS|    %s| %9d| %10.3f| %10.3f\n",
+           kind, total_hits, avg, variance);
 }
=20
 void dump_hist_stats (void)
@@ -351,23 +350,18 @@ void dump_hist_stats (void)
     avgavg =3D dump_histogram (histogram_avg, "avg");
     maxavg =3D dump_histogram (histogram_max, "max");
=20
-    fprintf(stderr,"HSH|--param|--samples-|--average--|---stddev--\n");
+    printf("HSH|--param|--samples-|--average--|---stddev--\n");
=20
     dump_stats (histogram_min, "min", minavg);
     dump_stats (histogram_avg, "avg", avgavg);
     dump_stats (histogram_max, "max", maxavg);
 }
=20
-void cleanup_upon_sig(int sig __attribute__((unused)))
+void cleanup(void)
 {
     time_t actual_duration;
     long gmaxj, gminj, gavgj;
=20
-    if (finished)
-        return;
-
-    finished =3D 1;
-
     if (test_mode =3D=3D USER_TASK) {
         rt_sem_delete(&display_sem);
=20
@@ -421,6 +415,11 @@ void cleanup_upon_sig(int sig __attribut
     exit(0);
 }
=20
+void sighand(int sig __attribute__((unused)))
+{
+    finished =3D 1;
+}
+
 int main (int argc, char **argv)
 {
     int c, err;
@@ -532,7 +531,7 @@ int main (int argc, char **argv)
     histogram_min =3D calloc(histogram_size, sizeof(long));
=20
     if (!(histogram_avg && histogram_max && histogram_min))=20
-        cleanup_upon_sig(0);
+        cleanup();
=20
     if (period_ns =3D=3D 0)
         period_ns =3D 100000LL; /* ns */
@@ -542,10 +541,10 @@ int main (int argc, char **argv)
     else if (priority > T_HIPRIO)
         priority =3D T_HIPRIO;
=20
-    signal(SIGINT, cleanup_upon_sig);
-    signal(SIGTERM, cleanup_upon_sig);
-    signal(SIGHUP, cleanup_upon_sig);
-    signal(SIGALRM, cleanup_upon_sig);
+    signal(SIGINT, sighand);
+    signal(SIGTERM, sighand);
+    signal(SIGHUP, sighand);
+    signal(SIGALRM, sighand);
=20
     setlinebuf(stdout);
=20
@@ -610,7 +609,10 @@ int main (int argc, char **argv)
             }
     }
=20
-    pause();
+    while (!finished)
+        pause();
+
+    cleanup();
=20
     return 0;
 }

--------------080301050007070103020509--

--------------enig1B40226CA4ACEFF161C3EF01
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)
Comment: Using GnuPG with SUSE - http://enigmail.mozdev.org

iD8DBQFEopQqniDOoMHTA+kRAvXbAJ0UnJpNGyRXwvdY8Jm8T022XRRMfwCeJ0PA
DXXwznNVpSvMcODK/LpIlAE=
=I2xO
-----END PGP SIGNATURE-----

--------------enig1B40226CA4ACEFF161C3EF01--

