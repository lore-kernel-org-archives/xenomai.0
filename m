Message-ID: <44AECD18.4070809@domain.hid>
Date: Fri, 07 Jul 2006 23:07:36 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig33B5FE005CC6951745F40F45"
Sender: jan.kiszka@domain.hid
Subject: [Xenomai-core] [PATCH] add ipipe-domain mode to irqbench
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: xenomai-core <xenomai@xenomai.org>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig33B5FE005CC6951745F40F45
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Another test mode for irqbench: this patch allows to run the irq loopback=
 ahead of
Xenomai in its own domain. Relies on latest ipipe patch which made non-he=
ading irq
handlers interruptible, requires CONFIG_XENO_OPT_PIPELINE_HEAD=3Dn (but w=
ill simply fail
on mode request if not).

I tried to pick up the rthal versions of all ipipe-related stuff, please =
remark
potential misuse.

Jan

---
 doc/txt/irqbench.txt             |   36 ++++++++++++++++++++++++++-
 include/rtdm/rttesting.h         |    1=20
 ksrc/drivers/testing/irqbench.c  |   51 ++++++++++++++++++++++++++++++++=
+++++--
 src/testsuite/irqbench/irqloop.c |    6 +++-
 4 files changed, 89 insertions(+), 5 deletions(-)

