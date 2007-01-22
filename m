Message-ID: <25dd9bf10701220412h4f9035b7pb59ef59b4950f8a1@domain.hid>
Date: Mon, 22 Jan 2007 17:42:34 +0530
From: "Subramani Venkatesh" <subbu31mani@domain.hid>
Subject: Re: [Adeos-main] Porting IPIPE on MIPS Architecture,
	User Process running error, Kernel hangs.
In-Reply-To: <1169047678.17493.53.camel@domain.hid>
MIME-Version: 1.0
Content-Type: multipart/alternative; 
	boundary="----=_Part_190073_13472032.1169467954215"
References: <25dd9bf10701160219w72c8e522l33f4eb9cec59b869@domain.hid>
	<1168943855.17557.45.camel@domain.hid>
	<25dd9bf10701170253v1f1296e3i265264b6b0e83c83@domain.hid>
	<1169032761.17493.25.camel@domain.hid>
	<25dd9bf10701170700r7a19c651wbf191bb01925fb58@domain.hid>
	<1169047678.17493.53.camel@domain.hid>
List-Id: General discussion about Adeos <adeos-main.gna.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
List-Archive: </public/adeos-main>
List-Post: <mailto:adeos-main@gna.org>
List-Help: <mailto:adeos-main-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
To: rpm@xenomai.org
Cc: adeos-main@gna.org

------=_Part_190073_13472032.1169467954215
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hello Phillipe,
I would like to thank you for your information on porting Adeos.
Now I registered my Custom domain, virtualizing Timer Interrupt with the
same resolution of Linux, during this time I made use of one of my 7
Segment display to make sure the interrupt handlers of TestDomain displays
Adeos, and I could achieve it too.

I have not tested __ipipe_tune_timer yet, I have one query about it,

Correct if I am wrong. So far my understandig is
1.  __ipipe_tune_timer, manged by the control domain to less resolution than
Linux is responsilbe to call __ipipe_propagate_irq to Linux at regular
interval of HZ.
2. During the course of tuning timer, the current tick count is saved in a
variable to make sure the get_timeoffset should not go wrong during the time
of getting date on Linux.

May I know if there is something more I should understand,also I could read
that in Xenomai, Aperiodic and Periodic Timer playing big role, so the
clarifications with you will help me to get out of few doubts and move on to
fine tuning of Adeos and also understanding in porting of xenomai and it
dependency.

Regards
Subbu

