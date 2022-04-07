References: <48e0fc4f-0020-907c-136e-53f01e596fda@siemens.com>
From: Philippe Gerum <rpm@xenomai.org>
Subject: Re: 5.10-dovetail regression?
Date: Thu, 07 Apr 2022 17:24:15 +0200
In-reply-to: <48e0fc4f-0020-907c-136e-53f01e596fda@siemens.com>
Message-ID: <874k34gbk8.fsf@xenomai.org>
MIME-Version: 1.0
Content-Type: text/plain
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Jan Kiszka <jan.kiszka@siemens.com>
Cc: Xenomai <xenomai@xenomai.org>


Jan Kiszka <jan.kiszka@siemens.com> writes:

> Hi Philippe,
>
> does this already ring some bell?
>
> https://source.denx.de/Xenomai/xenomai-images/-/jobs/419210
>
> Only triggers with qemu-amd64, not on real HW and not with 5.15.
>

I could not reproduce locally, but visual inspection revealed something
fishy in #8e2c09ee5323. Could you try this on the failing kernel? TIA,

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
Philippe.

