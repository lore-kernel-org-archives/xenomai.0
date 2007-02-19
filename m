Message-ID: <b647ffbd0702190301h468a2bbemafff7b9d592e7e@domain.hid>
Date: Mon, 19 Feb 2007 12:01:17 +0100
From: "Dmitry Adamushko" <dmitry.adamushko@domain.hid>
Subject: Re: [Xenomai-help] Standard linux assignment of processes to CPUs
	depends on Xenomai Config
In-Reply-To: <45D97B38.6060202@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <24461688.1170430564542.JavaMail.ngmail@domain.hid>
	<45D97B38.6060202@domain.hid>
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Jan Kiszka <jan.kiszka@domain.hid>
Cc: Xenomai help <xenomai@xenomai.org>

Hi,

I suppose, that's what happens.

__xeno_sys_init() (./ksrc/nucleus/module.c) which is module_init() and
when compiled in -> initcall()

calls xnarch_init() (./include/asm-i386/bits/init.h)

This one amongst other things does

...
#ifdef CONFIG_SMP
        /* Make sure the init sequence is kept on the same CPU when
           running as a module. */
        set_cpus_allowed(current, cpumask_of_cpu(0));
#endif /* CONFIG_SMP */

In fact, "running as a module" seems to be a bit
misleading here.  Then another macro should be used in addition,
MODULE or how it's called.

Now guess who is a "current" here? It's "init" (pid 0).

init() -> do_basic_setup() -> do_initcalls() -> ... ->
__xeno_sys_init() -> xnarch_init()

"init" is a first process to run and all the rest will inherit its
"cpus_allowed" field.

That's it.

-- 
Best regards,
Dmitry Adamushko

