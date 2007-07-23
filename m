Message-ID: <2862c2c80707230104y5e5c9cc0v8038458e8bcc5f1c@domain.hid>
Date: Mon, 23 Jul 2007 16:04:05 +0800
From: "Yeoh Chun Yeow" <yeohchunyeow@domain.hid>
In-Reply-To: <18084.23878.661537.272573@domain.hid>
MIME-Version: 1.0
Content-Type: multipart/alternative; 
	boundary="----=_Part_102761_18188514.1185177845280"
References: <2862c2c80707222152t2037a987mca3f70d1da9865dd@domain.hid>
	<18084.23878.661537.272573@domain.hid>
Subject: Re: [Xenomai-help] Xenomai Testsuite for AT91 - Illegal Instruction
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
Cc: "Xenomai-help@domain.hid" <xenomai@xenomai.org>

------=_Part_102761_18188514.1185177845280
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Dear Gilles,

The same problem still occurs. Here is the /proc/xenomai/faults output:

[root@domain.hid] cat
/proc/xenomai/faults
TRAP         CPU0
  0:            0    (Data or instruction access)
  1:            0    (Section fault)
  2:            0    (Generic data abort)
  3:            0    (Unknown exception)
  4:            0    (Instruction breakpoint)
  5:            0    (Floating point exception)
  6:            0    (VFP Floating point exception)
  7:            0    (Undefined instruction)

Any ideas?

regards,
chun yeow

On 7/23/07, Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org> wrote:
>
> Yeoh Chun Yeow wrote:
> > Dear all,
> >
> > Previous I had the problem with my ARM GNU toolchain with xenomai
> building
> > process.
> >
> > I have donwloaded the ARM GNU toolchain from Code Sourcery. Both the
> Linux
> > kernel and the xenomai have compiled sucessfully.
> >
> > However, whenever I run the testsuite in ./src directory. The test comes
> out
> > with the following results:
> >
> > *
> > *
> > * Type ^C to stop this application.
> > *
> > *
> > Illegal instruction
> >
> > What's go wrong? Is this something to do with generated executable not
> > compatible to AT91 architecture?
> >
> > I have appended the CFLAGS=-march-armv4t for building the xenomai since
> the
> > arm-none-linux-gnueabi is default to ARM5 architecture.
> >
> > Use the following for configure script:
> > CFLAGS="-march=armv4t" ./configure --build=i686-pc-linux-gnu
> > --host=arm-none-linux-gnueabi CC=arm-none-linux-gnueabi-gcc
> > CXX=arm-none-linux-gnueabi-gcc AR=arm-none-linux-gnueabi-ar
> > LD=arm-none-linux-gnueabi-ld --enable-arm-mach=at91
> >
> > Please advice. Thanks
>
> Try compiling with -msoft-float.
>
> --
>
>
>                                             Gilles Chanteperdrix.
>

------=_Part_102761_18188514.1185177845280
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Dear Gilles,<br><br>The same problem still occurs. Here is the /proc/xenomai/faults output:<br><br>[root@domain.hid] cat /proc/xenomai/faults<br>TRAP&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; CPU0<br>&nbsp; 0:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0&nbsp;&nbsp;&nbsp; (Data or instruction access)
<br>&nbsp; 1:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0&nbsp;&nbsp;&nbsp; (Section fault)<br>&nbsp; 2:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0&nbsp;&nbsp;&nbsp; (Generic data abort)<br>&nbsp; 3:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0&nbsp;&nbsp;&nbsp; (Unknown exception)<br>&nbsp; 4:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0&nbsp;&nbsp;&nbsp; (Instruction breakpoint)<br>&nbsp; 5:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0&nbsp;&nbsp;&nbsp; (Floating point exception)
<br>&nbsp; 6:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0&nbsp;&nbsp;&nbsp; (VFP Floating point exception)<br>&nbsp; 7:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0&nbsp;&nbsp;&nbsp; (Undefined instruction)<br><br>Any ideas?<br><br>regards,<br>chun yeow<br><br><div><span class="gmail_quote">On 7/23/07, <b class="gmail_sendername">
Gilles Chanteperdrix</b> &lt;<a href="mailto:gilles.chanteperdrix@xenomai.org">gilles.chanteperdrix@xenomai.org</a>&gt; wrote:</span><blockquote class="gmail_quote" style="border-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;">
Yeoh Chun Yeow wrote:<br> &gt; Dear all,<br> &gt;<br> &gt; Previous I had the problem with my ARM GNU toolchain with xenomai building<br> &gt; process.<br> &gt;<br> &gt; I have donwloaded the ARM GNU toolchain from Code Sourcery. Both the Linux
<br> &gt; kernel and the xenomai have compiled sucessfully.<br> &gt;<br> &gt; However, whenever I run the testsuite in ./src directory. The test comes out<br> &gt; with the following results:<br> &gt;<br> &gt; *<br> &gt; *
<br> &gt; * Type ^C to stop this application.<br> &gt; *<br> &gt; *<br> &gt; Illegal instruction<br> &gt;<br> &gt; What&#39;s go wrong? Is this something to do with generated executable not<br> &gt; compatible to AT91 architecture?
<br> &gt;<br> &gt; I have appended the CFLAGS=-march-armv4t for building the xenomai since the<br> &gt; arm-none-linux-gnueabi is default to ARM5 architecture.<br> &gt;<br> &gt; Use the following for configure script:<br>
 &gt; CFLAGS=&quot;-march=armv4t&quot; ./configure --build=i686-pc-linux-gnu<br> &gt; --host=arm-none-linux-gnueabi CC=arm-none-linux-gnueabi-gcc<br> &gt; CXX=arm-none-linux-gnueabi-gcc AR=arm-none-linux-gnueabi-ar<br> &gt; LD=arm-none-linux-gnueabi-ld --enable-arm-mach=at91
<br> &gt;<br> &gt; Please advice. Thanks<br><br>Try compiling with -msoft-float.<br><br>--<br><br><br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Gilles Chanteperdrix.<br></blockquote></div><br>

------=_Part_102761_18188514.1185177845280--