On 1/17/07, Philippe Gerum <rpm@xenomai.org> wrote:
>
> On Wed, 2007-01-17 at 20:30 +0530, Subramani Venkatesh wrote:
> > Phillipe,
> > I will surely look into this, so far local_irq_enable/disable i.e
> > unstall and stall routines did not cause  problem in my assembly code.
> > But I was facing this particular system call issue due to use of stack
> > as arguments to the __ipipe_syscall_root  and also in my case the
> > venilla kernel is using the same register for syscall number and
> > return value, during this case when Iam  trying to save intial system
> > call number on stack and once __ipipe_syscall_root is done I am
> > reading it back, this may be corrupting stack, so I think I need to
> > put more effort to resolve this and oragnize it.
> > BTW  phillipe at this stage can I go testing timer interrupts using by
> > other domain, which registers as priority domain than linux ?
>
> If the interrupt exit path does not suffer from unexpected register
> cloberring, yes.
>
> >
> > Regards
> > Subbu
> >
> >
> > On 1/17/07, Philippe Gerum <rpm@xenomai.org> wrote:
> >         On Wed, 2007-01-17 at 16:23 +0530, Subramani Venkatesh wrote:
> >         > Hello Philippe,
> >         > I would like to thank you once again for the HINT.
> >         > Now I avoided changes to system call calling
> >         __ipipe_syscall_root from
> >         > my assembly code and tested the same, well it not giving any
> >         errors as
> >         > sent you yesterday, this concludes there is a problem in a
> >         way of
> >         > calling __ipipe_syscall_root, I guess my stack is getting
> >         corrupted, i
> >         > will make sure my stack is saved before calling
> >         __ipipe_syscall_root
> >         > and resolve the issues.
> >
> >         You should also check whether substituting inline code from
> >         asmmacro.h
> >         like local_irq_enable/disable with the I-pipe stall/unstall
> >         calls had
> >         any bad side-effect on the register set. Maybe t0 is not the
> >         only
> >         register affected by such operations anymore.
> >
> >         > I thank you once again.
> >         >
> >         > Cheers
> >         > Subbu
> >         >
> >         > On 1/16/07, Philippe Gerum < rpm@xenomai.org> wrote:
> >         >         On Tue, 2007-01-16 at 15:49 +0530, Subramani
> >         Venkatesh wrote:
> >         >         > Hello All,
> >         >         > I am currently porting Adeos-ipipe on one of my
> >         MIPS
> >         >         architecture. I
> >         >         > am using I-Pipe 1.5-01, X86 as reference to my
> >         porting. So
> >         >         Far I did
> >         >         > relevant changes in
> >         >         > 1.Interrupts handlers
> >         >         > 2. System calls
> >         >         > 3. Pagefault Handler
> >         >         > Except Exception handling, I mean critcial bug
> >         events.
> >         >         > With this changes I am able to Boot Linux kernel
> >         and also
> >         >         able to
> >         >         > mount Ramdisk successfully.
> >         >         >
> >         >
> >         >         [...]
> >         >
> >         >         > Opening console is successfull and
> >         executing /sbin/init
> >         >         > Algorithmics/MIPS FPU Emulator v1.5
> >         >         > INIT: version 2.85 booting
> >         >         > grep: error while loading shared libraries:
> >         libc.so.6:
> >         >         failed to map
> >         >         > segment from shared object: Error 4090
> >         >
> >         >         There is likely something fishy in the syscall
> >         interception
> >         >         path from
> >         >         arch/mips/kernel/entry.S; all the syscalls seem to
> >         return
> >         >         error values
> >         >         mistakenly once the pipelining is in effect. You may
> >         want to
> >         >         check your
> >         >         changes in this area.
> >         >
> >         >         Btw, it would be nice to work in an open manner and
> >         post your
> >         >         code on
> >         >         this list if you want to ask for help about it
> >         here.
> >         >         Contribution has to
> >         >         work both ways. TIA,
> >         >
> >         >         --
> >         >         Philippe.
> >         >
> >         >
> >         >
> >         --
> >         Philippe.
> >
> >
> >
> --
> Philippe.
>
>
>

