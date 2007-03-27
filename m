Message-ID: <e45fe62b0703270643x7e65ff92w90d00d6e7cbd1cd5@domain.hid>
Date: Tue, 27 Mar 2007 19:13:13 +0530
From: "Preetam Joshi" <j.preetam@domain.hid>
Subject: Re: [Xenomai-help] HAL
In-Reply-To: <46090FCF.9090803@domain.hid>
MIME-Version: 1.0
Content-Type: multipart/alternative; 
	boundary="----=_Part_8510_30190671.1175002993600"
References: <e45fe62b0703270444l6eda9d67idfb7392772f02a42@domain.hid>
	<46090FCF.9090803@domain.hid>
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: xenomai-help <xenomai@xenomai.org>

------=_Part_8510_30190671.1175002993600
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

The reason i asked is because i wanted to use the native API but before that
when i am compiling the kernel i get the following errors

All errors in hal.c file basically

kernel/xenomai/arch/generic/hal.c: At top level:
kernel/xenomai/arch/generic/hal.c:73: parse error before `rthal_apc_lock'
kernel/xenomai/arch/generic/hal.c:73: warning: type defaults to `int' in
declaration of `rthal_apc_lock'
kernel/xenomai/arch/generic/hal.c:73: `RTHAL_SPIN_LOCK_UNLOCKED' undeclared
here (not in a function)
kernel/xenomai/arch/generic/hal.c:73: warning: data definition has no type
or storage class
kernel/xenomai/arch/generic/hal.c:81: parse error before
`rthal_trap_handler'
kernel/xenomai/arch/generic/hal.c:81: warning: type defaults to `int' in
declaration of `rthal_trap_handler'
kernel/xenomai/arch/generic/hal.c:81: warning: data definition has no type
or storage class
kernel/xenomai/arch/generic/hal.c: In function `rthal_critical_enter':
kernel/xenomai/arch/generic/hal.c:89: warning: implicit declaration of
function `rthal_grab_superlock'
kernel/xenomai/arch/generic/hal.c: In function `rthal_critical_exit':
kernel/xenomai/arch/generic/hal.c:102: warning: implicit declaration of
function `rthal_release_superlock'
kernel/xenomai/arch/generic/hal.c: At top level:
kernel/xenomai/arch/generic/hal.c:154: parse error before
`rthal_irq_handler_t'
kernel/xenomai/arch/generic/hal.c:156: warning: function declaration isn't a
prototype
kernel/xenomai/arch/generic/hal.c: In function `rthal_irq_request':
kernel/xenomai/arch/generic/hal.c:157: `handler' undeclared (first use in
this function)
kernel/xenomai/arch/generic/hal.c:157: (Each undeclared identifier is
reported only once
kernel/xenomai/arch/generic/hal.c:157: for each function it appears in.)
kernel/xenomai/arch/generic/hal.c:157: `irq' undeclared (first use in this
function)
kernel/xenomai/arch/generic/hal.c:160: warning: implicit declaration of
function `rthal_virtualize_irq'
kernel/xenomai/arch/generic/hal.c:163: `cookie' undeclared (first use in
this function)
kernel/xenomai/arch/generic/hal.c:164: `ackfn' undeclared (first use in this
function)
kernel/xenomai/arch/generic/hal.c: In function `rthal_irq_host_pend':
kernel/xenomai/arch/generic/hal.c:297: warning: implicit declaration of
function `rthal_propagate_irq'
kernel/xenomai/arch/generic/hal.c: At top level:
kernel/xenomai/arch/generic/hal.c:384: parse error before `rthal_trap_catch'
kernel/xenomai/arch/generic/hal.c:384: parse error before `handler'
kernel/xenomai/arch/generic/hal.c:385: warning: return-type defaults to
`int'
kernel/xenomai/arch/generic/hal.c:385: warning: function declaration isn't a
prototype
kernel/xenomai/arch/generic/hal.c: In function `rthal_trap_catch':
kernel/xenomai/arch/generic/hal.c:386: `rthal_trap_handler_t' undeclared
(first use in this function)
kernel/xenomai/arch/generic/hal.c:386: `handler' undeclared (first use in
this function)
kernel/xenomai/arch/generic/hal.c:387: warning: control reaches end of
non-void function
kernel/xenomai/arch/generic/hal.c: In function `rthal_apc_handler':
kernel/xenomai/arch/generic/hal.c:392: `rthal_declare_cpuid' undeclared
(first use in this function)
kernel/xenomai/arch/generic/hal.c:394: warning: implicit declaration of
function `rthal_load_cpuid'
kernel/xenomai/arch/generic/hal.c:396: warning: implicit declaration of
function `rthal_spin_lock'
kernel/xenomai/arch/generic/hal.c:406: `cpuid' undeclared (first use in this
function)
kernel/xenomai/arch/generic/hal.c:412: warning: implicit declaration of
function `rthal_spin_unlock'
kernel/xenomai/arch/generic/hal.c: In function `rthal_apc_alloc':
kernel/xenomai/arch/generic/hal.c:520: warning: implicit declaration of
function `rthal_spin_lock_irqsave'
kernel/xenomai/arch/generic/hal.c:531: warning: implicit declaration of
function `rthal_spin_unlock_irqrestore'
kernel/xenomai/arch/generic/hal.c:514: warning: `flags' might be used
uninitialized in this function
kernel/xenomai/arch/generic/hal.c: In function `rthal_apc_schedule':
kernel/xenomai/arch/generic/hal.c:597: `rthal_declare_cpuid' undeclared
(first use in this function)
kernel/xenomai/arch/generic/hal.c:598: parse error before `unsigned'
kernel/xenomai/arch/generic/hal.c:603: warning: implicit declaration of
function `rthal_local_irq_save'
kernel/xenomai/arch/generic/hal.c:603: `flags' undeclared (first use in this
function)
kernel/xenomai/arch/generic/hal.c:607: `cpuid' undeclared (first use in this
function)
kernel/xenomai/arch/generic/hal.c:608: warning: implicit declaration of
function `rthal_schedule_irq'
kernel/xenomai/arch/generic/hal.c:610: warning: implicit declaration of
function `rthal_local_irq_restore'
kernel/xenomai/arch/generic/hal.c: In function `rthal_proc_register':
kernel/xenomai/arch/generic/hal.c:764: warning: implicit declaration of
function `rthal_nmi_proc_register'
kernel/xenomai/arch/generic/hal.c: In function `rthal_proc_unregister':
kernel/xenomai/arch/generic/hal.c:771: warning: implicit declaration of
function `rthal_nmi_proc_unregister'
kernel/xenomai/arch/generic/hal.c: In function `rthal_init':
kernel/xenomai/arch/generic/hal.c:784: warning: implicit declaration of
function `rthal_arch_init'
kernel/xenomai/arch/generic/hal.c:791: invalid use of undefined type `struct
rthal_calibration_data'
kernel/xenomai/arch/generic/hal.c:792: invalid use of undefined type `struct
rthal_calibration_data'
kernel/xenomai/arch/generic/hal.c:796: warning: implicit declaration of
function `rthal_alloc_virq'
kernel/xenomai/arch/generic/hal.c:804: `rthal_current_domain' undeclared
(first use in this function)
kernel/xenomai/arch/generic/hal.c:830: warning: implicit declaration of
function `rthal_register_domain'
kernel/xenomai/arch/generic/hal.c:833: `rthal_domain_entry' undeclared
(first use in this function)
kernel/xenomai/arch/generic/hal.c:871: warning: implicit declaration of
function `rthal_free_virq'
kernel/xenomai/arch/generic/hal.c:874: warning: implicit declaration of
function `rthal_arch_cleanup'
kernel/xenomai/arch/generic/hal.c: In function `rthal_exit':
kernel/xenomai/arch/generic/hal.c:887: `rthal_current_domain' undeclared
(first use in this function)
kernel/xenomai/arch/generic/hal.c:901: warning: implicit declaration of
function `rthal_unregister_domain'
kernel/xenomai/arch/generic/hal.c: At top level:
kernel/xenomai/arch/generic/hal.c:79: storage size of `rthal_tunables' isn't
known

