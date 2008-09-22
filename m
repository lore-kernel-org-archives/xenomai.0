Message-ID: <48D76AC6.6060401@domain.hid>
Date: Mon, 22 Sep 2008 11:52:06 +0200
From: Harco Kuppens <h.kuppens@domain.hid>
MIME-Version: 1.0
References: <48CE8CE7.6030209@domain.hid> <48D177B1.7000009@domain.hid>
	<48D2184F.3000009@domain.hid> <48D34C63.90304@domain.hid>
	<48D3B1F3.1020408@domain.hid> <48D6241A.4090109@domain.hid>
In-Reply-To: <48D6241A.4090109@domain.hid>
Content-Type: multipart/alternative;
	boundary="------------050107010404040902010409"
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
--------------050107010404040902010409
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Jan Kiszka wrote:
>> Thus what does 'acknowledege' exactly mean?
>>     
>
> That the CPU confirms the interrupt controller that it picked up a
> specific IRQ event. Depending on the IRQ type, this triggers various
> activities in the interrupt controller. For some IRQ types, this can
> also be a nop.
>
> Note that the APIC is only one of the countless interrupt controllers in
> this universe, implementing only a few of the possible IRQ types. The
> universe is large, so a lot of very strange interrupt controllers
> exist... ;)
> (You may want to study vanilla Linux genirq code, how it handles all the
> IRQ types - ipipe is a special case, not immediately revealing the hw
> requirements behind it.)
>   
ok,  there is no single answer but it depends on the much differing 
hardware. It is good to keep that  in mind in the future!
 I shall try to look at the genirq code, will also be a good exercise to 
understand the linux kernel code in more detail.

but although the interrupt controller hardware can differ in general the 
following conclusion keeps :

    When you forward the IRQ to Linux, you repy on Linux for
    dealing with the periphery (acking the IRQ there) and the final
    end-of-IRQ signal.

    The shared IRQ handling algorithm is to consult all handlers in a
    loop until they all reported "not for me" in a row.

    Thus for correct handling of shared IRQs, _all_ associate IRQ
    handlers, also
    those in Linux, must have been executed before the EOI can be sent.

    IRQ sharing between deterministic and non-deterministic code (here:
    Xenomai and vanilla Linux) will never work, that's an inherent design
    issue, nothing Xenomai or ipipe-specific.
    (because the handling of the linux interrupt, is in fact executing
    code with none-realtime priority, which will delay the realtime
    system in a unpredicatable way!)


Thanks for all help,
Harco
> Jan
>
>   


--------------050107010404040902010409
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
  <meta content="text/html;charset=ISO-8859-1" http-equiv="Content-Type">
</head>
<body bgcolor="#ffffff" text="#000000">
Jan Kiszka wrote:
<blockquote cite="mid:48D6241A.4090109@domain.hid" type="cite">
  <blockquote type="cite">
    <pre wrap="">
Thus what does 'acknowledege' exactly mean?
    </pre>
  </blockquote>
  <pre wrap=""><!---->
That the CPU confirms the interrupt controller that it picked up a
specific IRQ event. Depending on the IRQ type, this triggers various
activities in the interrupt controller. For some IRQ types, this can
also be a nop.

Note that the APIC is only one of the countless interrupt controllers in
this universe, implementing only a few of the possible IRQ types. The
universe is large, so a lot of very strange interrupt controllers
exist... ;)
(You may want to study vanilla Linux genirq code, how it handles all the
IRQ types - ipipe is a special case, not immediately revealing the hw
requirements behind it.)
  </pre>
</blockquote>
ok,&nbsp; there is no single answer but it depends on the much differing
hardware. It is good to keep that&nbsp; in mind in the future!<br>
&nbsp;I shall try to look at the genirq code, will also be a good exercise
to understand the linux kernel code in more detail.<br>
<br>
but although the interrupt controller hardware can differ in general
the following conclusion keeps :<br>
<br>
<blockquote>When you forward the IRQ to Linux, you repy on Linux for<br>
dealing with the periphery (acking the IRQ there) and the final<br>
end-of-IRQ signal.<br>
  <br>
The shared IRQ handling algorithm is to consult all handlers in a loop
until they all reported "not for me" in a row.<br>
  <br>
Thus for correct handling of shared IRQs, <span
 class="moz-txt-underscore"><span class="moz-txt-tag">_</span>all<span
 class="moz-txt-tag">_</span></span> associate IRQ handlers, also<br>
those in Linux, must have been executed before the EOI can be sent.<br>
  <br>
IRQ sharing between deterministic and non-deterministic code (here:<br>
Xenomai and vanilla Linux) will never work, that's an inherent design<br>
issue, nothing Xenomai or ipipe-specific.<br>
(because the handling of the linux interrupt, is in fact executing code
with none-realtime priority, which will delay the realtime system in a
unpredicatable way!)<br>
  <br>
</blockquote>
<br>
Thanks for all help, <br>
Harco<br>
<blockquote cite="mid:48D6241A.4090109@domain.hid" type="cite">
  <pre wrap="">
Jan

  </pre>
</blockquote>
<br>
</body>
</html>

--------------050107010404040902010409--

