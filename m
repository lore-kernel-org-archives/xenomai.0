Subject: Re: [Xenomai-help] Standard linux assignment of processes to CPUs
	depends on Xenomai Config
From: Philippe Gerum <rpm@xenomai.org>
In-Reply-To: <b647ffbd0702190301h468a2bbemafff7b9d592e7e@domain.hid>
References: <24461688.1170430564542.JavaMail.ngmail@domain.hid>
	<45D97B38.6060202@domain.hid>
	<b647ffbd0702190301h468a2bbemafff7b9d592e7e@domain.hid>
Content-Type: text/plain
Date: Mon, 19 Feb 2007 12:23:21 +0100
Message-Id: <1171884201.9958.4.camel@domain.hid>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: Philippe Gerum <philippe.gerum@domain.hid>
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
To: Dmitry Adamushko <dmitry.adamushko@domain.hid>
Cc: Xenomai help <xenomai@xenomai.org>, Jan Kiszka <jan.kiszka@domain.hid>

On Mon, 2007-02-19 at 12:01 +0100, Dmitry Adamushko wrote:
> Hi,
> 
> I suppose, that's what happens.
> 
> __xeno_sys_init() (./ksrc/nucleus/module.c) which is module_init() and
> when compiled in -> initcall()
> 
> calls xnarch_init() (./include/asm-i386/bits/init.h)
> 
> This one amongst other things does
> 
> ...
> #ifdef CONFIG_SMP
>         /* Make sure the init sequence is kept on the same CPU when
>            running as a module. */
>         set_cpus_allowed(current, cpumask_of_cpu(0));
> #endif /* CONFIG_SMP */
> 
> In fact, "running as a module" seems to be a bit
> misleading here.  Then another macro should be used in addition,
> MODULE or how it's called.
> 
> Now guess who is a "current" here? It's "init" (pid 0).
> 
> init() -> do_basic_setup() -> do_initcalls() -> ... ->
> __xeno_sys_init() -> xnarch_init()
> 
> "init" is a first process to run and all the rest will inherit its
> "cpus_allowed" field.
> 
> That's it.
> 

Eh, that's what I call a nice one Dmitry. This is the perfect example of
legacy code stabbing us in the back. We should indeed definitely check
for MODULE && SMP.

-- 
Philippe.



