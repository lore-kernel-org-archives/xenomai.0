From: Gunter Grau <gunter.grau@philips.com>
Subject: [PATCH] arm_global_timer: Use 64 Bit hw counter for ipipe_tsc
Date: Fri,  5 Mar 2021 09:22:59 +0100
Message-Id: <20210305082259.18424-1-gunter.grau@philips.com>
MIME-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

When using the arm_global_timer as source for ipipe_tsc the mask
was configured with 32 Bit.
However this timer is a native 64 Bit counter. So use the complete
hardware register by configuring a 64 Bit mask on initialization.
The ipipe_tsc implementation is already 64 Bit ready and reads this
register as described in the reference manual, so no further
changes needed.

Signed-off-by: Gunter Grau <gunter.grau@philips.com>
---
 drivers/clocksource/arm_global_timer.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/clocksource/arm_global_timer.c b/drivers/clocksource/a=
rm_global_timer.c
index 77c116a3e85f..44c10e364f62 100644
--- a/drivers/clocksource/arm_global_timer.c
+++ b/drivers/clocksource/arm_global_timer.c
@@ -82,7 +82,7 @@ static inline void gt_ipipe_cs_setup(void)
                .u =3D {
                        {
                                .counter_paddr =3D gt_pbase,
-                               .mask =3D 0xffffffff,
+                               .mask =3D CLOCKSOURCE_MASK(64),
                        }
                },
                .refresh_freq =3D refresh_gt_freq,
--
2.17.1


________________________________
The information contained in this message may be confidential and legally p=
rotected under applicable law. The message is intended solely for the addre=
ssee(s). If you are not the intended recipient, you are hereby notified tha=
t any use, forwarding, dissemination, or reproduction of this message is st=
rictly prohibited and may be unlawful. If you are not the intended recipien=
t, please contact the sender by return e-mail and destroy all copies of the=
 original message.

