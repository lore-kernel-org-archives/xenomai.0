Message-ID: <4B59E4FB.5070003@domain.hid>
Date: Fri, 22 Jan 2010 18:48:43 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <4B59D952.30202@domain.hid>
	<1264181859.2350.152.camel@domain.hid>
	<4B59E3B9.6060303@domain.hid>
In-Reply-To: <4B59E3B9.6060303@domain.hid>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-core] Domain switch during page fault handling
List-Id: Xenomai life and development <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Philippe Gerum <rpm@xenomai.org>
Cc: "Mauerer, Wolfgang" <wolfgang.mauerer@domain.hid>, xenomai-core <xenomai@xenomai.org>

Jan Kiszka wrote:
> Philippe Gerum wrote:
>> On Fri, 2010-01-22 at 17:58 +0100, Jan Kiszka wrote: 
>>> Hi guys,
>>>
>>> we are currently trying to catch an ugly Linux pipeline state corruption
>>> on x86-64.
>>>
>>> Conceptual question: If a Xenomai task causes a fault, we enter
>>> ipipe_trap_notify over the primary domain and leave it over the root
>>> domain, right? Now, if the root domain happened to be stalled when the
>>> exception happened, where should it normally be unstalled again,
>>> *for_that_task*? Our problem is that we generate a code path where this
>>> does not happen.
>> xnhadow_relax -> ipipe_reenter_root -> finish_task_switch ->
>> finish_lock_switch -> unstall
>>
>> Since xnshadow_relax is called on behalf the event dispatcher, we should
>> expect it to return with the root domain unstalled after a domain
>> downgrade, from primary to root.
> 
> That all happens as expected. But then __ipipe_handle_exception - as it
> last duty - ruins our day by replaying an unrelated root state.
> 

To illustrate what goes wrong (maybe it already fixes the issue, but it
may have side effects and is surely not clean):

diff --git a/arch/x86/kernel/ipipe.c b/arch/x86/kernel/ipipe.c
index 4442d96..b6a3720 100644
--- a/arch/x86/kernel/ipipe.c
+++ b/arch/x86/kernel/ipipe.c
@@ -702,11 +702,14 @@ static int __ipipe_xlate_signo[] = {
 
 int __ipipe_handle_exception(struct pt_regs *regs, long error_code, int vector)
 {
-	unsigned long flags;
+	struct ipipe_domain *entry_domain = ipipe_current_domain;
+	unsigned long flags, entry_dom_flags;
 
 	/* Pick up the root domain state of the interrupted context. */
 	local_save_flags(flags);
 
+	entry_dom_flags = ipipe_test_pipeline() ? 0 : X86_EFLAGS_IF;
+
 	if (ipipe_root_domain_p) {
 		/*
 		 * Replicate hw interrupt state into the virtual mask before
@@ -729,6 +732,9 @@ int __ipipe_handle_exception(struct pt_regs *regs, long error_code, int vector)
 		return 1;
 	}
 
+	if (entry_domain != ipipe_current_domain)
+		flags = entry_dom_flags;
+
 	/*
 	 * 32-bit: In case we migrated to root domain inside the event
 	 * handler, restore the original IF from exception entry as the


Jan

-- 
Siemens AG, Corporate Technology, CT T DE IT 1
Corporate Competence Center Embedded Linux

