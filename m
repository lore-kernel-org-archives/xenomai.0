Message-ID: <1743f3b40809230122u177e9aaeyb0cbc53f81793929@domain.hid>
Date: Tue, 23 Sep 2008 10:22:03 +0200
From: "Antonio Del Cinque" <adelcinque@domain.hid>
In-Reply-To: <0B45E93C5FF65740AEAE690BF3848B7AD38398@domain.hid>
MIME-Version: 1.0
Content-Type: multipart/alternative; 
	boundary="----=_Part_73934_13292152.1222158123368"
References: <0B45E93C5FF65740AEAE690BF3848B7AD38398@domain.hid>
Subject: Re: [Xenomai-help] Interrupt latency questions
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Fillod Stephane <stephane.fillod@domain.hid>
Cc: xenomai@xenomai.org

------=_Part_73934_13292152.1222158123368
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Thank you,
I think your considerations are the right ones.

The DMA controller is not generating any interrupt, so I assume it is not
actually working. I'm trying to verify that the jitter is caused by
cache/TLB misses. I don't have much reference on how to lock the cache, so
I'll just try to have the cache dirty in any other way to see if it causes
the same jitter.

Antonio

On Mon, Sep 22, 2008 at 11:15 AM, Fillod Stephane <
stephane.fillod@domain.hid> wrote:

> Antonio Del Cinque wrote:
> [...]
> >Then I open an ssh connection with the target, and run a "cat /dev/zero
> > file". The target
> >is mounted on an NFS root filesystem, so this generates a high number
> of
> >fast ethernet interrupts. Now the oscilloscope shows 15 uS jitter in
> the worst case,
> >and a visible variance. I would assume this effect as increased max
> latency.
>
> This figure has already been seen with SoC in the range of the e300,
> and sometime worse.
>
> >The ethernet interrupt is handled only in Linux domain by the original
> vanilla handler,
> >but Linux should be stalled/preempted when the timer interrupt occurs.
> So I assume
> >that latency is to be justified by the time it takes to adeos to record
> an
> >ethernet interrupt event in the i-logs when the timer interrupt is
> executing or ready to
> >execute. Is this correct?
>
> Cache miss and TLB miss are also good latency killers.
> To some extent, long DMA transfers can bog down the system bus.
>
> >Is there any way to lower max latency for the timer interrupt?
>
> Has anybody tried to play with cache locking?
>
> --
> Stephane
>

------=_Part_73934_13292152.1222158123368
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

<div dir="ltr">Thank you,<br>I think your considerations are the right ones.<br><br>The DMA controller is not generating any interrupt, so I assume it is not actually working. I&#39;m trying to verify that the jitter is caused by cache/TLB misses. I don&#39;t have much reference on how to lock the cache, so I&#39;ll just try to have the cache dirty in any other way to see if it causes the same jitter.<br>
<br>Antonio<br><br><div class="gmail_quote">On Mon, Sep 22, 2008 at 11:15 AM, Fillod Stephane <span dir="ltr">&lt;<a href="mailto:stephane.fillod@domain.hid">stephane.fillod@domain.hid</a>&gt;</span> wrote:<br><blockquote class="gmail_quote" style="border-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;">
Antonio Del Cinque wrote:<br>
[...]<br>
<div class="Ih2E3d">&gt;Then I open an ssh connection with the target, and run a &quot;cat /dev/zero<br>
&gt; file&quot;. The target<br>
&gt;is mounted on an NFS root filesystem, so this generates a high number<br>
of<br>
&gt;fast ethernet interrupts. Now the oscilloscope shows 15 uS jitter in<br>
the worst case,<br>
&gt;and a visible variance. I would assume this effect as increased max<br>
latency.<br>
<br>
</div>This figure has already been seen with SoC in the range of the e300,<br>
and sometime worse.<br>
<div class="Ih2E3d"><br>
&gt;The ethernet interrupt is handled only in Linux domain by the original<br>
vanilla handler,<br>
&gt;but Linux should be stalled/preempted when the timer interrupt occurs.<br>
So I assume<br>
&gt;that latency is to be justified by the time it takes to adeos to record<br>
an<br>
&gt;ethernet interrupt event in the i-logs when the timer interrupt is<br>
executing or ready to<br>
&gt;execute. Is this correct?<br>
<br>
</div>Cache miss and TLB miss are also good latency killers.<br>
To some extent, long DMA transfers can bog down the system bus.<br>
<div class="Ih2E3d"><br>
&gt;Is there any way to lower max latency for the timer interrupt?<br>
<br>
</div>Has anybody tried to play with cache locking?<br>
<br>
--<br>
<font color="#888888">Stephane<br>
</font></blockquote></div><br></div>

------=_Part_73934_13292152.1222158123368--

