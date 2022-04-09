From: Philippe  Gerum <rpm@xenomai.org>
Subject: [PATCH Dovetail-v5.10.y] tick: irq_pipeline: fix regression in
 clockevents_exchange_devices()
Date: Sat,  9 Apr 2022 12:40:54 +0200
Message-Id: <20220409104054.2056182-1-rpm@xenomai.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

From: Philippe Gerum <rpm@xenomai.org>

The recent change regarding the tick proxy device [1] introduced a
regression in clockevents_exchange_devices(), causing a corruption of
the device release list.

This does not affect the logic of the previous fix which remains
correct though.

[1] tick: irq_pipeline: fix proxying of a broadcast device

Signed-off-by: Philippe Gerum <rpm@xenomai.org>
---
 kernel/time/clockevents.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/time/clockevents.c b/kernel/time/clockevents.c
index 2651c6cfd034..da6735d45a8a 100644
--- a/kernel/time/clockevents.c
+++ b/kernel/time/clockevents.c
@@ -644,8 +644,8 @@ void clockevents_exchange_device(struct clock_event_device *old,
 		 * to the release list, keep it around but mark it as
 		 * reserved.
 		 */
+		list_del(&old->list);
 		if (tick_check_is_proxy(new)) {
-			list_del(&old->list);
 			clockevents_switch_state(old, CLOCK_EVT_STATE_RESERVED);
 		} else {
 			clockevents_switch_state(old, CLOCK_EVT_STATE_DETACHED);
-- 
2.35.1


