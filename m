From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16146.53393.27248.460652@domain.hid>
Date: Mon, 14 Jul 2003 17:47:29 +0200
Subject: [Adeos-main] Patches 2.6.0test1/r1c1 and 2.4/r8c2
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

Two new candidate patches are available. The first one is against
2.6.0-test1. Preliminary hammering tests on a dual PIII have shown no
problem so far in SMP mode, but since no concurrent domain was running
aside of Linux, don't bet your house on it, yet.

The second one (r8c2) is against 2.4.{19,20,21}, and fixes a nasty
race condition in the domain switch code. Upgrading to r8c2 is highly
recommended.

These patches can be found here:
http://savannah.nongnu.org/cgi-bin/viewcvs/adeos/adeos/patches/linux/

If no showstopper pops up, Adeos milestone #3 will be released by the
end of this week.

Philippe.


