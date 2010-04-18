From: Jan Kiszka <Jan Kiszka jan.kiszka@domain.hid>
Date: Sun, 18 Apr 2010 15:12:34 +0200
Message-Id: <44f06d48e0f1ef368c413dec575d216e0cd7c55f.1271596367.git.Jan
	Kiszka jan.kiszka@domain.hid>
In-Reply-To: <cover.1271596366.git.Jan Kiszka jan.kiszka@domain.hid>
References: <cover.1271596366.git.Jan Kiszka jan.kiszka@domain.hid>
In-Reply-To: <cover.1271596366.git.Jan Kiszka jan.kiszka@domain.hid>
References: <cover.1271596366.git.Jan Kiszka jan.kiszka@domain.hid>
Sender: jan.kiszka@domain.hid
Subject: [Xenomai-core] [PATCH v3 10/24] Analogy: Drop support for
	opening/closing in real-time
List-Id: Xenomai life and development <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: Jan Kiszka <jan.kiszka@domain.hid>, xenomai-core <xenomai@xenomai.org>, Alexis Berlemont <berlemont.hauw@domain.hid>

From: Jan Kiszka <jan.kiszka@domain.hid>

This is deprected now, RT callers will automatically be switched to
non-RT.

CC: Alexis Berlemont <berlemont.hauw@domain.hid>
Signed-off-by: Jan Kiszka <jan.kiszka@domain.hid>
---
 ksrc/drivers/analogy/rtdm_interface.c |    2 --
 1 files changed, 0 insertions(+), 2 deletions(-)

diff --git a/ksrc/drivers/analogy/rtdm_interface.c b/ksrc/drivers/analogy/rtdm_interface.c
index f769e4a..99abf2f 100644
--- a/ksrc/drivers/analogy/rtdm_interface.c
+++ b/ksrc/drivers/analogy/rtdm_interface.c
@@ -227,11 +227,9 @@ static struct rtdm_device rtdm_devs[A4L_NB_DEVICES] =
 		.context_size =		sizeof(struct a4l_dummy_context),
 		.device_name = 		"",
 
-		.open_rt =		a4l_rt_open,
 		.open_nrt =		a4l_rt_open,
 
 		.ops = {
-			.close_rt =	a4l_rt_close,
 			.ioctl_rt =	a4l_rt_ioctl,
 			.read_rt =	a4l_rt_read,
 			.write_rt =	a4l_rt_write,
-- 
1.6.0.2