Index: xenomai/include/rtdm/rttesting.h
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- xenomai.orig/include/rtdm/rttesting.h
+++ xenomai/include/rtdm/rttesting.h
@@ -97,6 +97,7 @@ typedef struct rttst_tmbench_config {
 #define RTTST_IRQBENCH_USER_TASK    0
 #define RTTST_IRQBENCH_KERNEL_TASK  1
 #define RTTST_IRQBENCH_HANDLER      2
+#define RTTST_IRQBENCH_HARD_IRQ     3
=20
 #define RTTST_IRQBENCH_SERPORT      0
 #define RTTST_IRQBENCH_PARPORT      1
Index: xenomai/ksrc/drivers/testing/irqbench.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- xenomai.orig/ksrc/drivers/testing/irqbench.c
+++ xenomai/ksrc/drivers/testing/irqbench.c
@@ -56,11 +56,13 @@ struct rt_irqbench_context {
     int                         mode;
     int                         port_type;
     unsigned long               port_ioaddr;
+    unsigned int                port_irq;
     unsigned int                toggle;
     struct rttst_irqbench_stats stats;
     rtdm_irq_t                  irq_handle;
     rtdm_event_t                irq_event;
     rtdm_task_t                 irq_task;
+    rthal_pipeline_stage_t      domain;
     struct semaphore            nrt_mutex;
 };
=20
@@ -156,6 +158,25 @@ static int rt_irqbench_direct_irq(rtdm_i
 }
=20
=20
+static void rt_irqbench_domain_irq(unsigned irq, void *arg)
+{
+    struct rt_irqbench_context *ctx =3D (struct rt_irqbench_context *)ar=
g;
+
+
+    if (rt_irqbench_check_irq(ctx))
+        rt_irqbench_hwreply(ctx);
+
+    rthal_irq_end(ctx->port_irq);
+}
+
+
+static inline void do_rt_irqbench_domain_entry(void)
+{
+}
+
+RTHAL_DECLARE_DOMAIN(rt_irqbench_domain_entry);
+
+
 static int rt_irqbench_stop(struct rt_irqbench_context *ctx)
 {
     if (ctx->mode < 0)
@@ -172,7 +193,12 @@ static int rt_irqbench_stop(struct rt_ir
             break;
     }
=20
-    rtdm_irq_free(&ctx->irq_handle);
+    if (ctx->mode =3D=3D RTTST_IRQBENCH_HARD_IRQ) {
+        rthal_virtualize_irq(&ctx->domain, ctx->port_irq, NULL, NULL, NU=
LL,
+                             IPIPE_PASS_MASK);
+        rthal_unregister_domain(&ctx->domain);
+    } else
+        rtdm_irq_free(&ctx->irq_handle);
=20
     if (ctx->mode =3D=3D RTTST_IRQBENCH_KERNEL_TASK)
         rtdm_task_destroy(&ctx->irq_task);
@@ -304,6 +330,24 @@ static int rt_irqbench_ioctl_nrt(struct=20
                                            "irqbench", ctx);
                     break;
=20
+                case RTTST_IRQBENCH_HARD_IRQ:
+                    ret =3D rthal_register_domain(&ctx->domain, "irqbenc=
h",
+                                                0x49525142,
+                                                IPIPE_HEAD_PRIORITY,
+                                                rt_irqbench_domain_entry=
);
+                    if (ret < 0)
+                        goto unlock_start_out;
+
+                    ctx->port_irq =3D config->port_irq;
+                    ret =3D rthal_virtualize_irq(&ctx->domain, config->p=
ort_irq,
+                                               rt_irqbench_domain_irq, c=
tx,
+                                               NULL, IPIPE_HANDLE_MASK |=

+                                               IPIPE_WIRED_MASK |
+                                               IPIPE_EXCLUSIVE_MASK);
+                    if (ret < 0)
+                        rthal_unregister_domain(&ctx->domain);
+                    break;
+
                 default:
                     ret =3D -EINVAL;
                     break;
@@ -315,7 +359,10 @@ static int rt_irqbench_ioctl_nrt(struct=20
=20
             memset(&ctx->stats, 0, sizeof(ctx->stats));
=20
-            rtdm_irq_enable(&ctx->irq_handle);
+            if (ctx->mode =3D=3D RTTST_IRQBENCH_HARD_IRQ)
+                rthal_irq_enable(ctx->port_irq);
+            else
+                rtdm_irq_enable(&ctx->irq_handle);
=20
             /* Arm IRQ */
             switch (ctx->port_type) {
Index: xenomai/src/testsuite/irqbench/irqloop.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- xenomai.orig/src/testsuite/irqbench/irqloop.c
+++ xenomai/src/testsuite/irqbench/irqloop.c
@@ -54,7 +54,8 @@ void sighand(int sig)
 int main(int argc, char *argv[])
 {
     const char *mode_name[] =3D
-        { "user-space task", "kernel-space task", "IRQ handler" };
+        { "user-space task", "kernel-space task",
+          "IRQ handler", "hard-IRQ handler" };
     const char *port_type_name[] =3D { "serial", "parallel" };
     char devname[RTDM_MAX_DEVNAME_LEN];
     int benchdev_no =3D 0;
@@ -102,7 +103,8 @@ int main(int argc, char *argv[])
             default:
                 fprintf(stderr, "usage: irqloop [options]\n"
                         "  [-D <testing_device_no>] # number of testing =
device, default=3D0\n"
-                        "  [-t <test_mode>]         # 0=3Duser task (def=
ault), 1=3Dkernel task, 2=3DIRQ\n"
+                        "  [-t <test_mode>]         # 0=3Duser task (def=
ault), 1=3Dkernel task,\n"
+                        "                           # 2=3DIRQ handler, 3=
=3Dhard-IRQ handler\n"
                         "  [-P <priority>]          # task priority (tes=
t mode 0 and 1 only)\n"
                         "  [-o <port_type>]         # 0=3Dserial (defaul=
t), 1=3Dparallel\n"
                         "  [-a <port_io_address>]   # default=3D0x3f8\n"=

Index: xenomai/doc/txt/irqbench.txt
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- xenomai.orig/doc/txt/irqbench.txt
+++ xenomai/doc/txt/irqbench.txt
@@ -1,6 +1,8 @@
 IRQ Latency Benchmark
 ---------------------
=20
+1. Overview
+
 This latency benchmark for external interrupts consists of three parts:
=20
 1. xeno_irqbench (ksrc/drivers/testing)
@@ -19,6 +21,9 @@ This latency benchmark for external inte
=20
         <gcc-x86-compiler> irqbench.c -o irqbench -O2
=20
+
+2. Hardware Setup
+
 To link both test and log system, a null-modem cable between 8250-compat=
ible
 two RS232 ports is required. The infrastructure for parallel port cross-=
over
 is prepared as well, but yet untested and incomplete. The null-modem cab=
le
@@ -38,6 +43,36 @@ must provide at least the following link
 Test and log system can be started in arbitrary order, they will wait on=

 each other.
=20
+
+3. Test Scenarios
+
+The xeno_irqbench driver supports four different IRQ handling scenarios,=

+selectable via "-t <test_mode>" on irqloop start-up:
+
+Mode 0 - Installs an IRQ handler that wakes up a user-space task. This t=
ask
+         is provided by irqloop. Once it is woken up, it will issue an I=
OCTL
+         to xeno_irqbench in order to generate the reply. This scenario =
is
+         typical for kernel-based device drivers.
+
+Mode 1 - Same as mode 0, except that the task resides inside the kernel =
and is
+         provided by xeno_irqbench itself. A typical scenario for kernel=
-based
+         RT-applications or drivers that handle IRQ requests inside a ke=
rnel
+         task.
+
+Mode 2 - Installs an IRQ handler that directly replies to the event. Thi=
s
+         scenario measures the reactivity of driver IRQ handlers when ha=
ndling
+         events immediately or taking timestamps.
+
+Mode 3 - In this mode, an additional I-pipe domain is registered on top =
of
+         Xenomai. The IRQ handler for immediate reply is then assigned t=
o the
+         new domain. By pushing the handling above Xenomai, the IRQ repl=
y
+         latency can widely be decoupled from RT-application-related del=
ays.
+         The drawback is that no direct interaction with the Xenomai sch=
eduler
+         is possible from the higher domain.
+
+
+4. Measuring
+
 The log system runs each single IRQ measurement with local IRQs disabled=
=2E It
 will wait up to 100 times the current period on the test system's reply =
(after
 initial successful synchronisation, which happens with IRQs enabled). No=
te that
@@ -48,4 +83,3 @@ new IRQ event before the reply on the pr
 Thus the specified test period may be dynamically expended in case of
 overload. But maximum a latency close or above the period will clearly
 indicate this.
-




--------------enig33B5FE005CC6951745F40F45
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)
Comment: Using GnuPG with SUSE - http://enigmail.mozdev.org

iD8DBQFErs0YniDOoMHTA+kRAn3fAJ935L/aHLxg1GxnNrYDAICTO4eIJgCfetoN
nHXjOtCKa9W0YbWn7K2b9DI=
=MBUo
-----END PGP SIGNATURE-----

--------------enig33B5FE005CC6951745F40F45--

