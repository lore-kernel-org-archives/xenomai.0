Message-ID: <f48df4840605241128p6b4547ffv85882b89c9c4382a@domain.hid>
Date: Wed, 24 May 2006 20:28:45 +0200
From: "Bruno Rouchouse" <brouchouse@domain.hid>
Subject: Re: [Xenomai-help] installing Xenomai on an AMD64
In-Reply-To: <34641.155.98.4.39.1148488917.squirrel@domain.hid>
MIME-Version: 1.0
Content-Type: multipart/alternative; 
	boundary="----=_Part_7518_24532518.1148495325494"
References: <34641.155.98.4.39.1148488917.squirrel@domain.hid>
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Brandt Erickson <brandt@domain.hid>
Cc: xenomai@xenomai.org

------=_Part_7518_24532518.1148495325494
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi Brandlt,

On 5/24/06, Brandt Erickson <brandt@domain.hid> wrote:
>
> Hey all,
> I'm trying to install xenomai-2.1.2 on a system running ubuntu configured
> for AMD64.  Since xenomai doesn't currently support x86_64, I patched it
> for i386.  Unfortunately, when I go to compile the kernel, I get an error,
>
>   CHK     include/linux/version.h
>   CC      arch/x86_64/kernel/asm-offsets.s
> In file included from include/linux/sched.h:7,
>                  from arch/x86_64/kernel/asm-offsets.c:7:
> include/linux/ipipe.h:28:23: error: asm/ipipe.h: No such file or directory
> make[1]: *** [arch/x86_64/kernel/asm-offsets.s] Error 1
> make: *** [prepare0] Error 2


I did get Xenomai compiled on AMD64 but not to work ! Did you compile in 32
bit mode ?
What I did is a make ARCH=i386 xconfig to configure my kernel in 32 bit
mode. The compilation goes then fine but when I boot on my new kernel, I get
the following error message : "request-module: runaway loop modprobe
binfmt-464c"

The xenomai patch is not the problem here. In fact I tried to compile my
Linux kernel for x86 architecture just passing the i386 architecture to
make. I get the same error message and I'm stuck here atm. I didn't have
time to investigate more on this problem.

could anyone fill me in on how to setup and compile xenomai on an x86_64
> system?  I could overwrite the OS with a generic x86 version of ubuntu,
> but that would preferably be a last resort.  Thanks.


I'll let you know if I get any success with it.

-Brandt



--
Bruno Rouchouse

------=_Part_7518_24532518.1148495325494
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi Brandlt,<br><br><div><span class="gmail_quote">On 5/24/06, <b class="gmail_sendername">Brandt Erickson</b> &lt;<a href="mailto:brandt@domain.hid">brandt@domain.hid</a>&gt; wrote:</span><blockquote class="gmail_quote" style="border-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;">
Hey all,<br>I'm trying to install xenomai-2.1.2 on a system running ubuntu configured<br>for AMD64.&nbsp;&nbsp;Since xenomai doesn't currently support x86_64, I patched it<br>for i386.&nbsp;&nbsp;Unfortunately, when I go to compile the kernel, I get an error,
<br><br>&nbsp;&nbsp;CHK&nbsp;&nbsp;&nbsp;&nbsp; include/linux/version.h<br>&nbsp;&nbsp;CC&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;arch/x86_64/kernel/asm-offsets.s<br>In file included from include/linux/sched.h:7,<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; from arch/x86_64/kernel/asm-offsets.c:7:<br>include/linux/ipipe.h:28:23: error: asm/ipipe.h: No such file or directory
<br>make[1]: *** [arch/x86_64/kernel/asm-offsets.s] Error 1<br>make: *** [prepare0] Error 2</blockquote><div><br>I did get Xenomai compiled on AMD64 but not to work ! Did you compile in 32 bit mode ?<br>What I did is a make ARCH=i386 xconfig to configure my kernel in 32 bit mode. The compilation goes then fine but when I boot on my new kernel, I get the following error message : &quot;request-module: runaway loop modprobe binfmt-464c&quot;
<br><br>The xenomai patch is not the problem here. In fact I tried to compile my Linux kernel for x86 architecture just passing the i386 architecture to make. I get the same error message and I'm stuck here atm. I didn't have time to investigate more on this problem.
<br></div><br><blockquote class="gmail_quote" style="border-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;">could anyone fill me in on how to setup and compile xenomai on an x86_64<br>system?&nbsp;&nbsp;I could overwrite the OS with a generic x86 version of ubuntu,
<br>but that would preferably be a last resort.&nbsp;&nbsp;Thanks.</blockquote><div><br>I'll let you know if I get any success with it.<br></div><br><blockquote class="gmail_quote" style="border-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;">
-Brandt</blockquote><div><br><br>--<br>Bruno Rouchouse<br><br></div></div>

------=_Part_7518_24532518.1148495325494--

