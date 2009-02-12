Message-ID: <499491E1.4040503@domain.hid>
Date: Thu, 12 Feb 2009 22:17:21 +0100
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
References: <6a782b880902120633k48de76a0y2fa005bc852d74fb@domain.hid>
	<499465D0.7000800@domain.hid>
In-Reply-To: <499465D0.7000800@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Xenomai-help] rt_task_add_hook() doesnt work
Reply-To: rpm@xenomai.org
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Thiago Lima <thiagolims@domain.hid>
Cc: xenomai@xenomai.org

Philippe Gerum wrote:
> Thiago Lima wrote:
>> Hi all !
>>
>> I need to do some things when a new rt task starts. So that, i need to
>> use the 'rt_task_add_hook()', defined in xenomai task management servi=
ce.
>> So, i have created a linux kernel module in which i call this service =
in
>> init_module() function. After that, initialize the module and starts a
>> RT Task.
>>
>> But, the hook function isnt called. Does anybody have already faced th=
is
>> problem ?
>>
>=20
> Start hooks are not fired for userland tasks.
>

And there is no valid reason for this. This patch should plug the hole:

--- ksrc/nucleus/pod.c	(revision 4617)
+++ ksrc/nucleus/pod.c	(working copy)
@@ -844,8 +844,8 @@
 	if (xnthread_test_state(thread, XNSHADOW)) {
 		xnlock_put_irqrestore(&nklock, s);
 		xnshadow_start(thread);
-		xnpod_schedule();
-		return 0;
+		xnlock_get_irqsave(&nklock, s);
+		goto callout;
 	}
 #endif /* CONFIG_XENO_OPT_PERVASIVE */

@@ -861,7 +861,8 @@
 		nkpod->schedhook(thread, XNREADY);
 #endif /* __XENO_SIM__ */

-	if (!emptyq_p(&nkpod->tstartq) && !xnthread_test_state(thread, XNROOT))=
 {
+ callout:
+	if (!emptyq_p(&nkpod->tstartq)) {
 		trace_mark(xn_nucleus_thread_callout,
 			   "thread %p thread_name %s hook %s",
 			   thread, xnthread_name(thread), "START");

>> --------- kernel module simple code -----
>>
>> void hook(void *cookie) {
>>    printk(KERN_INFO "hook().\n");
>> }
>>
>> int init_module (void) {
>>     rt_task_add_hook(T_HOOK_START, &hook);
>>     return 0;
>> }
>>
>> --------- kernel module simple code -----
>>
>>
>> --=20
>> Thiago Lima Silva
>> Graduando - Ci=EAncia da Computa=E7=E3o UFBA
>> Registered Linux user #466887
>>
>>
>> ----------------------------------------------------------------------=
--
>>
>> _______________________________________________
>> Xenomai-help mailing list
>> Xenomai-help@domain.hid
>> https://mail.gna.org/listinfo/xenomai-help
>=20
>=20


--=20
Philippe.

