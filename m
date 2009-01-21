Message-ID: <f48df4840901201628g1c12c3d3w3d3c805e1147936e@domain.hid>
Date: Wed, 21 Jan 2009 01:28:16 +0100
From: "Bruno Rouchouse" <brouchouse@domain.hid>
In-Reply-To: <f48df4840901191553w238f883bk4d3910be7405c1d@domain.hid>
MIME-Version: 1.0
Content-Type: multipart/alternative; 
	boundary="----=_Part_29452_26900991.1232497696841"
References: <f48df4840901191553w238f883bk4d3910be7405c1d@domain.hid>
Subject: Re: [Xenomai-help] Xenomai on Intel Core2 Quad CPU
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: "Xenomai-help@domain.hid" <xenomai@xenomai.org>

------=_Part_29452_26900991.1232497696841
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Problem solved!

It was apparently coming from some kernel debugging feature that I activated
in my configuration. I haven't identified precisely which one since I unset
a couple of them at the same time.

Thanks Paul for your help and configuration file. It was really helpful.

--Bruno


2009/1/20 Bruno Rouchouse <brouchouse@domain.hid>

> Hi list,
>
> I'm trying to get Xenomai to work on my Intel Core 2 Quad (x86_64) but I'm
> facing a critical issue here and I'd like to know if someone has already
> stumbled over a similar problem.
>
> *Problem:
> *I experience a kernel freeze or spurious reboot as soon as I get "I-pipe:
> Domain Xenomai Registered". I usually get a few more messages after that
> like "BUG: unable to handle kernel paging request at 0xfffffffffffffff"
> before the kernel freezes but I don't think they are really relevant since
> there are almost different every time!
>
> *Configuration:
> *cat /proc/cpuinfo while running Linux ubuntu 2.6.27-7-generic #1 SMP Tue
> Nov 4 19:33:06 UTC 2008 x86_64 GNU/Linux
>
> (first core only)
> processor    : 0
> vendor_id    : GenuineIntel
> cpu family    : 6
> model        : 23
> model name    : Intel(R) Core(TM)2 Quad CPU    Q9400  @ 2.66GHz
> stepping    : 10
> cpu MHz        : 2003.000
> cache size    : 3072 KB
> physical id    : 0
> siblings    : 4
> core id        : 0
> cpu cores    : 4
> apicid        : 0
> initial apicid    : 0
> fpu        : yes
> fpu_exception    : yes
> cpuid level    : 13
> wp        : yes
> flags        : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca
> cmov pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm pbe syscall nx lm
> constant_tsc arch_perfmon pebs bts rep_good nopl pni monitor ds_cpl vmx smx
> est tm2 ssse3 cx16 xtpr sse4_1 lahf_lm
> bogomips    : 5343.17
> clflush size    : 64
> cache_alignment    : 64
> address sizes    : 36 bits physical, 48 bits virtual
> power management:
>
> Linux Kernel version: 2.6.27.11
> Adeos patch: adeos-ipipe-2.6.27-x86-2.2-02.patch from svn
>
> Kernel configuration file attached to this email.
>
> *Things I have tried so far:
> *Gilles pointed out to me this thread:
> https://mail.gna.org/public/xenomai-help/2008-12/msg00088.html
> I did try to apply the patch but without any success. I also tried to
> change maxcpus on the bootline but it doesn't change anything either. In
> fact, I don't think it is the same issue here since I seem to crash at the
> very beginning of the boot process.
>
> Of course disabling I-pipe support in the configuration works fine.
>
> Try to get as few options as possible. Probably not finished but it didn't
> help either so far!
>
> Since the more I work on that, the least it's probably going to work :) I
> need to step back a little bit. I would appreciate any hints or advice on
> how to tackle that. Any configuration file on a same or similar
> configuration is also very welcome. It may just be a stupid conflict in my
> kernel features that may provoke this problem.
>
> Thanks in advance...
>
> Best regards,
>
> --Bruno
>

