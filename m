Message-ID: <25dd9bf10701170253v1f1296e3i265264b6b0e83c83@domain.hid>
Date: Wed, 17 Jan 2007 16:23:35 +0530
From: "Subramani Venkatesh" <subbu31mani@domain.hid>
Subject: Re: [Adeos-main] Porting IPIPE on MIPS Architecture,
	User Process running error, Kernel hangs.
In-Reply-To: <1168943855.17557.45.camel@domain.hid>
MIME-Version: 1.0
Content-Type: multipart/alternative; 
	boundary="----=_Part_108550_1930946.1169031215567"
References: <25dd9bf10701160219w72c8e522l33f4eb9cec59b869@domain.hid>
	<1168943855.17557.45.camel@domain.hid>
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

------=_Part_108550_1930946.1169031215567
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hello Philippe,
I would like to thank you once again for the HINT.
Now I avoided changes to system call calling __ipipe_syscall_root from my
assembly code and tested the same, well it not giving any errors as sent you
yesterday, this concludes there is a problem in a way of calling
__ipipe_syscall_root, I guess my stack is getting corrupted, i will make
sure my stack is saved before calling __ipipe_syscall_root and resolve the
issues.
I thank you once again.

Cheers
Subbu

On 1/16/07, Philippe Gerum <rpm@xenomai.org> wrote:
>
> On Tue, 2007-01-16 at 15:49 +0530, Subramani Venkatesh wrote:
> > Hello All,
> > I am currently porting Adeos-ipipe on one of my MIPS architecture. I
> > am using I-Pipe 1.5-01, X86 as reference to my porting. So Far I did
> > relevant changes in
> > 1.Interrupts handlers
> > 2. System calls
> > 3. Pagefault Handler
> > Except Exception handling, I mean critcial bug events.
> > With this changes I am able to Boot Linux kernel and also able to
> > mount Ramdisk successfully.
> >
>
> [...]
>
> > Opening console is successfull and executing /sbin/init
> > Algorithmics/MIPS FPU Emulator v1.5
> > INIT: version 2.85 booting
> > grep: error while loading shared libraries: libc.so.6: failed to map
> > segment from shared object: Error 4090
>
> There is likely something fishy in the syscall interception path from
> arch/mips/kernel/entry.S; all the syscalls seem to return error values
> mistakenly once the pipelining is in effect. You may want to check your
> changes in this area.
>
> Btw, it would be nice to work in an open manner and post your code on
> this list if you want to ask for help about it here. Contribution has to
> work both ways. TIA,
>
> --
> Philippe.
>
>
>

------=_Part_108550_1930946.1169031215567
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hello Philippe,<br>I would like to thank you once again for the HINT.<br>Now I avoided changes to system call calling __ipipe_syscall_root from my assembly code and tested the same, well it not giving any errors as sent you yesterday, this concludes there is a problem in a way of calling __ipipe_syscall_root, I guess my stack is getting corrupted, i will make sure my stack is saved before calling __ipipe_syscall_root and resolve the issues.
<br>I thank you once again.<br><br>Cheers<br>Subbu<br><br><div><span class="gmail_quote">On 1/16/07, <b class="gmail_sendername">Philippe Gerum</b> &lt;<a href="mailto:rpm@xenomai.org">rpm@xenomai.org</a>&gt; wrote:</span>
<blockquote class="gmail_quote" style="border-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;">On Tue, 2007-01-16 at 15:49 +0530, Subramani Venkatesh wrote:<br>&gt; Hello All,<br>&gt; I am currently porting Adeos-ipipe on one of my MIPS architecture. I
<br>&gt; am using I-Pipe 1.5-01, X86 as reference to my porting. So Far I did<br>&gt; relevant changes in<br>&gt; 1.Interrupts handlers<br>&gt; 2. System calls<br>&gt; 3. Pagefault Handler<br>&gt; Except Exception handling, I mean critcial bug events.
<br>&gt; With this changes I am able to Boot Linux kernel and also able to<br>&gt; mount Ramdisk successfully.<br>&gt;<br><br>[...]<br><br>&gt; Opening console is successfull and executing /sbin/init<br>&gt; Algorithmics/MIPS FPU Emulator 
v1.5<br>&gt; INIT: version 2.85 booting<br>&gt; grep: error while loading shared libraries: libc.so.6: failed to map<br>&gt; segment from shared object: Error 4090<br><br>There is likely something fishy in the syscall interception path from
<br>arch/mips/kernel/entry.S; all the syscalls seem to return error values<br>mistakenly once the pipelining is in effect. You may want to check your<br>changes in this area.<br><br>Btw, it would be nice to work in an open manner and post your code on
<br>this list if you want to ask for help about it here. Contribution has to<br>work both ways. TIA,<br><br>--<br>Philippe.<br><br><br></blockquote></div><br>

------=_Part_108550_1930946.1169031215567--

