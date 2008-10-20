Message-ID: <48FC68C3.4020604@domain.hid>
Date: Mon, 20 Oct 2008 13:17:23 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Subject: [Xenomai-core] [PATCH] udev rules: stricter file permissions
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: xenomai-core <xenomai@xenomai.org>

Don't allow the world to access special Xenomai devices. Suggest to use
a separate group for managing access (udev will fall back to root if
group does not exist).

Index: xenomai/ksrc/nucleus/udev/rtheap.rules
===================================================================
--- xenomai/ksrc/nucleus/udev/rtheap.rules	(Revision 4265)
+++ xenomai/ksrc/nucleus/udev/rtheap.rules	(Arbeitskopie)
@@ -1,2 +1,2 @@
 # real-time heap device (Xenomai:rtheap)
-KERNEL=="rtheap", MODE="0666"
+KERNEL=="rtheap", MODE="0660", GROUP=="xenomai"
Index: xenomai/ksrc/nucleus/udev/rtpipe.rules
===================================================================
--- xenomai/ksrc/nucleus/udev/rtpipe.rules	(Revision 4265)
+++ xenomai/ksrc/nucleus/udev/rtpipe.rules	(Arbeitskopie)
@@ -1,2 +1,2 @@
 # real-time pipe devices (Xenomai:rtpipe)
-KERNEL=="rtp[0-9]*", MODE="0666"
+KERNEL=="rtp[0-9]*", MODE="0660", GROUP="xenomai"
-- 
Siemens AG, Corporate Technology, CT SE 2
Corporate Competence Center Embedded Linux