All these vasriables and functions are declared in header file hal.h and
that is being included in the file but no luck.



On 3/27/07, Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org> wrote:
>
> Preetam Joshi wrote:
> > Hi what i would like to know is whether xenomai native skins have any
> > relation to the HAL files provided in the same project?
>
> There is only one native skin. The HAL files are used for the
> implementation of Xenomai nucleus, the component which is used to
> implement all Xenomai skins. Why are you asking this ?
>
> --
>                                                  Gilles Chanteperdrix
>

------=_Part_8510_30190671.1175002993600
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

The reason i asked is because i wanted to use the native API but before that when i am compiling the kernel i get the following errors<br><br>All errors in hal.c file basically <br><br>kernel/xenomai/arch/generic/hal.c: At top level:
<br>kernel/xenomai/arch/generic/hal.c:73: parse error before `rthal_apc_lock&#39;<br>kernel/xenomai/arch/generic/hal.c:73: warning: type defaults to `int&#39; in declaration of `rthal_apc_lock&#39;<br>kernel/xenomai/arch/generic/hal.c:73: `RTHAL_SPIN_LOCK_UNLOCKED&#39; undeclared here (not in a function)
<br>kernel/xenomai/arch/generic/hal.c:73: warning: data definition has no type or storage class<br>kernel/xenomai/arch/generic/hal.c:81: parse error before `rthal_trap_handler&#39;<br>kernel/xenomai/arch/generic/hal.c:81: warning: type defaults to `int&#39; in declaration of `rthal_trap_handler&#39;
<br>kernel/xenomai/arch/generic/hal.c:81: warning: data definition has no type or storage class<br>kernel/xenomai/arch/generic/hal.c: In function `rthal_critical_enter&#39;:<br>kernel/xenomai/arch/generic/hal.c:89: warning: implicit declaration of function `rthal_grab_superlock&#39;
<br>kernel/xenomai/arch/generic/hal.c: In function `rthal_critical_exit&#39;:<br>kernel/xenomai/arch/generic/hal.c:102: warning: implicit declaration of function `rthal_release_superlock&#39;<br>kernel/xenomai/arch/generic/hal.c: At top level:
<br>kernel/xenomai/arch/generic/hal.c:154: parse error before `rthal_irq_handler_t&#39;<br>kernel/xenomai/arch/generic/hal.c:156: warning: function declaration isn&#39;t a prototype<br>kernel/xenomai/arch/generic/hal.c: In function `rthal_irq_request&#39;:
<br>kernel/xenomai/arch/generic/hal.c:157: `handler&#39; undeclared (first use in this function)<br>kernel/xenomai/arch/generic/hal.c:157: (Each undeclared identifier is reported only once<br>kernel/xenomai/arch/generic/hal.c:157: for each function it appears in.)
<br>kernel/xenomai/arch/generic/hal.c:157: `irq&#39; undeclared (first use in this function)<br>kernel/xenomai/arch/generic/hal.c:160: warning: implicit declaration of function `rthal_virtualize_irq&#39;<br>kernel/xenomai/arch/generic/hal.c:163: `cookie&#39; undeclared (first use in this function)
<br>kernel/xenomai/arch/generic/hal.c:164: `ackfn&#39; undeclared (first use in this function)<br>kernel/xenomai/arch/generic/hal.c: In function `rthal_irq_host_pend&#39;:<br>kernel/xenomai/arch/generic/hal.c:297: warning: implicit declaration of function `rthal_propagate_irq&#39;
<br>kernel/xenomai/arch/generic/hal.c: At top level:<br>kernel/xenomai/arch/generic/hal.c:384: parse error before `rthal_trap_catch&#39;<br>kernel/xenomai/arch/generic/hal.c:384: parse error before `handler&#39;<br>kernel/xenomai/arch/generic/hal.c:385: warning: return-type defaults to `int&#39;
<br>kernel/xenomai/arch/generic/hal.c:385: warning: function declaration isn&#39;t a prototype<br>kernel/xenomai/arch/generic/hal.c: In function `rthal_trap_catch&#39;:<br>kernel/xenomai/arch/generic/hal.c:386: `rthal_trap_handler_t&#39; undeclared (first use in this function)
<br>kernel/xenomai/arch/generic/hal.c:386: `handler&#39; undeclared (first use in this function)<br>kernel/xenomai/arch/generic/hal.c:387: warning: control reaches end of non-void function<br>kernel/xenomai/arch/generic/hal.c: In function `rthal_apc_handler&#39;:
<br>kernel/xenomai/arch/generic/hal.c:392: `rthal_declare_cpuid&#39; undeclared (first use in this function)<br>kernel/xenomai/arch/generic/hal.c:394: warning: implicit declaration of function `rthal_load_cpuid&#39;<br>kernel/xenomai/arch/generic/hal.c:396: warning: implicit declaration of function `rthal_spin_lock&#39;
<br>kernel/xenomai/arch/generic/hal.c:406: `cpuid&#39; undeclared (first use in this function)<br>kernel/xenomai/arch/generic/hal.c:412: warning: implicit declaration of function `rthal_spin_unlock&#39;<br>kernel/xenomai/arch/generic/hal.c: In function `rthal_apc_alloc&#39;:
<br>kernel/xenomai/arch/generic/hal.c:520: warning: implicit declaration of function `rthal_spin_lock_irqsave&#39;<br>kernel/xenomai/arch/generic/hal.c:531: warning: implicit declaration of function `rthal_spin_unlock_irqrestore&#39;
<br>kernel/xenomai/arch/generic/hal.c:514: warning: `flags&#39; might be used uninitialized in this function<br>kernel/xenomai/arch/generic/hal.c: In function `rthal_apc_schedule&#39;:<br>kernel/xenomai/arch/generic/hal.c:597: `rthal_declare_cpuid&#39; undeclared (first use in this function)
<br>kernel/xenomai/arch/generic/hal.c:598: parse error before `unsigned&#39;<br>kernel/xenomai/arch/generic/hal.c:603: warning: implicit declaration of function `rthal_local_irq_save&#39;<br>kernel/xenomai/arch/generic/hal.c:603: `flags&#39; undeclared (first use in this function)
<br>kernel/xenomai/arch/generic/hal.c:607: `cpuid&#39; undeclared (first use in this function)<br>kernel/xenomai/arch/generic/hal.c:608: warning: implicit declaration of function `rthal_schedule_irq&#39;<br>kernel/xenomai/arch/generic/hal.c:610: warning: implicit declaration of function `rthal_local_irq_restore&#39;
<br>kernel/xenomai/arch/generic/hal.c: In function `rthal_proc_register&#39;:<br>kernel/xenomai/arch/generic/hal.c:764: warning: implicit declaration of function `rthal_nmi_proc_register&#39;<br>kernel/xenomai/arch/generic/hal.c: In function `rthal_proc_unregister&#39;:
<br>kernel/xenomai/arch/generic/hal.c:771: warning: implicit declaration of function `rthal_nmi_proc_unregister&#39;<br>kernel/xenomai/arch/generic/hal.c: In function `rthal_init&#39;:<br>kernel/xenomai/arch/generic/hal.c:784: warning: implicit declaration of function `rthal_arch_init&#39;
<br>kernel/xenomai/arch/generic/hal.c:791: invalid use of undefined type `struct rthal_calibration_data&#39;<br>kernel/xenomai/arch/generic/hal.c:792: invalid use of undefined type `struct rthal_calibration_data&#39;<br>kernel/xenomai/arch/generic/hal.c:796: warning: implicit declaration of function `rthal_alloc_virq&#39;
<br>kernel/xenomai/arch/generic/hal.c:804: `rthal_current_domain&#39; undeclared (first use in this function)<br>kernel/xenomai/arch/generic/hal.c:830: warning: implicit declaration of function `rthal_register_domain&#39;
<br>kernel/xenomai/arch/generic/hal.c:833: `rthal_domain_entry&#39; undeclared (first use in this function)<br>kernel/xenomai/arch/generic/hal.c:871: warning: implicit declaration of function `rthal_free_virq&#39;<br>kernel/xenomai/arch/generic/hal.c:874: warning: implicit declaration of function `rthal_arch_cleanup&#39;
<br>kernel/xenomai/arch/generic/hal.c: In function `rthal_exit&#39;:<br>kernel/xenomai/arch/generic/hal.c:887: `rthal_current_domain&#39; undeclared (first use in this function)<br>kernel/xenomai/arch/generic/hal.c:901: warning: implicit declaration of function `rthal_unregister_domain&#39;
<br>kernel/xenomai/arch/generic/hal.c: At top level:<br>kernel/xenomai/arch/generic/hal.c:79: storage size of `rthal_tunables&#39; isn&#39;t known<br><br>All these vasriables and functions are declared in header file hal.h
 and that is being included in the file but no luck.<br><br><br><br><div><span class="gmail_quote">On 3/27/07, <b class="gmail_sendername">Gilles Chanteperdrix</b> &lt;<a href="mailto:gilles.chanteperdrix@xenomai.org">gilles.chanteperdrix@xenomai.org
</a>&gt; wrote:</span><blockquote class="gmail_quote" style="border-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;">Preetam Joshi wrote:<br>&gt; Hi what i would like to know is whether xenomai native skins have any
<br>&gt; relation to the HAL files provided in the same project?<br><br>There is only one native skin. The HAL files are used for the<br>implementation of Xenomai nucleus, the component which is used to<br>implement all Xenomai skins. Why are you asking this ?
<br><br>--<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Gilles Chanteperdrix<br></blockquote></div><br>

------=_Part_8510_30190671.1175002993600--

