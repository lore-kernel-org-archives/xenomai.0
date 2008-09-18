Message-ID: <48D2184F.3000009@domain.hid>
Date: Thu, 18 Sep 2008 10:58:55 +0200
From: Harco Kuppens <h.kuppens@domain.hid>
MIME-Version: 1.0
References: <48CE8CE7.6030209@domain.hid> <48D177B1.7000009@domain.hid>
In-Reply-To: <48D177B1.7000009@domain.hid>
Content-Type: multipart/alternative;
	boundary="------------070504010208070101030906"
Subject: Re: [Xenomai-help] keyboard interrupt
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
Cc: xenomai@xenomai.org

This is a multi-part message in MIME format.
--------------070504010208070101030906
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Hi Jan,

Thank you for your answer! But I still have some things I do not really 
understand.

In Life with Adeos  
<http://www.xenomai.org/documentation/branches/v2.3.x/pdf/Life-with-Adeos-rev-B.pdf> 
I read :

    The stage of the pipeline occupied by any given domain can be
    stalled, which means that
    the next incoming interrupt will not be delivered to the domain's
    handler, and will be
    prevented from flowing down to the lowest priority domain(s) in the
    same move. While a
    stage is stalled, pending interrupts accumulate in the domain's
    interrupt log, and
    eventually get played when the stage is unstalled, by an internal
    operation called
    synchronization.


and further on :

    When a domain has finished processing all the pending interrupts it
    has received, it then
    calls a special Adeos service which yields the CPU to the next
    domain down the pipeline,
    so the latter can process in turn the pending events it has been
    notified of, and this cycle
    continues down to the lowest priority domain of the pipeline.


So from reading this I would suspect that multiple IRQs could be 
buffered (= interrupt log) between Xenomai and Linux so that Xenomai can 
finish it realtime jobs. Only when xenomai is done with its jobs the 
IRQs from the buffer are passed  to Linux
But from your answer I suspect that it only holds for different IRQs, 
and when an IRQ X is on the pipeline not another newer IRQ X can over 
the pipeline until the first one is dealed with.
Thus when the 'end-of-IRQ' signal is given.
Who however gives this 'end-of-IRQ' signal? linux or the pipeline?
What exactly is this 'end-of-IRQ'  signal? 
Because interrupt are virtualized in the pipeline I would suspect  this 
is something used in the pipeline?



> IRQ sharing between deterministic and non-deterministic code (here:
> Xenomai and vanilla Linux) will never work, that's an inherent design
> issue, nothing Xenomai or ipipe-specific.
>
>   
with inherent design, I would guess you mean the intel hardware design I 
suppose?
but than I would suspect that the 'end-of-IRQ' signal is something in 
the hardware

please help me out this world of confusion :)

cheers
Harco
> Jan
>
>   


--------------070504010208070101030906
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
  <meta content="text/html;charset=ISO-8859-1" http-equiv="Content-Type">
</head>
<body bgcolor="#ffffff" text="#000000">
Hi Jan,<br>
<br>
Thank you for your answer! But I still have some things I do not really
understand.<br>
<br>
In <a
 href="http://www.xenomai.org/documentation/branches/v2.3.x/pdf/Life-with-Adeos-rev-B.pdf"
 class="external text"
 title="http://www.xenomai.org/documentation/branches/v2.3.x/pdf/Life-with-Adeos-rev-B.pdf"
 rel="nofollow">Life with Adeos&nbsp;</a><span class="ft4"> I read :<br>
<br>
</span>
<blockquote><span class="ft4">The stage of the pipeline occupied by any
given domain can be stalled, which means that</span><br>
  <span class="ft4">the next incoming interrupt will not be delivered
to the domain's handler, and will be</span><br>
  <span class="ft4">prevented from flowing down to the lowest priority
domain(s) in the same move. While a</span><br>
  <span class="ft4">stage is stalled, pending interrupts accumulate in
the domain's interrupt log, and</span><br>
  <span class="ft4">eventually get played when the stage is unstalled,
by an internal operation called</span><br>
  <span class="ft4">synchronization.<br>
  <br>
  </span></blockquote>
<span class="ft4"></span><br>
<span class="ft4"></span>and further on :<br>
<br>
<blockquote><span class="ft4">When a domain has finished processing all
the pending interrupts it has received, it then</span><br>
  <span class="ft4">calls a special Adeos service which yields the CPU
to the next domain
down the pipeline,</span><br>
  <span class="ft4">so the latter can process in turn the pending
events it has been
notified of, and this cycle</span><br>
  <span class="ft4"> </span><span class="ft6">continues down to the
lowest priority domain
of the pipeline.</span><br>
  <span class="ft6"></span></blockquote>
<span class="ft6"> </span><br>
So from reading this I would suspect that multiple IRQs could be
buffered (=<span class="ft4"> interrupt log)</span> between Xenomai and
Linux so that Xenomai can finish it realtime jobs. Only when xenomai is
done with its jobs the IRQs from the buffer are passed&nbsp; to Linux<br>
But from your answer I suspect that it only holds for different IRQs,
and when an IRQ X is on the pipeline not another newer IRQ X can over
the pipeline until the first one is dealed with.<br>
Thus when the 'end-of-IRQ' signal is given. <br>
Who however gives this 'end-of-IRQ' signal? linux or the pipeline?<br>
What exactly is this 'end-of-IRQ'&nbsp; signal?&nbsp; <br>
Because interrupt are virtualized in the pipeline I would suspect&nbsp; this
is something used in the pipeline?<br>
<br>
<br>
<br>
<blockquote cite="mid:48D177B1.7000009@domain.hid" type="cite">
  <pre wrap="">
IRQ sharing between deterministic and non-deterministic code (here:
Xenomai and vanilla Linux) will never work, that's an inherent design
issue, nothing Xenomai or ipipe-specific.

  </pre>
</blockquote>
with inherent design, I would guess you mean the intel hardware design
I suppose?<br>
but than I would suspect that the 'end-of-IRQ' signal is something in
the hardware <br>
<br>
please help me out this world of confusion :)<br>
<br>
cheers<br>
Harco<br>
<blockquote cite="mid:48D177B1.7000009@domain.hid" type="cite">
  <pre wrap="">Jan

  </pre>
</blockquote>
<br>
</body>
</html>

--------------070504010208070101030906--