------=_Part_29452_26900991.1232497696841
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Problem solved!<br><br>It was apparently coming from some kernel debugging feature that I activated in my configuration. I haven&#39;t identified precisely which one since I unset a couple of them at the same time.<br><br>
Thanks Paul for your help and configuration file. It was really helpful.<br><br>--Bruno<br><br><br><div class="gmail_quote">2009/1/20 Bruno Rouchouse <span dir="ltr">&lt;<a href="mailto:brouchouse@domain.hid">brouchouse@domain.hid</a>&gt;</span><br>
<blockquote class="gmail_quote" style="border-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;">Hi list,<br><br>I&#39;m trying to get Xenomai to work on my Intel Core 2 Quad (x86_64) but I&#39;m facing a critical issue here and I&#39;d like to know if someone has already stumbled over a similar problem.<br>
<br><b>Problem:<br>

</b>I experience a kernel freeze or spurious reboot as soon as I get &quot;I-pipe: Domain Xenomai Registered&quot;. I usually get a few more messages after that like &quot;BUG: unable to handle kernel paging request at 0xfffffffffffffff&quot; before the kernel freezes but I don&#39;t think they are really relevant since there are almost different every time!<br>


<br><b>Configuration:<br></b>cat /proc/cpuinfo while running Linux ubuntu 2.6.27-7-generic #1 SMP Tue Nov 4 19:33:06 UTC 2008 x86_64 GNU/Linux<br><br>(first core only)<br>processor&nbsp;&nbsp;&nbsp; : 0<br>vendor_id&nbsp;&nbsp;&nbsp; : GenuineIntel<br>

cpu family&nbsp;&nbsp;&nbsp; : 6<br>
model&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; : 23<br>model name&nbsp;&nbsp;&nbsp; : Intel(R) Core(TM)2 Quad CPU&nbsp;&nbsp;&nbsp; Q9400&nbsp; @ 2.66GHz<br>stepping&nbsp;&nbsp;&nbsp; : 10<br>cpu MHz&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; : 2003.000<br>cache size&nbsp;&nbsp;&nbsp; : 3072 KB<br>physical id&nbsp;&nbsp;&nbsp; : 0<br>siblings&nbsp;&nbsp;&nbsp; : 4<br>core id&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; : 0<br>


cpu cores&nbsp;&nbsp;&nbsp; : 4<br>apicid&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; : 0<br>initial apicid&nbsp;&nbsp;&nbsp; : 0<br>fpu&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; : yes<br>fpu_exception&nbsp;&nbsp;&nbsp; : yes<br>cpuid level&nbsp;&nbsp;&nbsp; : 13<br>wp&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; : yes<br>flags&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm pbe syscall nx lm constant_tsc arch_perfmon pebs bts rep_good nopl pni monitor ds_cpl vmx smx est tm2 ssse3 cx16 xtpr sse4_1 lahf_lm<br>


bogomips&nbsp;&nbsp;&nbsp; : 5343.17<br>clflush size&nbsp;&nbsp;&nbsp; : 64<br>cache_alignment&nbsp;&nbsp;&nbsp; : 64<br>address sizes&nbsp;&nbsp;&nbsp; : 36 bits physical, 48 bits virtual<br>power management:<br><br>Linux Kernel version: 2.6.27.11<br>Adeos patch: adeos-ipipe-2.6.27-x86-2.2-02.patch from svn<br>


<br>Kernel configuration file attached to this email.<br><br><b>Things I have tried so far:<br></b>Gilles pointed out to me this thread: <a href="https://mail.gna.org/public/xenomai-help/2008-12/msg00088.html" target="_blank">https://mail.gna.org/public/xenomai-help/2008-12/msg00088.html</a><br>

I did try to apply the patch but without any success. I also tried to change maxcpus on the bootline but it doesn&#39;t change anything either. In fact, I don&#39;t think it is the same issue here since I seem to crash at the very beginning of the boot process.<br>

<br>Of course disabling I-pipe support in the configuration works fine.<br><br>Try to get as few options as possible. Probably not finished but it didn&#39;t help either so far!<br><br>Since the more I work on that, the least it&#39;s probably going to work :) I need to step back a little bit. I would appreciate any hints or advice on how to tackle that. Any configuration file on a same or similar configuration is also very welcome. It may just be a stupid conflict in my kernel features that may provoke this problem.<br>

<br>Thanks in advance...<br><br>Best regards,<br><font color="#888888"><br>--Bruno<br>
</font></blockquote></div><br>

------=_Part_29452_26900991.1232497696841--

