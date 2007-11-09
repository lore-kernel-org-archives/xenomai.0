Message-ID: <e4ef24880711091357n2256afa2p8aeae76018bc7993@domain.hid>
Date: Fri, 9 Nov 2007 14:57:14 -0700
From: "Robert Gubler" <rgubler@domain.hid>
In-Reply-To: <e4ef24880711091329g3dd27f0ds6fe033ef79993022@domain.hid>
MIME-Version: 1.0
Content-Type: multipart/alternative; 
	boundary="----=_Part_14355_24408297.1194645434718"
References: <e4ef24880711091329g3dd27f0ds6fe033ef79993022@domain.hid>
Subject: Re: [Xenomai-help] Synchronizing CLOCK_REALTIME between networked
	computers
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

------=_Part_14355_24408297.1194645434718
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

OK, I dug through some code.  It looks like it is possible to set
CLOCK_REALTIME?  I tried to trace clock_settime().  There are a bunch of
different calls that seem to happen.  Some that get translated through
syscall.  Anyway, I found this, and it seems to suggest that it is possible
to set CLOCK_REALTIME.  Is the documentation incorrect, or am I tricking
myself into thinking I can set the CLOCK_REALTIME??

-Rob

In xenomai-2.4-rc4/ksrc/skins/posix/clock.c:

   137  /**
   138   * Set the specified clock.
   139   *
   140   * This allow setting the CLOCK_REALTIME clock.
   141   *
   142   * @param clock_id, the id of the clock to be set, only
CLOCK_REALTIME is
   143   * supported.
   144   *
   145   * @param tp, the address of a struct timespec specifying the new
date.
   146   *
   147   * @retval 0 on success;
   148   * @retval -1 with @a errno set if:
   149   * - EINVAL, @a clock_id is not CLOCK_REALTIME;
   150   * - EINVAL, the date specified by @a tp is invalid.
   151   *
   152   * @see
   153   * <a href="
http://www.opengroup.org/onlinepubs/000095399/functions/clock_settime.html">
   154   * Specification.</a>
   155   *
   156   */
   157  int clock_settime(clockid_t clock_id, const struct timespec *tp)



On 11/9/07, Robert Gubler <rgubler@domain.hid> wrote:
>
> Hello,
>
> I'd like to synchronize CLOCK_REALTIME between some computers that share
> an Ethernet switch.  I am using RTNet as my networking stack.  My approach
> right now is very simplistic.  I have a central server that will be sending
> out one 1 packet per second, with its struct timespec it got as a result of
> calling clock_gettime(CLOCK_REALTIME,...). The computers listening for this
> packet would then call clock_settime(CLOCK_REALTIME,..).
>
> In the Xenomai POSIX skin API doc it says clock_settime() isn't
> supported.  Is there a recommended approach to accomplishing this?   I am
> using Xenomai 2.4-rc4.
>
> -Rob
>

------=_Part_14355_24408297.1194645434718
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

OK, I dug through some code.&nbsp; It looks like it is possible to set CLOCK_REALTIME?&nbsp; I tried to trace clock_settime().&nbsp; There are a bunch of different calls that seem to happen.&nbsp; Some that get translated through syscall.&nbsp; Anyway, I found this, and it seems to suggest that it is possible to set CLOCK_REALTIME.&nbsp; Is the documentation incorrect, or am I tricking myself into thinking I can set the CLOCK_REALTIME??
<br><br>-Rob<br><br>In xenomai-2.4-rc4/ksrc/skins/posix/clock.c:<br><br>&nbsp;&nbsp; 137&nbsp; /**<br>&nbsp;&nbsp; 138&nbsp;&nbsp; * Set the specified clock.<br>&nbsp;&nbsp; 139&nbsp;&nbsp; *<br>&nbsp;&nbsp; 140&nbsp;&nbsp; * This allow setting the CLOCK_REALTIME clock.<br>&nbsp;&nbsp; 141&nbsp;&nbsp; *<br>&nbsp;&nbsp; 142&nbsp;&nbsp; * @param clock_id, the id of the clock to be set, only CLOCK_REALTIME is
<br>&nbsp;&nbsp; 143&nbsp;&nbsp; * supported.<br>&nbsp;&nbsp; 144&nbsp;&nbsp; *<br>&nbsp;&nbsp; 145&nbsp;&nbsp; * @param tp, the address of a struct timespec specifying the new date.<br>&nbsp;&nbsp; 146&nbsp;&nbsp; *<br>&nbsp;&nbsp; 147&nbsp;&nbsp; * @retval 0 on success;<br>&nbsp;&nbsp; 148&nbsp;&nbsp; * @retval -1 with @a errno set if:<br>
&nbsp;&nbsp; 149&nbsp;&nbsp; * - EINVAL, @a clock_id is not CLOCK_REALTIME;<br>&nbsp;&nbsp; 150&nbsp;&nbsp; * - EINVAL, the date specified by @a tp is invalid.<br>&nbsp;&nbsp; 151&nbsp;&nbsp; *<br>&nbsp;&nbsp; 152&nbsp;&nbsp; * @see<br>&nbsp;&nbsp; 153&nbsp;&nbsp; * &lt;a href=&quot;<a href="http://www.opengroup.org/onlinepubs/000095399/functions/clock_settime.html">
http://www.opengroup.org/onlinepubs/000095399/functions/clock_settime.html</a>&quot;&gt;<br>&nbsp;&nbsp; 154&nbsp;&nbsp; * Specification.&lt;/a&gt;<br>&nbsp;&nbsp; 155&nbsp;&nbsp; *<br>&nbsp;&nbsp; 156&nbsp;&nbsp; */<br>&nbsp;&nbsp; 157&nbsp; int clock_settime(clockid_t clock_id, const struct timespec *tp)
<br><br><br><br><div><span class="gmail_quote">On 11/9/07, <b class="gmail_sendername">Robert Gubler</b> &lt;<a href="mailto:rgubler@domain.hid">rgubler@domain.hid</a>&gt; wrote:</span><blockquote class="gmail_quote" style="border-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;">
Hello,<br><br>I&#39;d like to synchronize CLOCK_REALTIME between some computers that share an Ethernet switch.&nbsp; I am using RTNet as my networking stack.&nbsp; My approach right now is very simplistic.&nbsp; I have a central server that will be sending out one 1 packet per second, with its struct timespec it got as a result of calling clock_gettime(CLOCK_REALTIME,...). The computers listening for this packet would then call clock_settime(CLOCK_REALTIME,..).&nbsp; 
<br><br>In the Xenomai POSIX skin API doc it says clock_settime() isn&#39;t supported.&nbsp; Is there a recommended approach to accomplishing this?&nbsp;&nbsp; I am using Xenomai 2.4-rc4.<br><br>-Rob<br>
</blockquote></div><br>

------=_Part_14355_24408297.1194645434718--

