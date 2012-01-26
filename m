Message-ID: <4F2164D4.2050501@domain.hid>
Date: Thu, 26 Jan 2012 15:36:04 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <4F202C11.70908@domain.hid>
	<4F202F4E.6000708@domain.hid>	<4F203237.2010102@domain.hid>
	<4F203353.8030302@domain.hid>	<4F2035B6.6090105@domain.hid>
	<4F203771.6070708@domain.hid>	<4F203F7F.70509@domain.hid>
	<4F204466.1040603@domain.hid> <4F212CC4.6060001@domain.hid>
	<4F2136E0.4010200@domain.hid> <4F214D7A.5020901@domain.hid>
In-Reply-To: <4F214D7A.5020901@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-core] [PATCH] Add sigdebug unit test
List-Id: Xenomai life and development <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Philippe Gerum <rpm@xenomai.org>
Cc: xenomai@xenomai.org

On 2012-01-26 13:56, Jan Kiszka wrote:
>>> To trigger the enforced task termination without leaving any broken
>>> states behind, there is one option: rt_task_spin. Surprisingly for me,
>>> it actually spins in the kernel, thus triggers the second level if
>>> waiting long enough. I wonder, though, if that behavior shouldn't be
>>> improved, ie. the spinning loop be closed in user space - which would
>>> take away that option again.
>>>
>>> Thoughts?
>>>
>>
>> Tick-based timing is going to be the problem for determining the
>> spinning delay, unless we expose it in the vdso on a per-skin basis,
>> which won't be pretty.
> 
> I see. But we should possibly add some signal-pending || amok test to
> that kernel loop. That would also kill my test design, but it makes
> otherwise some sense I guess.

I'm thinking of a change like this:

diff --git a/ksrc/skins/native/syscall.c b/ksrc/skins/native/syscall.c
index acf0375..39204b4 100644
--- a/ksrc/skins/native/syscall.c
+++ b/ksrc/skins/native/syscall.c
@@ -1020,13 +1020,21 @@ static int __rt_timer_inquire(struct pt_regs *regs)
 
 static int __rt_timer_spin(struct pt_regs *regs)
 {
+	xnthread_t *thread = xnpod_current_thread();
+	struct task_struct *p = current;
+	RTIME etime;
 	RTIME ns;
 
 	if (__xn_safe_copy_from_user(&ns, (void __user *)__xn_reg_arg1(regs),
 				     sizeof(ns)))
 		return -EFAULT;
 
-	rt_timer_spin(ns);
+	etime = xnarch_get_cpu_tsc() + xnarch_ns_to_tsc(ns);
+	while ((SRTIME)(xnarch_get_cpu_tsc() - etime) < 0) {
+		if (signal_pending(p) || xnthread_amok_p(thread))
+			return -EINTR;
+		cpu_relax();
+	}
 
 	return 0;
 }

Regarding testability of the second watchdog state: We could add a
syscall to sigtest_module e.g which has the current rt_timer_spin
semantics.

Jan

-- 
Siemens AG, Corporate Technology, CT T DE IT 1
Corporate Competence Center Embedded Linux

