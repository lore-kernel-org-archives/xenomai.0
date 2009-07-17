From: Philippe Gerum <rpm@xenomai.org>
In-Reply-To: <1247837534.904271.19070.nullmailer@domain.hid>
References: <1247750127.306081.22356.nullmailer@domain.hid>
	<1247754601.4228.73.camel@domain.hid>
	<1247829470.829653.30773.nullmailer@domain.hid>
	<1247832340.4228.132.camel@domain.hid>
	<1247837534.904271.19070.nullmailer@domain.hid>
Content-Type: text/plain
Date: Fri, 17 Jul 2009 15:52:13 +0200
Message-Id: <1247838733.4228.139.camel@domain.hid>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] rt_task_shadow returns always -EFAULT
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Petr Cervenka <grugh@domain.hid>
Cc: xenomai-help <xenomai@xenomai.org>

On Fri, 2009-07-17 at 15:32 +0200, Petr Cervenka wrote:
> >
> >On Fri, 2009-07-17 at 13:17 +0200, Petr Cervenka wrote:
> >> >On Thu, 2009-07-16 at 15:15 +0200, Petr Cervenka wrote:
> >> >> Hello,
> >> >> the xenomai native function rt_task_shadow(...) always returns -EFAULT for me. Only happens in xenomai-2.5-rc2.
> >> >> 
> >> >> Same behaviour was also in 2.5-rc1, see note in my older post:
> >> >> https://mail.gna.org/public/xenomai-help/2009-05/msg00024.html
> >> >> 
> >> >> Example code, in the end of this post:
> >> >> https://mail.gna.org/public/xenomai-help/2009-05/msg00038.html
> >> >> 
> >> >> My configuration:
> >> >> Athlon 64 X2 4600+
> >> >> Kubuntu 7.10
> >> >> linux-2.6.29.5 (also tried 2.6.30.1)
> >> >> xenomai-2.5.-rc2
> >> >
> >> >Does this still break when the name is passed as illustrated below?
> >> >
> >> 
> >> No, it doesn't help.
> >> 
> >> I also tried the xenomai rtprint example -> same behavior. The rt_task_shadow() returns -EFAULT and any following rt_task_sleep() in that task returns -1. The other task works fine.
> >> I will do some deeper examination of rt_task_shadow() code.
> >> If you have any advices, what to send or what to try, i would like to hear it.
> >> 
> >
> >Try instrumenting ksrc/skins/native/syscall.c, __rt_task_create(), to
> >identify which spot returns -EFAULT. I can't reproduce this issue on a
> >ppc target; I may try over x86 later, but this would speed up things if
> >you could spot the failing test before I'm able to switch to this.
> >
> 
> Meanwhile I tried to mess little bit with rt_task_shadow() function to see, where is the source of -EFAULT. I planned to continue to follow it inside syscall etc.
> But most attempts to confirm, that the value is returned by line:
> 	err = XENOMAI_SKINCALL2(__native_muxid, __native_task_create, &bulk,
> 				NULL);

This branches to __rt_task_create in kernel space.

> where suprisingly followed by correct behavior. For example following (nothing doing) change in the attached patch solves the whole thing:
> --- /usr/src/xenomai/src/skins/native/task2.c   2009-04-13 19:20:18.000000000 +0200
> +++ /usr/src/xenomai/src/skins/native/task.c    2009-07-17 15:06:20.000000000 +0200
> @@ -241,6 +241,7 @@
>         pthread_setspecific(__native_tskey, NULL);
>         free(self);
>  #endif /* !HAVE___THREAD */
> +       rt_task_set_mode(0, 0, NULL);
>         return err;
>  }
> 
> objdumps of original and changed rt_task_shadow() is in attachment
> 
> I will continue in research, but I'm really not good in dissasembling nor the register knowledge.
> 

Try rebuilding the user-space libs passing --without-__thread to the
configure script.

> Petr
-- 
Philippe.



