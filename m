Message-ID: <46E15E3B.50706@domain.hid>
Date: Fri, 07 Sep 2007 16:20:43 +0200
From: Patrick <kpa_info@domain.hid>
MIME-Version: 1.0
References: <46DFD2EA.6000202@domain.hid> <46E07430.2060309@domain.hid>
In-Reply-To: <46E07430.2060309@domain.hid>
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] RTDM
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
Cc: Xenomai <xenomai@xenomai.org>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
  <meta content="text/html;charset=ISO-8859-1" http-equiv="Content-Type">
</head>
<body bgcolor="#ffffff" text="#000000">
<div class="moz-text-html" lang="x-western"> <br>
<br>
Jan Kiszka a &eacute;crit&nbsp;:
<blockquote cite="mid:46E07430.2060309@domain.hid" type="cite">
  <pre wrap="">Patrick wrote:
  </pre>
  <blockquote type="cite">
    <pre wrap="">Hy,

I don't understand the difference between rtdm function and standard function.
For exemple what is the diffrence between rtdm_printk and printk 
    </pre>
  </blockquote>
  <pre wrap=""><!---->
Technically? None these days (printk is provided RT-safe by
Adeos/I-pipe), but it documents that the message may be printed from RT
context. And who know if some future RTDM implementation may not have to
differentiate internally again...

  </pre>
  <blockquote type="cite">
    <pre wrap="">or rtdm_malloc 
and malloc ?
    </pre>
  </blockquote>
  <pre wrap=""><!---->
You mean kmalloc (malloc is user space only)? rtdm_malloc provides
memory from a dedicated pool (dedicated to Xenomai, excluding Linux) and
uses a predictable allocator (as long as the memory usage pattern is
predictable). kmalloc is non-deterministic, and is shared with the whole
Linux kernel.
  </pre>
</blockquote>
<pre>Yes I use kmalloc... sorry
So kmalloc and rtdm_kmalloc is exactly the same ?</pre>
<blockquote cite="mid:46E07430.2060309@domain.hid" type="cite">
  <pre wrap="">  </pre>
  <blockquote type="cite">
    <pre wrap="">I am developping an RT driver so I must simply used only functions rtdm ?
    </pre>
  </blockquote>
  <pre wrap=""><!---->
Regarding the two services above: Depends on the context. If they run in
non-RT driver cleanup or device instantiation context, you should
continue to use standard Linux services. Just for usage from RT contexts
(tasks, IRQ handlers (please don't allocate memory in the latter
context, though...)) switch to those RTDM variants.

Jan

  </pre>
</blockquote>
<pre>For IRQ handlers I use the rt_intr_ functions it's not right ? what is the difference between this functions and th rtdm_irq ?

Do you have an simple trivial exemple of rtdm driver with irq ?

Thank's

Patrick
</pre>
</div>
</body>
</html>