------=_Part_190073_13472032.1169467954215
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hello Phillipe,<br>I would like to thank you for your information on porting Adeos.<br>Now I registered my Custom domain, virtualizing Timer Interrupt with the same resolution of Linux, during this time I made use of one of my 7&nbsp; Segment display to make sure the interrupt handlers of TestDomain displays Adeos, and I could achieve it too.
<br><br>I have not tested __ipipe_tune_timer yet, I have one query about it, <br><br>Correct if I am wrong. So far my understandig is<br>1.&nbsp; __ipipe_tune_timer, manged by the control domain to less resolution than Linux is responsilbe to call __ipipe_propagate_irq to Linux at regular interval of HZ.
<br>2. During the course of tuning timer, the current tick count is saved in a variable to make sure the get_timeoffset should not go wrong during the time of getting date on Linux.<br><br>May I know if there is something more I should understand,also I could read that in Xenomai, Aperiodic and Periodic Timer playing big role, so the clarifications with you will help me to get out of few doubts and move on to fine tuning of Adeos and also understanding in porting of xenomai and it dependency.
<br><br>Regards<br>Subbu<br><br><div><span class="gmail_quote">On 1/17/07, <b class="gmail_sendername">Philippe Gerum</b> &lt;<a href="mailto:rpm@xenomai.org">rpm@xenomai.org</a>&gt; wrote:</span><blockquote class="gmail_quote" style="border-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;">
On Wed, 2007-01-17 at 20:30 +0530, Subramani Venkatesh wrote:<br>&gt; Phillipe,<br>&gt; I will surely look into this, so far local_irq_enable/disable i.e<br>&gt; unstall and stall routines did not cause&nbsp;&nbsp;problem in my assembly code.
<br>&gt; But I was facing this particular system call issue due to use of stack<br>&gt; as arguments to the __ipipe_syscall_root&nbsp;&nbsp;and also in my case the<br>&gt; venilla kernel is using the same register for syscall number and
<br>&gt; return value, during this case when Iam&nbsp;&nbsp;trying to save intial system<br>&gt; call number on stack and once __ipipe_syscall_root is done I am<br>&gt; reading it back, this may be corrupting stack, so I think I need to
<br>&gt; put more effort to resolve this and oragnize it.<br>&gt; BTW&nbsp;&nbsp;phillipe at this stage can I go testing timer interrupts using by<br>&gt; other domain, which registers as priority domain than linux ?<br><br>If the interrupt exit path does not suffer from unexpected register
<br>cloberring, yes.<br><br>&gt;<br>&gt; Regards<br>&gt; Subbu<br>&gt;<br>&gt;<br>&gt; On 1/17/07, Philippe Gerum &lt;<a href="mailto:rpm@xenomai.org">rpm@xenomai.org</a>&gt; wrote:<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; On Wed, 2007-01-17 at 16:23 +0530, Subramani Venkatesh wrote:
<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &gt; Hello Philippe,<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &gt; I would like to thank you once again for the HINT.<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &gt; Now I avoided changes to system call calling<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; __ipipe_syscall_root from<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &gt; my assembly code and tested the same, well it not giving any<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; errors as<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &gt; sent you yesterday, this concludes there is a problem in a<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; way of<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &gt; calling __ipipe_syscall_root, I guess my stack is getting
<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; corrupted, i<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &gt; will make sure my stack is saved before calling<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; __ipipe_syscall_root<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &gt; and resolve the issues.<br>&gt;<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; You should also check whether substituting inline code from
<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; asmmacro.h<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; like local_irq_enable/disable with the I-pipe stall/unstall<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; calls had<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; any bad side-effect on the register set. Maybe t0 is not the<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; only
<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; register affected by such operations anymore.<br>&gt;<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &gt; I thank you once again.<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &gt;<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &gt; Cheers<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &gt; Subbu<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &gt;<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &gt; On 1/16/07, Philippe Gerum &lt; 
<a href="mailto:rpm@xenomai.org">rpm@xenomai.org</a>&gt; wrote:<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; On Tue, 2007-01-16 at 15:49 +0530, Subramani<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Venkatesh wrote:<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &gt; Hello All,<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &gt; I am currently porting Adeos-ipipe on one of my
<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; MIPS<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; architecture. I<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &gt; am using I-Pipe 1.5-01, X86 as reference to my<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; porting. So<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Far I did<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &gt; relevant changes in
<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &gt; 1.Interrupts handlers<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &gt; 2. System calls<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &gt; 3. Pagefault Handler<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &gt; Except Exception handling, I mean critcial bug
<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; events.<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &gt; With this changes I am able to Boot Linux kernel<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; and also<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; able to<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &gt; mount Ramdisk successfully.
<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &gt;<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &gt;<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; [...]<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &gt;<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &gt; Opening console is successfull and<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; executing /sbin/init<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &gt; Algorithmics/MIPS FPU Emulator v1.5<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &gt; INIT: version 2.85 booting<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &gt; grep: error while loading shared libraries:<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 
libc.so.6:<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; failed to map<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &gt; segment from shared object: Error 4090<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &gt;<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; There is likely something fishy in the syscall
<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; interception<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; path from<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; arch/mips/kernel/entry.S; all the syscalls seem to<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; error values<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mistakenly once the pipelining is in effect. You may
<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; want to<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; check your<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; changes in this area.<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &gt;<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Btw, it would be nice to work in an open manner and<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; post your<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; code on<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; this list if you want to ask for help about it<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; here.<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Contribution has to<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; work both ways. TIA,
<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &gt;<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; --<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Philippe.<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &gt;<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &gt;<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &gt;<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; --<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Philippe.<br>&gt;<br>&gt;<br>&gt;
<br>--<br>Philippe.<br><br><br></blockquote></div><br>

------=_Part_190073_13472032.1169467954215--

