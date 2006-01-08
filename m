Message-ID: <43C18FCB.9080404@domain.hid>
Date: Sun, 08 Jan 2006 23:18:51 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enigF67DF28AFD1F25011E8CDB0E"
Sender: jan.kiszka@domain.hid
Subject: [Xenomai-core] [PATCH] fix tracer compilation issues
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Philippe Gerum <rpm@xenomai.org>
Cc: adeos-main@gna.org, xenomai-core <xenomai@xenomai.org>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigF67DF28AFD1F25011E8CDB0E
Content-Type: multipart/mixed; boundary="------------060300060605090908070004"

This is a multi-part message in MIME format.
--------------060300060605090908070004
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit

Hi Philippe,

two minor updates I fixed since your last merge. The first one triggers
if the tracer tries to warn of debugging switch related latencies. The
second one when building very specific out-of-tree modules against the
kernel (here: madwifi with its binary-only component), stumbling over
-pg vs. -fomit-frame-pointer.

No need for a separate ipipe release from my POV, just apply for the
next round.

Jan

--------------060300060605090908070004
Content-Type: text/plain;
 name="ipipe_tracer.update4"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="ipipe_tracer.update4"

--- ./kernel/ipipe/tracer.c.orig	2006-01-07 13:28:01.000000000 +0100
+++ ./kernel/ipipe/tracer.c	2006-01-08 23:08:45.000000000 +0100
@@ -821,7 +821,7 @@ static void *__ipipe_frozen_prtrace_star
 			"------------------------------------------------------"
 			"------\n",
 			UTS_RELEASE, IPIPE_ARCH_STRING);
-		__ipipe_print_dbgwarning();
+		__ipipe_print_dbgwarning(m);
 		seq_printf(m, "Freeze: %lld cycles, Trace Points: %d (+%d)\n\n",
 			print_path->point[print_path->begin].timestamp,
 			print_pre_trace+1, print_post_trace);
--- ./kernel/ipipe/Kconfig.orig	2006-01-07 13:28:01.000000000 +0100
+++ ./kernel/ipipe/Kconfig	2006-01-07 14:24:50.000000000 +0100
@@ -17,6 +17,7 @@ config IPIPE_STATS
 config IPIPE_TRACE
  	bool "Latency Tracing"
 	depends on IPIPE && PROC_FS
+	select FRAME_POINTER
 	default n
 	---help---
 	  Activate this option if you want to use per-function tracing of

--------------060300060605090908070004--

--------------enigF67DF28AFD1F25011E8CDB0E
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFDwY/LniDOoMHTA+kRAj2fAJ91preGDCrsAWMmCiSsFgtigqBmnQCdGB2g
njCo/yV51EtZbumYHk8q/j4=
=/DV5
-----END PGP SIGNATURE-----

--------------enigF67DF28AFD1F25011E8CDB0E--

