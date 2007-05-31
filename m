Message-ID: <7289437c0705310758o3512e5e5x4c1a6d1df444be63@domain.hid>
Date: Thu, 31 May 2007 16:58:43 +0200
From: "Perrine Martignoni" <perrmart@domain.hid>
In-Reply-To: <465ED806.2060608@domain.hid>
MIME-Version: 1.0
Content-Type: multipart/alternative; 
	boundary="----=_Part_16378_29073289.1180623523934"
References: <0B45E93C5FF65740AEAE690BF3848B7A4AB0F3@domain.hid>
	<7289437c0705300051i2634264avc5f2db1fcdb91da8@domain.hid>
	<465D664E.3040700@domain.hid> <465E8FA8.4030507@domain.hid>
	<DD39B5C3F4963040ADC9768BE7E430CB01F54FE7@domain.hid>
	<7289437c0705310558y6e1b4f8fue26c640d863ae041@domain.hid>
	<465EC7C1.5080300@domain.hid> <465ECDEC.1030109@domain.hid>
	<465ECFCA.1070801@domain.hid> <465ED806.2060608@domain.hid>
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
To: xenomai-help <xenomai@xenomai.org>

------=_Part_16378_29073289.1180623523934
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

>Same program as you posted earlier?
Yes. it's the same.

>Can you confirm the issue with this procedure? Also make sure that your
>rebuild and re-installed the Xenomai user space part cleanly ("make
>clean; make install").

I installed cleanly Xenomai.

I compiled too with :
arm-linux-gcc `.../xeno-config --posix-cflags --posix-ldflags` -o
essai_mutex_rt essai_mutex.c

Here is the objdump after :

#> objdump -R essai_mutex_rt

essai_mutex_rt:     format de fichier elf32-little

DYNAMIC RELOCATION RECORDS
OFFSET   TYPE              VALUE
00011234 UNKNOWN           stderr
000111c0 UNKNOWN           __wrap_pthread_mutex_unlock
000111c4 UNKNOWN           printf
000111c8 UNKNOWN           sigemptyset
000111cc UNKNOWN           strerror
000111d0 UNKNOWN           pthread_attr_init
000111d4 UNKNOWN           pthread_exit
000111d8 UNKNOWN           puts
000111dc UNKNOWN           sleep
000111e0 UNKNOWN           sigaddset
000111e4 UNKNOWN           abort
000111e8 UNKNOWN           __wrap_pthread_setschedparam
000111ec UNKNOWN           __wrap_pthread_mutex_lock
000111f0 UNKNOWN           fprintf
000111f4 UNKNOWN           pthread_attr_setinheritsched
000111f8 UNKNOWN           signal
000111fc UNKNOWN           pthread_attr_setstacksize
00011200 UNKNOWN           pthread_sigmask
00011204 UNKNOWN           __wrap_pthread_mutex_init
00011208 UNKNOWN           __wrap_pthread_create
0001120c UNKNOWN           pthread_self
00011210 UNKNOWN           pthread_attr_setschedpolicy
00011214 UNKNOWN           __uClibc_start_main
00011218 UNKNOWN           pthread_attr_setschedparam
0001121c UNKNOWN           pthread_attr_setdetachstate
00011220 UNKNOWN           pthread_join
00011224 UNKNOWN           __wrap_pthread_mutex_destroy

I have the same problem when I want to launch it on my board.
On 5/31/07, Wolfgang Grandegger <wg@domain.hid> wrote:
>
> Jan Kiszka wrote:
> > Wolfgang Grandegger wrote:
> >> Jan Kiszka wrote:
> >>> Perrine Martignoni wrote:
> >>>>> Perrine, did you happen to configure Xenomai with "configure
> --host=arm
> >>>>> ..."? If yes (see config.log), please use "--host=arm-linux". This
> >>>>> solved all issues for me.
> >>>>>
> >>>>> Awaiting your feedback!
> >>>> I configure Xenomai with --host=arm.
> >>>> I tried to configure like this but it doesn't work :
> >>>>
> >>>> ./configure --build=arm-linux --host=arm-linux CC=arm-linux-gcc
> >>>                       ^^^^^^^^^
> >>> I guess you are not compiling Xenomai _on_ an ARM box, are you? :)
> >>> Try --build=i686-linux here.
> >> Or just omit it. Also CC=, CXX=, LD= ist not necessary. For PowerPC
> with
> >> the ELDK, I just use
> >>
> >>   ./configure --host=ppc-linux
> >>
> >> to configure Xenomai.
> >
> > Can we define a common ground for this in README.INSTALL, for all archs?
> > The simpler, the better.
>
> The above works for the ELDK, because the tools ppc-linux-xxx are
> available in the binary path (via PATH), but this might not be true for
> other tool-chains. And this method also does not work with RTnet, IIRC.
> So far, I didn't realize any difference between the configuration
> methods ...
>
> > I was heavily misled by the PPC section, because I do not cross-compile
> > everyday, thus had to look up the procedure again and managed to pick
> > the bad example...
>
> ... but there might be some quirk with ARM and uClibc tool chains of the
> ELDK.
>
> Wolfgang.
>
>
> _______________________________________________
> Xenomai-help mailing list
> Xenomai-help@domain.hid
> https://mail.gna.org/listinfo/xenomai-help
>

------=_Part_16378_29073289.1180623523934
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

