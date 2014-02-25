Message-ID: <530C8967.2050900@marel.com>
Date: Tue, 25 Feb 2014 12:15:35 +0000
From: Marcel van Mierlo <marcel.vanmierlo@marel.com>
MIME-Version: 1.0
References: <52FBA4D5.3010606@marel.com> <52FCA810.2080604@marel.com>
In-Reply-To: <52FCA810.2080604@marel.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"; Format="flowed"
Subject: [Xenomai] resource leak and kernel panic with pSOS q_vcreate on arm
 (BeagleBone Black)
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

Hi,

I posted this information a few weeks back but got no response...does =

anyone have insight on this...I've been digging into the queue =

management code in Xenomai but I'm not getting very far...any help on =

this would be appreciated as I am not sure what to try next.

This behaviour has been observed on BeagleBoard Black Linux arm =

3.8.13-bone26.1, Xenomai 2.6.3

basically the resources created by pSOS q_vcreate do not appear to be =

released when the application exits. q_create appears to be fine. When =

the application starts up again after exit (without calling q_vdelete), =

calling q_vcreate on the named queue returns (-17 File Exists). If I =

instead use q_vident to get a handle on the queue, the API appears to =

return with a valid handle, but when the program exits the second time =

Xenomai appears to sit in a resource-release loop and I end up with a =

kernel panic. This is a non-trivial application with about 30 running =

tasks and lots of fixed size queues using CAN. The system is stable =

except for v-queues so there certainly seems to be something amiss here. =

I have included a trivial test case which reproduces the problem.

[  144.346739] Kernel panic - not syncing: softlockup: hung tasks
[  144.352845] [<c00138dc>] (unwind_backtrace+0x0/0xe0) from =

[<c06b0af0>] (panic+0x84/0x1e0)
[  144.361426] [<c06b0af0>] (panic+0x84/0x1e0) from [<c0094724>] =

(watchdog_timer_fn+0x120/0x164)
[  144.370338] [<c0094724>] (watchdog_timer_fn+0x120/0x164) from =

[<c005e1c4>] (__run_hrtimer+0xec/0x1e4)
[  144.379976] [<c005e1c4>] (__run_hrtimer+0xec/0x1e4) from [<c005ec00>] =

(hrtimer_interrupt+0x108/0x25c)
[  144.389614] [<c005ec00>] (hrtimer_interrupt+0x108/0x25c) from =

[<c0025f88>] (omap2_gp_timer_interrupt+0x44/0x54)
[  144.400162] [<c0025f88>] (omap2_gp_timer_interrupt+0x44/0x54) from =

[<c0095144>] (handle_irq_event_percpu+0x60/0x214)
[  144.411156] [<c0095144>] (handle_irq_event_percpu+0x60/0x214) from =

[<c0095334>] (handle_irq_event+0x3c/0x5c)
[  144.421430] [<c0095334>] (handle_irq_event+0x3c/0x5c) from =

[<c0098260>] (handle_level_irq+0x98/0xd0)
[  144.430974] [<c0098260>] (handle_level_irq+0x98/0xd0) from =

[<c0094b7c>] (generic_handle_irq+0x20/0x30)
[  144.440700] [<c0094b7c>] (generic_handle_irq+0x20/0x30) from =

[<c000e45c>] (handle_IRQ+0x64/0x8c)
[  144.449886] [<c000e45c>] (handle_IRQ+0x64/0x8c) from [<c009e594>] =

(__ipipe_do_sync_stage+0x1f4/0x220)
[  144.459526] [<c009e594>] (__ipipe_do_sync_stage+0x1f4/0x220) from =

[<c009e710>] (ipipe_unstall_root+0x30/0x3c)
[  144.469887] [<c009e710>] (ipipe_unstall_root+0x30/0x3c) from =

[<c003e908>] (vprintk_emit+0x444/0x4bc)
[  144.479428] [<c003e908>] (vprintk_emit+0x444/0x4bc) from [<c003eb24>] =

(vprintk+0x1c/0x20)
[  144.487974] [<c003eb24>] (vprintk+0x1c/0x20) from [<c06b0d14>] =

(printk+0xa4/0x144)
[  144.495891] [<c06b0d14>] (printk+0xa4/0x144) from [<c0149638>] =

(psos_shadow_eventcb+0x7f8/0x16b8)
[  144.505169] [<c0149638>] (psos_shadow_eventcb+0x7f8/0x16b8) from =

[<c00db35c>] (detach_ppd+0x28/0x44)
[  144.514718] [<c00db35c>] (detach_ppd+0x28/0x44) from [<c00dce74>] =

(taskexit_event+0x5ec/0x884)
[  144.523724] [<c00dce74>] (taskexit_event+0x5ec/0x884) from =

[<c009fb14>] (ipipe_kevent_hook+0x24/0x2c)
[  144.533367] [<c009fb14>] (ipipe_kevent_hook+0x24/0x2c) from =

[<c009e324>] (__ipipe_notify_kevent+0x3c/0x64)
[  144.543457] [<c009e324>] (__ipipe_notify_kevent+0x3c/0x64) from =

[<c004193c>] (do_exit+0x348/0x88c)
[  144.552819] [<c004193c>] (do_exit+0x348/0x88c) from [<c0041f30>] =

(do_group_exit+0x84/0xc0)
[  144.561465] [<c0041f30>] (do_group_exit+0x84/0xc0) from [<c004e938>] =

(get_signal_to_deliver+0x49c/0x508)
[  144.571375] [<c004e938>] (get_signal_to_deliver+0x49c/0x508) from =

[<c0010a7c>] (do_signal+0x90/0x478)
[  144.581018] [<c0010a7c>] (do_signal+0x90/0x478) from [<c0011350>] =

(do_work_pending+0x5c/0xa4)
[  144.589966] [<c0011350>] (do_work_pending+0x5c/0xa4) from =

[<c000dba4>] (work_pending+0xc/0x20)
[  144.598961] drm_kms_helper: panic occurred, switching back to text =

console

In summary:

   1. "USED main heap" under /proc/xenomai/heap does not return to =

previous level after terminating an application which uses q_vcreate - =

it is increased.
   2. After (1) has occurred, calling q_vcreate in a separate invocation =

of the application returns -17 (File Exists) - suggesting the queue is =

still in existence. This happens with plenty of "main heap" left. I =

would expect all resources associated with the queue to be released on =

termination. "USED main heap" is increased after termination for this =

scenario as well, which certainly seems wrong.


[  677.528359] Xenomai: pSOS: cleaning up q "q002" (ret=3D58).
whenever exiting without calling q_vdelete after q_vcreate.

When using q_create, on exit I get:
[ 445.419293] Xenomai: pSOS: cleaning up q "q001" (ret=3D0).
when I do not call q_delete.

I've included a simple test case which demonstrates the problem.

Any assistance with this would be appreciated.


Marcel.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: qvcreatetest.tar.gz
Type: application/x-gzip
Size: 625 bytes
Desc: not available
URL: <http://www.xenomai.org/pipermail/xenomai/attachments/20140225/8032fb7=
4/attachment.bin>
