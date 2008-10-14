Message-ID: <48F4ACF2.3000408@domain.hid>
Date: Tue, 14 Oct 2008 16:30:10 +0200
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
References: <48F3C3E4.4020801@domain.hid>
	<48F45847.3030704@domain.hid>	<48F461A6.6010600@domain.hid>
	<48F4634B.3030002@domain.hid>	<48F465DD.6020505@domain.hid>
	<48F46954.6050704@domain.hid> <48F473A2.1050104@domain.hid>
	<48F48E2E.2050004@domain.hid> <48F49540.3060507@domain.hid>
	<48F49637.2030000@domain.hid> <48F497B2.4080404@domain.hid>
	<48F4987F.1060901@domain.hid> <48F499EF.9010205@domain.hid>
	<48F49DCE.2070308@domain.hid> <48F4A234.9030309@domain.hid>
In-Reply-To: <48F4A234.9030309@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-core] __thread instead of pthread_get/setspecific
Reply-To: rpm@xenomai.org
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Jan Kiszka <jan.kiszka@domain.hid>
Cc: xenomai-core <xenomai@xenomai.org>

Jan Kiszka wrote:
> Gilles Chanteperdrix wrote:
>> Jan Kiszka wrote:
>>> Ack. There are rt_printf (rtdk) and the task-self services of vxworks,
>>> vrtx and native skins. So if I get an OK for the proposal, I'll convert
>>> the rest, too.
>> And I really do not understand how the keys can be chosen at
>> compilation-time, especially in the situation where multiple libraries
>> allocate __thread objects separately: how does the compiler know which
>> key to give for each library ?
> 
> The keys are known at linking time when a) their context is module-local
> and b) their TLS storage can be appended to main's TLS area (and that
> can only happen during initial linking, of course).
> 
> 
> BTW, another advantage of TLS over getspecific /wrt task-self is that it
> overcomes its laziness: its now cheap and easy to set self in the thread
> trampoline.
> 
> Philippe, could it be that vrtx's sc_tinquiry implementation is broken?
> I only find the corresponding pthread_setspecific in the lib
> constructor. That pattern totally disagrees with native and vxworks.
>

Oh my... I killed this dead O/S once again!

--- src/skins/vrtx/task.c	(revision 4211)
+++ src/skins/vrtx/task.c	(working copy)
@@ -80,6 +80,7 @@
 	struct sched_param param;
 	int policy;
 	long err;
+	TCB *tcb;

 	/* Backup the arg struct, it might vanish after completion. */
 	memcpy(&_iargs, iargs, sizeof(_iargs));
@@ -94,6 +95,15 @@
 	/* vrtx_task_delete requires asynchronous cancellation */
 	pthread_setcanceltype(PTHREAD_CANCEL_ASYNCHRONOUS, NULL);

+	tcb = (TCB *) malloc(sizeof(*tcb));
+	if (tcb == NULL) {
+		fprintf(stderr, "Xenomai: failed to allocate local TCB?!\n");
+		err = -ENOMEM;
+		goto fail;
+	}
+
+	pthread_setspecific(__vrtx_tskey, tcb);
+
 	old_sigharden_handler = signal(SIGHARDEN, &vrtx_task_sigharden);

 	bulk.a1 = (u_long)iargs->tid;
@@ -116,9 +126,7 @@

 	if (!err)
 		_iargs.entry(_iargs.param);
-
-      fail:
-
+fail:
 	pthread_exit((void *)err);
 }

Index: src/skins/vrtx/init.c
===================================================================
--- src/skins/vrtx/init.c	(revision 4211)
+++ src/skins/vrtx/init.c	(working copy)
@@ -39,8 +39,6 @@
 static __attribute__ ((constructor))
 void __init_xeno_interface(void)
 {
-	TCB *tcb;
-
 	__vrtx_muxid =
 	    xeno_bind_skin(VRTX_SKIN_MAGIC, "vrtx", "xeno_vrtx");
 	__vrtx_muxid = __xn_mux_shifted_id(__vrtx_muxid);
@@ -51,13 +49,4 @@
 		fprintf(stderr, "Xenomai: failed to allocate new TSD key?!\n");
 		exit(1);
 	}
-
-	tcb = (TCB *) malloc(sizeof(*tcb));
-
-	if (!tcb) {
-		fprintf(stderr, "Xenomai: failed to allocate local TCB?!\n");
-		exit(1);
-	}
-
-	pthread_setspecific(__vrtx_tskey, tcb);
 }


> Jan
> 


-- 
Philippe.