<div>&gt;Same program as you posted earlier?<br>Yes. it&#39;s the same.</div>
<div>&nbsp;</div>
<div>&gt;Can you confirm the issue with this procedure? Also make sure that your<br>&gt;rebuild and re-installed the Xenomai user space part cleanly (&quot;make<br>&gt;clean; make install&quot;).</div>
<div>&nbsp;</div>
<div>I installed cleanly Xenomai.</div>
<div>&nbsp;</div>
<div>I compiled&nbsp;too with : </div>
<div>arm-linux-gcc `.../xeno-config --posix-cflags --posix-ldflags` -o essai_mutex_rt essai_mutex.c</div>
<div>&nbsp;</div>
<div>Here is the objdump after : </div>
<div>&nbsp;</div>
<div>#&gt; objdump -R essai_mutex_rt</div>
<div>
<p><font face="courier new,monospace">essai_mutex_rt:&nbsp;&nbsp;&nbsp;&nbsp; format de fichier elf32-little</font></p>
<p><font face="courier new,monospace">DYNAMIC RELOCATION RECORDS<br>OFFSET&nbsp;&nbsp; TYPE&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; VALUE<br>00011234 UNKNOWN&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; stderr<br>000111c0 UNKNOWN&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; __wrap_pthread_mutex_unlock<br>000111c4 UNKNOWN&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; printf
<br>000111c8 UNKNOWN&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; sigemptyset<br>000111cc UNKNOWN&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; strerror<br>000111d0 UNKNOWN&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pthread_attr_init<br>000111d4 UNKNOWN&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pthread_exit<br>000111d8 UNKNOWN&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; puts<br>000111dc UNKNOWN&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; sleep
<br>000111e0 UNKNOWN&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; sigaddset<br>000111e4 UNKNOWN&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; abort<br>000111e8 UNKNOWN&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; __wrap_pthread_setschedparam<br>000111ec UNKNOWN&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; __wrap_pthread_mutex_lock<br>000111f0 UNKNOWN&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; fprintf
<br>000111f4 UNKNOWN&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pthread_attr_setinheritsched<br>000111f8 UNKNOWN&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; signal<br>000111fc UNKNOWN&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pthread_attr_setstacksize<br>00011200 UNKNOWN&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pthread_sigmask<br>00011204 UNKNOWN&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; __wrap_pthread_mutex_init
<br>00011208 UNKNOWN&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; __wrap_pthread_create<br>0001120c UNKNOWN&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pthread_self<br>00011210 UNKNOWN&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pthread_attr_setschedpolicy<br>00011214 UNKNOWN&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; __uClibc_start_main<br>00011218 UNKNOWN&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pthread_attr_setschedparam
<br>0001121c UNKNOWN&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pthread_attr_setdetachstate<br>00011220 UNKNOWN&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pthread_join<br>00011224 UNKNOWN&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; __wrap_pthread_mutex_destroy</font></p>
<p>I have the same problem when I want to launch it on my board.<br></p></div>
<div><span class="gmail_quote">On 5/31/07, <b class="gmail_sendername">Wolfgang Grandegger</b> &lt;<a href="mailto:wg@domain.hid">wg@domain.hid</a>&gt; wrote:</span>
<blockquote class="gmail_quote" style="PADDING-LEFT: 1ex; MARGIN: 0px 0px 0px 0.8ex; BORDER-LEFT: #ccc 1px solid">Jan Kiszka wrote:<br>&gt; Wolfgang Grandegger wrote:<br>&gt;&gt; Jan Kiszka wrote:<br>&gt;&gt;&gt; Perrine Martignoni wrote:
<br>&gt;&gt;&gt;&gt;&gt; Perrine, did you happen to configure Xenomai with &quot;configure --host=arm<br>&gt;&gt;&gt;&gt;&gt; ...&quot;? If yes (see config.log), please use &quot;--host=arm-linux&quot;. This<br>&gt;&gt;&gt;&gt;&gt; solved all issues for me.
<br>&gt;&gt;&gt;&gt;&gt;<br>&gt;&gt;&gt;&gt;&gt; Awaiting your feedback!<br>&gt;&gt;&gt;&gt; I configure Xenomai with --host=arm.<br>&gt;&gt;&gt;&gt; I tried to configure like this but it doesn&#39;t work :<br>&gt;&gt;&gt;&gt;
<br>&gt;&gt;&gt;&gt; ./configure --build=arm-linux --host=arm-linux CC=arm-linux-gcc<br>&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ^^^^^^^^^<br>&gt;&gt;&gt; I guess you are not compiling Xenomai _on_ an ARM box, are you? :)<br>&gt;&gt;&gt; Try --build=i686-linux here.
<br>&gt;&gt; Or just omit it. Also CC=, CXX=, LD= ist not necessary. For PowerPC with<br>&gt;&gt; the ELDK, I just use<br>&gt;&gt;<br>&gt;&gt;&nbsp;&nbsp; ./configure --host=ppc-linux<br>&gt;&gt;<br>&gt;&gt; to configure Xenomai.<br>
&gt;<br>&gt; Can we define a common ground for this in README.INSTALL, for all archs?<br>&gt; The simpler, the better.<br><br>The above works for the ELDK, because the tools ppc-linux-xxx are<br>available in the binary path (via PATH), but this might not be true for
<br>other tool-chains. And this method also does not work with RTnet, IIRC.<br>So far, I didn&#39;t realize any difference between the configuration<br>methods ...<br><br>&gt; I was heavily misled by the PPC section, because I do not cross-compile
<br>&gt; everyday, thus had to look up the procedure again and managed to pick<br>&gt; the bad example...<br><br>... but there might be some quirk with ARM and uClibc tool chains of the<br>ELDK.<br><br>Wolfgang.<br><br><br>
_______________________________________________<br>Xenomai-help mailing list<br><a href="mailto:Xenomai-help@domain.hid">Xenomai-help@domain.hid</a><br><a href="https://mail.gna.org/listinfo/xenomai-help">https://mail.gna.org/listinfo/xenomai-help
</a><br></blockquote></div><br>

------=_Part_16378_29073289.1180623523934--

