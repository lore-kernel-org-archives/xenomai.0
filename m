MIME-Version: 1.0
From: Andreas Glatz <andi.glatz@gmail.com>
Date: Thu, 28 Dec 2017 16:54:03 +0000
Message-ID: <CAKJ14NfoOEbab7we0CDUOsyisEg7ET4oadgvheQOo3PjSGXP-w@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: [Xenomai] WARN_ON() during module refcnt decrease after applying
 4.1.y x86 ipipe patch
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

Hi

I applied the most recent 4.1.y x86 ipipe patch to the following kernel:

<snip>
vrc:~# cat /proc/version
Linux version 4.1.42-yocto-standard (andreas@x) (gcc version 5.2.0
(GCC) ) #2 SMP PREEMPT Thu Dec 28 15:16:20 GMT 2017
vrc:~# cat /proc/ipipe/version
9
</snip>

It boots, however, I get WARN_ON() backtraces as follows:

<snip>
[    4.586165] WARNING: CPU: 0 PID: 93 at
/home/andreas/work/linux_buildsystem/yocto/tmp/work-shared/vrc/kernel-source/kernel/module.c:970
module_put+0x141/0x1a0()
[    4.586170] Modules linked in: video snd_timer
[    4.586175] CPU: 0 PID: 93 Comm: udevd Tainted: G        W
4.1.42-yocto-standard #2
[    4.586176] Hardware name: Default string Default string/conga-TA5,
BIOS 5.12 07/21/2017
[    4.586183]  0000000000000200 0000000081fd37f3 ffff88003611bc68
ffffffff8198cfac
[    4.586187]  0000000000000000 ffffffff81cb6ab0 ffff88003611bca8
ffffffff8107dbaa
[    4.586192]  ffff88003611bcd8 ffffffffa0004460 ffffffffa0004460
0000000000021d60
[    4.586193] Call Trace:
[    4.586201]  [<ffffffff8198cfac>] dump_stack+0x96/0xbd
[    4.586206]  [<ffffffff8107dbaa>] warn_slowpath_common+0x8a/0xc0
[    4.586210]  [<ffffffff8107dcda>] warn_slowpath_null+0x1a/0x20
[    4.586213]  [<ffffffff810fee31>] module_put+0x141/0x1a0
[    4.586216]  [<ffffffff8198b3a1>] do_init_module+0xd8/0x1b2
[    4.586220]  [<ffffffff811031f7>] load_module+0x1e67/0x24c0
[    4.586223]  [<ffffffff810ffed0>] ? symbol_put_addr+0x70/0x70
[    4.586227]  [<ffffffff811ce770>] ? kernel_read+0x50/0x80
[    4.586232]  [<ffffffff81103aae>] SYSC_finit_module+0xbe/0xf0
[    4.586236]  [<ffffffff81103afe>] SyS_finit_module+0xe/0x10
[    4.586240]  [<ffffffff8199477f>] system_call_fastpath+0x12/0x17
[    4.586243] ---[ end trace e18c3e1481c985d2 ]---
</snip>

When I look at the ipipe patch only little has changed in kernel/module.c:

<snip>
diff --git a/kernel/module.c b/kernel/module.c
index 9da0824..03c2b6e 100644
--- a/kernel/module.c
+++ b/kernel/module.c
@@ -946,7 +946,7 @@ bool try_module_get(struct module *module)
        bool ret = true;

        if (module) {
-               preempt_disable();
+               unsigned long flags = hard_preempt_disable();
                /* Note: here, we can fail to get a reference */
                if (likely(module_is_live(module) &&
                           atomic_inc_not_zero(&module->refcnt) != 0))
@@ -954,7 +954,7 @@ bool try_module_get(struct module *module)
                else
                        ret = false;

-               preempt_enable();
+               hard_preempt_enable(flags);
        }
        return ret;
 }
@@ -965,11 +965,11 @@ void module_put(struct module *module)
        int ret;

        if (module) {
-               preempt_disable();
+               unsigned long flags = hard_preempt_disable();
                ret = atomic_dec_if_positive(&module->refcnt);
                WARN_ON(ret < 0);       /* Failed to put refcount */
                trace_module_put(module, _RET_IP_);
-               preempt_enable();
+               hard_preempt_enable(flags);
        }
 }
 EXPORT_SYMBOL(module_put);
</snip>

I haven't reconfigured the kernel yet, so it's configured as it was
w/o the ipipe patch.

Does anyone have a clue what causes the WARN_ON()?

A.

