From: alex_luca@163.com
Subject: [PATCH] include/linux:add missing declations to some .h files
Date: Tue,  7 Jul 2020 22:58:32 +0800
Message-Id: <20200707145832.28715-1-alex_luca@163.com>
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: jan.kiszka@siemens.com
Cc: xenomai@xenomai.org, "Carver.lio" <liu.hailong6@zte.com.cn>

From: "Carver.lio" <liu.hailong6@zte.com.cn>

On branch ipipe-x86-4.14.y *ipipe.h*  missing declaration of
ipipe_root_nr_syscalls* and *ipipe_tickdev.h* missing declaration
of *ipipe_host_timer_cleanup*  when CONFIG_IPIPE=N.
---
 include/linux/ipipe.h         | 4 ++++
 include/linux/ipipe_tickdev.h | 2 ++
 2 files changed, 6 insertions(+)

diff --git a/include/linux/ipipe.h b/include/linux/ipipe.h
index b8a80eea..963709a8 100644
--- a/include/linux/ipipe.h
+++ b/include/linux/ipipe.h
@@ -718,4 +718,8 @@ static inline void __ipipe_pin_mapping_globally(unsigned long start,
 { }
 #endif

+#ifndef ipipe_root_nr_syscalls
+#define ipipe_root_nr_syscalls(ti)	NR_syscalls
+#endif
+
 #endif	/* !__LINUX_IPIPE_H */
diff --git a/include/linux/ipipe_tickdev.h b/include/linux/ipipe_tickdev.h
index ff8213f5..b52a9141 100644
--- a/include/linux/ipipe_tickdev.h
+++ b/include/linux/ipipe_tickdev.h
@@ -153,6 +153,8 @@ void __ipipe_timer_refresh_freq(unsigned int hrclock_freq);

 #define ipipe_host_timer_register(clkevt) do { } while (0)

+#define ipipe_host_timer_cleanup(clkevt) do { } while (0)
+
 #endif /* !CONFIG_IPIPE */

 #ifdef CONFIG_IPIPE_HAVE_HOSTRT
--
2.17.1



