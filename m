Date: Fri, 22 Jun 2007 00:54:48 -0700 (PDT)
From: poornima r <rpoornar@domain.hid>
In-Reply-To: <1182434536.9709.62.camel@domain.hid>
MIME-Version: 1.0
Content-Type: multipart/alternative; boundary="0-1346712100-1182498888=:58719"
Content-Transfer-Encoding: 8bit
Message-ID: <487617.58719.qm@domain.hid>
Subject: Re: [Adeos-main] Domain switching latencies
List-Id: General discussion about Adeos <adeos-main.gna.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
List-Archive: </public/adeos-main>
List-Post: <mailto:adeos-main@gna.org>
List-Help: <mailto:adeos-main-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
To: rpm@xenomai.org
Cc: adeos-main@gna.org, wg@domain.hid

--0-1346712100-1182498888=:58719
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit

Hello Philippe,
   
  Thanks very much for the reply.
   
  Thanks and Regards,
  Poornima
  

Philippe Gerum <rpm@xenomai.org> wrote:
  On Thu, 2007-06-21 at 05:59 -0700, poornima r wrote:
> 
> We are very thankful to you for providing help and
> guidance in running latency testsuites and other
> assignments 
> We are trying to measure context switching latencies
> between primary and secondary domains with changes in
> the
> latency code as specified in the below link
> http://www.mail-archive.com/xenomai@xenomai.org
> 
> The following changes are done in the latency code and
> the applications are attached
> -------------------------------------------------------
> 1:Measured using linux call printf
> err = rt_task_wait_period(&ov);
> before = rt_timer_tsc();
> printf(" ");

You are measuring time for buffered I/O operations, so your measure is
fundamentally flawed, since this jump won't ever jump to kernel space
unless the buffer gets full once in a while, and the stdio layer has to
sync. At the very least, switch buffering off using setbuf(), give a
newline into the string (depends on underlying termio setup in effect,
so this is unreliable) or simply invoke an actual system call, like
getpgrp() or getppid (and _not_ getpid() which is optimized using direct
fetches from PTDs).

> after = rt_timer_tsc();
> dt = (long)(after - before);
> --------------------------------------------------------
> 2. Measure using Native API call
> err = rt_task_wait_period(&ov);
> before = rt_timer_tsc();
> rt_task_set_mode (T_PRIMARY, NULL, NULL);
> after = rt_timer_tsc();
> dt = (long)(after - before);
> ---------------------------------------------------------
> The worst case latencies was around 20 us using printf
> call and around 60 us when rt_task_set_mode was called
> 
-- 
Philippe.




       
---------------------------------
Got a little couch potato? 
Check out fun summer activities for kids.
--0-1346712100-1182498888=:58719
Content-Type: text/html; charset=iso-8859-1
Content-Transfer-Encoding: 8bit

<div>Hello Philippe,</div>  <div>&nbsp;</div>  <div>Thanks very much for the reply.</div>  <div>&nbsp;</div>  <div>Thanks and Regards,</div>  <div>Poornima</div>  <div><BR><BR><B><I>Philippe Gerum &lt;rpm@xenomai.org&gt;</I></B> wrote:</div>  <BLOCKQUOTE class=replbq style="PADDING-LEFT: 5px; MARGIN-LEFT: 5px; BORDER-LEFT: #1010ff 2px solid">On Thu, 2007-06-21 at 05:59 -0700, poornima r wrote:<BR>&gt; <BR>&gt; We are very thankful to you for providing help and<BR>&gt; guidance in running latency testsuites and other<BR>&gt; assignments <BR>&gt; We are trying to measure context switching latencies<BR>&gt; between primary and secondary domains with changes in<BR>&gt; the<BR>&gt; latency code as specified in the below link<BR>&gt; http://www.mail-archive.com/xenomai@xenomai.org<BR>&gt; <BR>&gt; The following changes are done in the latency code and<BR>&gt; the applications are attached<BR>&gt; -------------------------------------------------------<BR>&gt;
 1:Measured using linux call printf<BR>&gt; err = rt_task_wait_period(&amp;ov);<BR>&gt; before = rt_timer_tsc();<BR>&gt; printf(" ");<BR><BR>You are measuring time for buffered I/O operations, so your measure is<BR>fundamentally flawed, since this jump won't ever jump to kernel space<BR>unless the buffer gets full once in a while, and the stdio layer has to<BR>sync. At the very least, switch buffering off using setbuf(), give a<BR>newline into the string (depends on underlying termio setup in effect,<BR>so this is unreliable) or simply invoke an actual system call, like<BR>getpgrp() or getppid (and _not_ getpid() which is optimized using direct<BR>fetches from PTDs).<BR><BR>&gt; after = rt_timer_tsc();<BR>&gt; dt = (long)(after - before);<BR>&gt; --------------------------------------------------------<BR>&gt; 2. Measure using Native API call<BR>&gt; err = rt_task_wait_period(&amp;ov);<BR>&gt; before = rt_timer_tsc();<BR>&gt; rt_task_set_mode (T_PRIMARY, NULL,
 NULL);<BR>&gt; after = rt_timer_tsc();<BR>&gt; dt = (long)(after - before);<BR>&gt; ---------------------------------------------------------<BR>&gt; The worst case latencies was around 20 us using printf<BR>&gt; call and around 60 us when rt_task_set_mode was called<BR>&gt; <BR>-- <BR>Philippe.<BR><BR><BR></BLOCKQUOTE><BR><p>&#32;
      <hr size=1>Got a little couch potato? <br>
Check out fun <a href="http://us.rd.yahoo.com/evt=48248/*http://search.yahoo.com/search?fr=oni_on_mail&p=summer+activities+for+kids&cs=bz">summer activities for kids.</a>
--0-1346712100-1182498888=:58719--

