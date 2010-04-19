From: Jan Kiszka <jan.kiszka@domain.hid>
Date: Mon, 19 Apr 2010 12:29:05 +0200
Message-Id: <8337fc5b6077556ba11f308d5b6bfc6bac6ab241.1271672940.git.jan.kiszka@domain.hid>
In-Reply-To: <cover.1271672940.git.jan.kiszka@domain.hid>
References: <cover.1271672940.git.jan.kiszka@domain.hid>
In-Reply-To: <cover.1271672940.git.jan.kiszka@domain.hid>
References: <cover.1271672940.git.jan.kiszka@domain.hid>
Subject: [Xenomai-core] [PATCH v4 25/25] RTDM: Use non-atomic bitops for
	used_fildes
List-Id: Xenomai life and development <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: xenomai-core <xenomai@xenomai.org>

All bit manipulations happen under rt_fildes_lock, so there is no need
for atomic ops.

Signed-off-by: Jan Kiszka <jan.kiszka@domain.hid>
---
 ksrc/skins/rtdm/core.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/ksrc/skins/rtdm/core.c b/ksrc/skins/rtdm/core.c
index bf905df..11102e2 100644
--- a/ksrc/skins/rtdm/core.c
+++ b/ksrc/skins/rtdm/core.c
@@ -125,7 +125,7 @@ static int create_instance(struct rtdm_device *device,
 	}
 
 	fd = find_first_zero_bit(used_fildes, RTDM_FD_MAX);
-	set_bit(fd, used_fildes);
+	__set_bit(fd, used_fildes);
 	open_fildes++;
 
 	xnlock_put_irqrestore(&rt_fildes_lock, s);
@@ -175,7 +175,7 @@ static int create_instance(struct rtdm_device *device,
 
 static void __cleanup_fildes(struct rtdm_fildes *fildes)
 {
-	clear_bit((fildes - fildes_table), used_fildes);
+	__clear_bit((fildes - fildes_table), used_fildes);
 	fildes->context = NULL;
 	open_fildes--;
 }
-- 
1.6.0.2


