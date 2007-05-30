Message-ID: <7289437c0705292257u57e991a1l270d478fdf7f757d@domain.hid>
Date: Wed, 30 May 2007 07:57:55 +0200
From: "Perrine Martignoni" <perrmart@domain.hid>
In-Reply-To: <18012.28254.882249.144005@domain.hid>
MIME-Version: 1.0
Content-Type: multipart/alternative; 
	boundary="----=_Part_150_26603704.1180504675594"
References: <0B45E93C5FF65740AEAE690BF3848B7A4AB0F3@domain.hid>
	<465ADB44.2070705@domain.hid> <1180360288.4727.50.camel@domain.hid>
	<7289437c0705290130k627df2f9j2940c509311c75c5@domain.hid>
	<465BE777.7010204@domain.hid>
	<7289437c0705290347y20eeff5bq3e86cd0cd4984ddb@domain.hid>
	<465C6268.1090704@domain.hid>
	<18012.28254.882249.144005@domain.hid>
Subject: Re: [Xenomai-help] =?iso-8859-1?q?Xenomai_with_=B5Clibc?=
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: xenomai@xenomai.org

------=_Part_150_26603704.1180504675594
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

>Could you show us the compilation command used to compile cyclictest or
switchtest ?

I didn't try to compile myself these tests. I thought they were compiled
when I installed Xenomai and put in /xenomai/bin

I'll try to do it myself.


On 5/29/07, Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org> wrote:
>
> Jan Kiszka wrote:
> > Perrine Martignoni wrote:
> > ...
> > > -Wl,--wrap,close -Wl,--wrap,shm_open -Wl,--wrap,shm_unlink
> -Wl,--wrap,mmap
> > > -Wl,--wrap,munmap -L/usr/xenomai_arm-2.3.1uClibc/lib essai_mutex_rt.o
> > > -lpthread_rt -lpthread -lrt -o essai_mutex_rt
> >
> > I think to remember the ordering makes a difference here: Try to put
> > essai_mutex_rt.o after the libs. That's also what happens when using the
> > Xenomai provided flags.
>
> Yes, the order matters, but essai_mutex_rt.o should be before the
> libraries. Xenomai makefiles pass libraries in the LDADD variable, which
> is put at the very end of the compilation command line.
>
> >
> > Apropos: Use `<xenomai-installation-path>/xeno-config --posix-ldflags`
> > (also for --posix-cflags) to make your life easier. There is generally
> > no need to maintain all the flags on your own - and it's error-prone.
>
> I thought that what Perrine showed us was the result of running make and
> that her makefiles really used xeno-config.
>
> --
>
>
>                                             Gilles Chanteperdrix.
>

------=_Part_150_26603704.1180504675594
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

&gt;Could you show us the compilation command used to compile cyclictest or<br>switchtest ?<br><br>I didn&#39;t try to compile myself these tests. I thought they were compiled when I installed Xenomai and put in /xenomai/bin
<br><br>I&#39;ll try to do it myself.<br><br><br><div><span class="gmail_quote">On 5/29/07, <b class="gmail_sendername">Gilles Chanteperdrix</b> &lt;<a href="mailto:gilles.chanteperdrix@xenomai.org">gilles.chanteperdrix@xenomai.org
</a>&gt; wrote:</span><blockquote class="gmail_quote" style="border-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;">Jan Kiszka wrote:<br> &gt; Perrine Martignoni wrote:<br> &gt; ...<br> &gt; &gt; -Wl,--wrap,close -Wl,--wrap,shm_open -Wl,--wrap,shm_unlink -Wl,--wrap,mmap
<br> &gt; &gt; -Wl,--wrap,munmap -L/usr/xenomai_arm-2.3.1uClibc/lib essai_mutex_rt.o<br> &gt; &gt; -lpthread_rt -lpthread -lrt -o essai_mutex_rt<br> &gt;<br> &gt; I think to remember the ordering makes a difference here: Try to put
<br> &gt; essai_mutex_rt.o after the libs. That&#39;s also what happens when using the<br> &gt; Xenomai provided flags.<br><br>Yes, the order matters, but essai_mutex_rt.o should be before the<br>libraries. Xenomai makefiles pass libraries in the LDADD variable, which
<br>is put at the very end of the compilation command line.<br><br> &gt;<br> &gt; Apropos: Use `&lt;xenomai-installation-path&gt;/xeno-config --posix-ldflags`<br> &gt; (also for --posix-cflags) to make your life easier. There is generally
<br> &gt; no need to maintain all the flags on your own - and it&#39;s error-prone.<br><br>I thought that what Perrine showed us was the result of running make and<br>that her makefiles really used xeno-config.<br><br>--<br>
<br><br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Gilles Chanteperdrix.<br></blockquote></div><br>

------=_Part_150_26603704.1180504675594--

