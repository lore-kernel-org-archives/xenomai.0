Message-ID: <4BB10712.708@domain.hid>
Date: Mon, 29 Mar 2010 22:01:22 +0200
From: Roland Stigge <stigge@domain.hid>
MIME-Version: 1.0
References: <4BAFBF32.8030507@domain.hid>
In-Reply-To: <4BAFBF32.8030507@domain.hid>
Content-Type: multipart/mixed; boundary="------------080102090406090409070006"
Subject: Re: [Xenomai-core] [announce] Xenomai v2.5.2
List-Id: Xenomai life and development <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Xenomai core <Xenomai-core@domain.hid>

This is a multi-part message in MIME format.
--------------080102090406090409070006
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi!

Gilles Chanteperdrix wrote:
> here comes Xenomai v2.5.2, codenamed "Souls Of Distortion" available
> from Xenomai download area:
> http://download.gna.org/xenomai/stable/xenomai-2.5.2.tar.bz2

Cool, thanks!

I'm attaching a patch from Debian. I needed to introduce it because
without it, --with-test didn't cause /usr/bin/xeno to access the
executables in the specified directory.

Thanks for considering!

bye,
  Roland

--------------080102090406090409070006
Content-Type: text/x-patch;
 name="xenomai.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="xenomai.patch"

--- xenomai-2.5.2.orig/scripts/xeno.in
+++ xenomai-2.5.2/scripts/xeno.in
@@ -6,9 +6,6 @@
 # e.g. "xeno latency"
 #
 
-prefix="@prefix@"
-exec_prefix="@exec_prefix@"
-BINDIR="@bindir@"
-unset prefix exec_prefix
+XENO_TEST_DIR="@XENO_TEST_DIR@"
 
-exec $BINDIR/$@
+exec $XENO_TEST_DIR/$@

--------------080102090406090409070006--

