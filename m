Message-ID: <67b6b3430811131959r6bc22545wd4e3df613c15fc7b@domain.hid>
Date: Thu, 13 Nov 2008 19:59:18 -0800
From: "Mark Saiia" <mark.saiia@domain.hid>
In-Reply-To: <491C0B50.6030507@domain.hid>
MIME-Version: 1.0
Content-Type: multipart/alternative; 
	boundary="----=_Part_6724_17502607.1226635158549"
References: <51CAD0CE1504444DBE77CBBE51A0135D533259@domain.hid>
	<490F2F23.2080307@domain.hid>
	<67b6b3430811031237v4cfba0c9sf63e40a697f3da58@domain.hid>
	<49100825.9000502@domain.hid> <4915C4D3.8030304@domain.hid>
	<67b6b3430811101607k75eaa084ga387c453096d2710@domain.hid>
	<1c74c6152ff1b52eaa3dd84f4b912b29.squirrel@domain.hid>
	<51CAD0CE1504444DBE77CBBE51A0135D53344A@slcmail.slc.mew.int>
	<67b6b3430811111432o1ca14e87w7ccab4ab95dd591e@domain.hid>
	<491C0B50.6030507@domain.hid>
Subject: Re: [Xenomai-help] fpu context switch issue
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
Cc: xenomai@xenomai.org

------=_Part_6724_17502607.1226635158549
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Gilles,

No noticeable difference using 2.4.5 w/ 2.6.26.3.  I was testing using the
app we first noticed the behavior on.  I will run the simple test program
tomorrow, but fully expect to see the erroneous behavior.  I also had the
chance to test the patch on a GX1 board, and noticed the error as well. We
have a version of the app, that I was testing today, running on 2.6.23.12 w/
Xenomai svn of around February 2008 (I don't have the revision number in
front of me at the moment) that works properly.

Thanks,

Mark


On Thu, Nov 13, 2008 at 3:11 AM, Gilles Chanteperdrix <
gilles.chanteperdrix@xenomai.org> wrote:

> Mark Saiia wrote:
> > I applied the patch to Xenomai-2.4.5 with kernel 2.6.26.3 and observed
> the
> > erroneous behavior.  I did the same with linux-2.6.27.5 and Xenomai r4372
> > and noticed the same behavior.  Please let me know if I can run
> additional
> > tests, if you need any more information, or how to potentially fix this
> > issue.
> >
> > Thank you,
>
> Could you try the following patch ?
>
> --
>                                                 Gilles.
>
> diff --git a/arch/x86/kernel/traps_32.c b/arch/x86/kernel/traps_32.c
> index f422387..f9f213a 100644
> --- a/arch/x86/kernel/traps_32.c
> +++ b/arch/x86/kernel/traps_32.c
> @@ -1159,6 +1159,8 @@ asmlinkage void math_state_restore(void)
>        struct task_struct *tsk = thread->task;
>        unsigned long flags;
>
> +       local_irq_save_hw_cond(flags);
> +#ifndef CONFIG_IPIPE
>        if (!tsk_used_math(tsk)) {
>                local_irq_enable();
>                /*
> @@ -1173,8 +1175,11 @@ asmlinkage void math_state_restore(void)
>                }
>                local_irq_disable();
>        }
> -
> -       local_irq_save_hw_cond(flags);
> +#else /* CONFIG_IPIPE */
> +       if (!tsk_used_math(tsk))
> +               /* No alloc, can not fail. */
> +               init_fpu(tsk)
> +#endif /* CONFIG_IPIPE */
>        clts();                         /* Allow maths ops (or we recurse)
> */
>        restore_fpu(tsk);
>        thread->status |= TS_USEDFPU;   /* So we fnsave on switch_to() */
>
>

------=_Part_6724_17502607.1226635158549
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Gilles,<br><br>No noticeable difference using 2.4.5 w/ <a href="http://2.6.26.3">2.6.26.3</a>.&nbsp; I was testing using the app we first noticed the behavior on.&nbsp; I will run the simple test program tomorrow, but fully expect to see the erroneous behavior.&nbsp; I also had the chance to test the patch on a GX1 board, and noticed the error as well. We have a version of the app, that I was testing today, running on <a href="http://2.6.23.12">2.6.23.12</a> w/ Xenomai svn of around February 2008 (I don&#39;t have the revision number in front of me at the moment) that works properly.<br>
<br>Thanks,<br><br>Mark<br><br><br><div class="gmail_quote">On Thu, Nov 13, 2008 at 3:11 AM, Gilles Chanteperdrix <span dir="ltr">&lt;<a href="mailto:gilles.chanteperdrix@xenomai.org">gilles.chanteperdrix@xenomai.org</a>&gt;</span> wrote:<br>
<blockquote class="gmail_quote" style="border-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;"><div><div></div><div class="Wj3C7c">Mark Saiia wrote:<br>
&gt; I applied the patch to Xenomai-2.4.5 with kernel <a href="http://2.6.26.3" target="_blank">2.6.26.3</a> and observed the<br>
&gt; erroneous behavior. &nbsp;I did the same with linux-2.6.27.5 and Xenomai r4372<br>
&gt; and noticed the same behavior. &nbsp;Please let me know if I can run additional<br>
&gt; tests, if you need any more information, or how to potentially fix this<br>
&gt; issue.<br>
&gt;<br>
&gt; Thank you,<br>
<br>
</div></div>Could you try the following patch ?<br>
<br>
--<br>
 &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; Gilles.<br>
<br>
diff --git a/arch/x86/kernel/traps_32.c b/arch/x86/kernel/traps_32.c<br>
index f422387..f9f213a 100644<br>
--- a/arch/x86/kernel/traps_32.c<br>
+++ b/arch/x86/kernel/traps_32.c<br>
@@ -1159,6 +1159,8 @@ asmlinkage void math_state_restore(void)<br>
 &nbsp; &nbsp; &nbsp; &nbsp;struct task_struct *tsk = thread-&gt;task;<br>
 &nbsp; &nbsp; &nbsp; &nbsp;unsigned long flags;<br>
<br>
+ &nbsp; &nbsp; &nbsp; local_irq_save_hw_cond(flags);<br>
+#ifndef CONFIG_IPIPE<br>
 &nbsp; &nbsp; &nbsp; &nbsp;if (!tsk_used_math(tsk)) {<br>
 &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;local_irq_enable();<br>
 &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;/*<br>
@@ -1173,8 +1175,11 @@ asmlinkage void math_state_restore(void)<br>
 &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;}<br>
 &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;local_irq_disable();<br>
 &nbsp; &nbsp; &nbsp; &nbsp;}<br>
-<br>
- &nbsp; &nbsp; &nbsp; local_irq_save_hw_cond(flags);<br>
+#else /* CONFIG_IPIPE */<br>
+ &nbsp; &nbsp; &nbsp; if (!tsk_used_math(tsk))<br>
+ &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; /* No alloc, can not fail. */<br>
+ &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; init_fpu(tsk)<br>
+#endif /* CONFIG_IPIPE */<br>
 &nbsp; &nbsp; &nbsp; &nbsp;clts(); &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; /* Allow maths ops (or we recurse) */<br>
 &nbsp; &nbsp; &nbsp; &nbsp;restore_fpu(tsk);<br>
 &nbsp; &nbsp; &nbsp; &nbsp;thread-&gt;status |= TS_USEDFPU; &nbsp; /* So we fnsave on switch_to() */<br>
<br>
</blockquote></div><br>

------=_Part_6724_17502607.1226635158549--

