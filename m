From: Philippe Gerum <philippe.gerum@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16194.25859.334512.296898@domain.hid>
Date: Tue, 19 Aug 2003 19:57:23 +0200
Subject: [Adeos-main] Adeos 2.4r9c1/2.6r2c1 and porting guide
Reply-To: philippe.gerum@domain.hid
List-Id: <adeos-main.nongnu.org>
List-Unsubscribe: <http://mail.nongnu.org/mailman/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
List-Archive: <http://mail.gnu.org/pipermail/adeos-main>
List-Post: <mailto:adeos-main@gna.org>
List-Help: <mailto:adeos-main-request@domain.hid>
List-Subscribe: <http://mail.nongnu.org/mailman/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
To: adeos-main@gna.org


Hi,

New candidate Adeos patches for 2.4 are available here:

http://savannah.gnu.org/download/adeos/linux/v2.4/candidates/

The same goes for 2.6:

http://savannah.gnu.org/download/adeos/linux/v2.6/candidates/

The changes since r8 were mainly aimed at updating the core support so
that combining Robert Love's preemptible kernel patches, Andrew
Morton's low-latency patches and Adeos in a single combo patch is now
possible.

I've also written a porting note containing practical information one
might need to port Adeos to other target architectures. This document
is available here:

http://savannah.gnu.org/download/adeos/doc/porting.txt

Philippe.


