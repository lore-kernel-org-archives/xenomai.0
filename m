From: Philippe Gerum <philippe.gerum@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16090.12900.872529.963156@domain.hid>
Date: Sun, 1 Jun 2003 19:05:40 +0200
Subject: [Adeos-main] Adeos/armnommu
Reply-To: philippe.gerum@domain.hid
List-Id: <adeos-main.nongnu.org>
List-Help: <mailto:adeos-main-request@domain.hid>
List-Post: <mailto:adeos-main@gna.org>
List-Subscribe: <http://mail.nongnu.org/mailman/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
List-Archive: <http://mail.gnu.org/pipermail/adeos-main>
List-Unsubscribe: <http://mail.nongnu.org/mailman/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
To: adeos-main@gna.org
Cc: rtai@domain.hid


Hi,

Adeos has just been ported to a MMU-less ARM architecture (Atmel
AT91x). The port is of course based on uClinux ('20030305' snapshot).
You can even play with it using GDB's ARMulator support.

Patch against uClinux-20030305/linux-2.4.x available here:
http://savannah.nongnu.org/cgi-bin/viewcvs/adeos/adeos/patches/linux/adeos-linux-2.4.20-uc0-r7c2.diff

Philippe.


