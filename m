From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16248.43128.747526.269005@domain.hid>
Date: Mon, 29 Sep 2003 23:47:36 +0200
Subject: [Adeos-main] Adeos for 2.6.0-test6
Reply-To: rpm@xenomai.org
List-Id: <adeos-main.nongnu.org>
List-Unsubscribe: <http://mail.nongnu.org/mailman/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
List-Archive: <http://mail.gnu.org/pipermail/adeos-main>
List-Post: <mailto:adeos-main@gna.org>
List-Help: <mailto:adeos-main-request@domain.hid>
List-Subscribe: <http://mail.nongnu.org/mailman/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
To: adeos-main@gna.org


An Adeos patch (r2c3) against 2.6.0-test6 is available here:
http://savannah.nongnu.org/cgi-bin/viewcvs/adeos/adeos/patches/linux/adeos-linux-2.6.0-test6-r2c3.patch

It finalizes the CONFIG_PREEMPT support for Adeos.

There have been some reports that Adeos 2.6.0-r2 series still does not
work (i.e. hangs at boot time) on AMD Duron (800Mhz) boxen. If
somebody having this kind of hardware at hand wants to help, please
try booting a 2.6.0-test6 kernel including the r2c3 patch, and let me
know about the outcome.

TIA,

Philippe.


