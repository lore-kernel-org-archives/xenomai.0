Message-ID: <b054e88e0810300921y6bb10e4y6abe3661ee3ef4a7@domain.hid>
Date: Thu, 30 Oct 2008 17:21:27 +0100
From: "Giammarco Zacheo" <g.zacheo@domain.hid>
In-Reply-To: <49097E14.8050708@domain.hid>
MIME-Version: 1.0
Content-Type: multipart/alternative; 
	boundary="----=_Part_38051_28833768.1225383687418"
References: <b054e88e0810291200l51eb2c84g2c3a6277d35e0344@domain.hid>
	<49097E14.8050708@domain.hid>
Subject: Re: [Xenomai-help] testsuite/clocktest hangs
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
Cc: xenomai-help <xenomai@xenomai.org>

------=_Part_38051_28833768.1225383687418
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Fixed. Thanks.

Giammarco

On Thu, Oct 30, 2008 at 10:27 AM, Jan Kiszka <jan.kiszka@domain.hid> wrote:

> Giammarco Zacheo wrote:
> > Hi all,
> >   I am running some tests on my mpc5200b board running Xenomai 2.4.5 with
> > kernel DENX-2.6.25. When I run the clocktest program, it hangs after a
> > variable period of time. Xenomai's watchdog recognizes it as a runaway
> task,
> > and gdb tells that thread 1 is hanging at nanosleep(). Same behaviour
> with
> > DENX-2.6.26
> >
> > Here's the output of gdb:
> >
> > Program received signal SIGINT, Interrupt.
> > [Switching to Thread 0x48024d90 (LWP 352)]
> > 0x0fe1ebb8 in nanosleep () from /lib/libc.so.6
> > (gdb) thread 1
> > [Switching to thread 1 (Thread 0x48024d90 (LWP 352))]#0  0x0fe1ebb8 in
> > nanosleep () from /lib/libc.so.6
> > (gdb) bt
> > #0  0x0fe1ebb8 in nanosleep () from /lib/libc.so.6
> > #1  0x0fe4bea0 in usleep () from /lib/libc.so.6
> > #2  0x1000259c in main (argc=1, argv=0xbfa6eb84) at clocktest.c:243
> > (gdb)
>
> Could you try latest clocktest.c from SVN (2.4.x or trunk)? I fixed a
> very similar issue recently, but I'm not sure if it applies to your
> scenario.
>
> Jan
>
> --
> Siemens AG, Corporate Technology, CT SE 2
> Corporate Competence Center Embedded Linux
>

------=_Part_38051_28833768.1225383687418
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Fixed. Thanks.<br><br>Giammarco<br><br><div class="gmail_quote">On Thu, Oct 30, 2008 at 10:27 AM, Jan Kiszka <span dir="ltr">&lt;<a href="mailto:jan.kiszka@domain.hid">jan.kiszka@domain.hid</a>&gt;</span> wrote:<br><blockquote class="gmail_quote" style="border-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;">
<div><div></div><div class="Wj3C7c">Giammarco Zacheo wrote:<br>
&gt; Hi all,<br>
&gt; &nbsp; I am running some tests on my mpc5200b board running Xenomai 2.4.5 with<br>
&gt; kernel DENX-2.6.25. When I run the clocktest program, it hangs after a<br>
&gt; variable period of time. Xenomai&#39;s watchdog recognizes it as a runaway task,<br>
&gt; and gdb tells that thread 1 is hanging at nanosleep(). Same behaviour with<br>
&gt; DENX-2.6.26<br>
&gt;<br>
&gt; Here&#39;s the output of gdb:<br>
&gt;<br>
&gt; Program received signal SIGINT, Interrupt.<br>
&gt; [Switching to Thread 0x48024d90 (LWP 352)]<br>
&gt; 0x0fe1ebb8 in nanosleep () from /lib/libc.so.6<br>
&gt; (gdb) thread 1<br>
&gt; [Switching to thread 1 (Thread 0x48024d90 (LWP 352))]#0 &nbsp;0x0fe1ebb8 in<br>
&gt; nanosleep () from /lib/libc.so.6<br>
&gt; (gdb) bt<br>
&gt; #0 &nbsp;0x0fe1ebb8 in nanosleep () from /lib/libc.so.6<br>
&gt; #1 &nbsp;0x0fe4bea0 in usleep () from /lib/libc.so.6<br>
&gt; #2 &nbsp;0x1000259c in main (argc=1, argv=0xbfa6eb84) at clocktest.c:243<br>
&gt; (gdb)<br>
<br>
</div></div>Could you try latest clocktest.c from SVN (2.4.x or trunk)? I fixed a<br>
very similar issue recently, but I&#39;m not sure if it applies to your<br>
scenario.<br>
<br>
Jan<br>
<font color="#888888"><br>
--<br>
Siemens AG, Corporate Technology, CT SE 2<br>
Corporate Competence Center Embedded Linux<br>
</font></blockquote></div><br>

------=_Part_38051_28833768.1225383687418--

