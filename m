Message-ID: <44465782.6090102@domain.hid>
Date: Wed, 19 Apr 2006 11:30:10 -0400
From: Sean McGranaghan <smm@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-help] Where did my interrupts go?
References: <444502A6.7020402@domain.hid> <44451CF9.8020201@domain.hid>
In-Reply-To: <44451CF9.8020201@domain.hid>
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
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

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
  <meta content="text/html;charset=ISO-8859-1" http-equiv="Content-Type">
</head>
<body bgcolor="#ffffff" text="#000000">
<big><tt><font size="-1"><big>Hello Jan,<br>
<br>
Comments are inline below...<br>
<br>
FYI - I now have two Pentium II machines exhibiting the same behavior.
Both are configured with a vanilla 2.6.16.5 kernel with Xenomai trunk
snapshot. (Rev 941). One machine has the local APIC enabled in the
kernel, one does not. Xenomai user space is configured with
--enable-x86-tsc and --enable-x86-sep.<br>
<br>
</big></font><small>Thanks,<br>
Sean</small></tt></big><br>
<br>
Jan Kiszka wrote:
<blockquote cite="mid44451CF9.8020201@domain.hid" type="cite">
  <pre wrap="">Sean McGranaghan wrote:
  </pre>
  <blockquote type="cite">
    <pre wrap="">Hello all,

I have been writing an RTDM driver for an ISA (PC/104) based DAQ board. I had 
the initial driver working under a very old trunk snapshot (Rev 464). This 
morning I upgraded to the latest trunk. I put a few small fixes into my driver 
and test application to take care of some deprecated functions and constants. 
(rt_queue_recv() and RT_IRQ_ENABLED). It appears that my driver is no longer 
receiving interrupts. I can see the irq line go active on the oscilloscope but 
it is never cleared and it appears my interrupt handler is never called.

I ran the test suite including xeno-test with no problems. Attached are output 
files from dmesg, xeno-config and xeno-test outputs. My kernel config file is 
also attached.

At this point I think I need to turn on some debugging in the kernel. Which 
debug options would be appropriate here?.

    </pre>
  </blockquote>
  <pre wrap=""><!---->
First of all, what does /proc/xenomai/irq tell you about your DAQ IRQ?
Is it registered correctly? Are there any arrivals noted?

  </pre>
</blockquote>
<big><tt><small>The counters in /proc/xenomai/irq do not appear to be
incrementing. I can see my irq number allocated while the device is
open, and removed when the device is closed. The interrupt number does
not increment.<br>
<br>
Also, the oscilloscope shows the interrupt going active (hi) but never
in-active (lo). Is it never acknowledged via IPIPE or Linux?<br>
</small></tt></big>
<blockquote cite="mid44451CF9.8020201@domain.hid" type="cite">
  <pre wrap="">Then double-check if you pass the correct code on return from the IRQ
handler: either RTDM_IRQ_HANDLED (if that IRQ was for you - standard),
or RTDM_IRQ_NONE. Nothing else (RT_IRQ_ENABLE is "native stuff", i.e.
violates the rule to keep your driver clean from non-RTDM APIs).

  </pre>
</blockquote>
<tt>I verified that I am returning RTDM_IRQ_HANDLED.</tt><br>
<blockquote cite="mid44451CF9.8020201@domain.hid" type="cite">
  <pre wrap="">Regarding debugging options: CONFIG_XENO_OPT_DEBUG_RTDM is highly
recommended for drivers under development.

  </pre>
</blockquote>
<tt>Now enabled.</tt><br>
<blockquote cite="mid44451CF9.8020201@domain.hid" type="cite">
  <pre wrap="">Jan

  </pre>
</blockquote>
</body>
</html>

