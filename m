From: Philippe Gerum <rpm@xenomai.org>
In-Reply-To: <4B968DB5.5020302@domain.hid>
References: <4B968DB5.5020302@domain.hid>
Content-Type: text/plain; charset="UTF-8"
Date: Sat, 13 Mar 2010 16:59:29 +0100
Message-ID: <1268495969.27899.144.camel@domain.hid>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [Adeos-main] [pull request] Improve ftrace interaction
List-Id: General discussion about Adeos <adeos-main.gna.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
List-Archive: </public/adeos-main>
List-Post: <mailto:adeos-main@gna.org>
List-Help: <mailto:adeos-main-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
To: Jan Kiszka <jan.kiszka@domain.hid>
Cc: adeos-main <adeos-main@gna.org>

On Tue, 2010-03-09 at 19:04 +0100, Jan Kiszka wrote:
> The following changes since commit 7c90959b7e4eb5ef8a775ec17005c23f30daade1:
>   Philippe Gerum (1):
>         ipipe: introduce 3-level IRQ pending map
> 
> are available in the git repository at:
> 
>   git://git.kiszka.org/ipipe-2.6 queues/2.6.32-noarch
> 
> These patches address various possible configuration errors around
> ftrace that can cause hard crashes over I-pipe kernels. Moreover, one
> patch enables the safe use of ftrace's PID filtering that comes for free
> for the I-pipe tracer now.
> 
> The patches also apply on 2.6.33-noarch but were only tested on
> 2.6.32-x86.
> 
> 
> Jan Kiszka (5):
>       Use ipipe_safe_current in ftrace_pid_func
>       Prevent unsafe ftrace usage over I-pipe

This one looks pretty ugly. I would rather define a entry point for
registering ftrace hooks allowed to run in NMI context, and deny the
regular unsafe registration routine when the I-pipe tracer is enabled.
E.g.

diff --git a/kernel/trace/ftrace.c b/kernel/trace/ftrace.c
index 872f2fe..c4ac9d5 100644
--- a/kernel/trace/ftrace.c
+++ b/kernel/trace/ftrace.c
@@ -2992,7 +2992,7 @@ void ftrace_kill(void)
  *       with "notrace", otherwise it will go into a
  *       recursive loop.
  */
-int register_ftrace_function(struct ftrace_ops *ops)
+static int _register_ftrace_function(struct ftrace_ops *ops)
 {
 	int ret;
 
@@ -3008,6 +3008,23 @@ int register_ftrace_function(struct ftrace_ops *ops)
 	return ret;
 }
 
+#ifdef CONFIG_IPIPE_TRACE
+int register_ftrace_function(struct ftrace_ops *ops)
+{
+	return -EINVAL;
+}
+
+int register_ftrace_nmi_function(struct ftrace_ops *ops)
+{
+	return _register_ftrace_function(ops);
+}
+#else
+int register_ftrace_function(struct ftrace_ops *ops)
+{
+	return _register_ftrace_function(ops);
+}
+#endif
+

diff --git a/kernel/ipipe/tracer.c b/kernel/ipipe/tracer.c
index 0a37201..e408cab 100644
--- a/kernel/ipipe/tracer.c
+++ b/kernel/ipipe/tracer.c
@@ -1331,7 +1331,7 @@ static int __ipipe_wr_enable(struct file *file, const char __user *buffer,
 		if (!val)
 			unregister_ftrace_function(&ipipe_trace_ops);
 	} else if (val)
-		register_ftrace_function(&ipipe_trace_ops);
+		register_ftrace_nmi_function(&ipipe_trace_ops);
 
 	ipipe_trace_enable = val;
 
@@ -1405,7 +1405,7 @@ void __init __ipipe_init_tracer(void)
 #ifdef CONFIG_IPIPE_TRACE_ENABLE
 	ipipe_trace_enable = 1;
 #ifdef CONFIG_IPIPE_TRACE_MCOUNT
-	register_ftrace_function(&ipipe_trace_ops);
+	register_ftrace_nmi_function(&ipipe_trace_ops);
 #endif /* CONFIG_IPIPE_TRACE_MCOUNT */
 #endif /* CONFIG_IPIPE_TRACE_ENABLE */
 
>       Disable branch tracing/profiling under I-pipe
>       Do no kill ftrace on failing function test
>       Fix ipipe_safe_current definition for !CONFIG_IPIPE
> 
>  include/linux/ftrace.h        |    1 +
>  include/linux/ipipe.h         |    2 +-
>  kernel/ipipe/tracer.c         |    3 ++-
>  kernel/trace/Kconfig          |    2 ++
>  kernel/trace/ftrace.c         |    7 ++++++-
>  kernel/trace/trace_selftest.c |    2 ++
>  6 files changed, 14 insertions(+), 3 deletions(-)
> 
> _______________________________________________
> Adeos-main mailing list
> Adeos-main@domain.hid
> https://mail.gna.org/listinfo/adeos-main


-- 
Philippe.



