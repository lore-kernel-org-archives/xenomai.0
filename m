From: Jan Kiszka <jan.kiszka@web.de>
Subject: [PATCH] irq_pipeline: Prevent returning to user space with pending
 inband IRQs
Message-ID: <0531d2db-aa87-1950-6d7f-41c80d4fe679@web.de>
Date: Sun, 6 Jun 2021 14:35:48 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Xenomai <xenomai@xenomai.org>, Philippe Gerum <rpm@xenomai.org>

From: Jan Kiszka <jan.kiszka@siemens.com>

The correct order is hard IRQs off first, then stalling inband, see also
I-pipe. Otherwise, we risk to take an interrupt for the inband stage but
do not inject it before returning to user space.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
=2D--

Fixes the RCU stalls Florian reported, at least for me.

I'm afraid this wasn't the last regression of translating I-pipe into
dovetail..

 include/linux/entry-common.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/include/linux/entry-common.h b/include/linux/entry-common.h
index 0fb45b2d6094..00540110985e 100644
=2D-- a/include/linux/entry-common.h
+++ b/include/linux/entry-common.h
@@ -203,7 +203,8 @@ static inline void local_irq_disable_exit_to_user(void=
);
 #ifndef local_irq_disable_exit_to_user
 static inline void local_irq_disable_exit_to_user(void)
 {
-	local_irq_disable_full();
+	hard_cond_local_irq_disable();
+	local_irq_disable();
 }
 #endif

=2D-
2.26.2

