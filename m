Message-ID: <45014994.2020601@domain.hid>
Date: Fri, 08 Sep 2006 06:44:36 -0400
From: Sean McGranaghan <smm@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-help] Low-level isr in ADEOS/RTDM
References: <45007B5B.9010000@domain.hid> <4500821B.8040703@domain.hid>
In-Reply-To: <4500821B.8040703@domain.hid>
Content-Type: multipart/mixed; boundary="------------000909020400030907030903"
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
--------------000909020400030907030903
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
  <meta content="text/html;charset=ISO-8859-1" http-equiv="Content-Type">
</head>
<body bgcolor="#ffffff" text="#000000">
<font size="-1"><font face="Helvetica, Arial, sans-serif">I will check
out the ipipe tracer first. Didn't know about that. Thanks for the idea.<br>
<br>
Sean<br>
</font></font><br>
Jan Kiszka wrote:
<blockquote cite="mid4500821B.8040703@domain.hid" type="cite">
  <pre wrap="">Sean McGranaghan wrote:
  </pre>
  <blockquote type="cite">
    <pre wrap="">Hello all,

I am having an issue with a "lost" interrupt in an RTDM driver. This is a long 
story so I will try to summarize:

Hardware description -
I have a Geode2 based PC/104 stack with CAN and ADC/DAC cards. The motherboard 
implements a standard XT-PIC in its super io. The system is running Xenomai 
2.2.1 with a Gentoo  Linux 2.6.17 kernel. There are several external devices on 
the CAN bus to load the bus with traffic.

Software description -
I have two RTDM drivers that provide simple ioctl() interfaces to the 
application. One driver supports two CAN controllers. (PCAN/SJA1000. I 
implemented this driver many months before RTCAN was available. Sorry I couldn't 
wait, paying customer and all. ;-)
    </pre>
  </blockquote>
  <pre wrap=""><!---->
Yeah. :)

  </pre>
  <blockquote type="cite">
    <pre wrap="">The other driver supports a ADC/DAQ card. The 
application runs several Xenomai tasks using message queues for communication.

Failure Description -
The application starts. I can see IRQ lines being raised and lowered as 
interrupts are handled. The application runs normally. After about one or two 
minutes depending on the bus load, I "lose" the IRQ15 interrupt. My interrupt 
service routine is never called and the interrupt chain is broken for that 
device. I have traced the IRQ lines from the devices on the oscilloscope and see 
that the IRQ goes high, but is never acknowledged. (See attached. I added labels 
to each trace.) This failure is sporadic and seems to depend on all three 
devices generating interrupts in the system.

Theory -
The interrupt is never acknowledged because the PIC did not notify the processor 
or software never acknowledged the PIC.

Testing approach -
I need to determine if the hardware or software has lost the interrupt. I would 
tend to suspect software first so I decided to start there. I am using the 
parallel port pins as GPIO output and trying to instrument the low-level 
ADEOS/Xenomai interrupt handling. If I catch the interrupt soon enough in the 
interrupt pipeline I can determine that some software issue is preventing my isr 
from running. If no interrupt ever occurs then I can suspect the hardware.

Assumptions -
ADEOS/Xenomai/RTDM catches the interrupt and propagates it to my isr. If my isr 
is the first level interrupt handler I am out of luck.

Any thoughts or suggestions are appreciated.
    </pre>
  </blockquote>
  <pre wrap=""><!---->
Already had a look at the ipipe-tracer?

<a class="moz-txt-link-freetext" href="http://download.gna.org/adeos/patches/v2.6/i386/tracer">http://download.gna.org/adeos/patches/v2.6/i386/tracer</a>

If you can determine the error condition in software, it's easy to
trigger a freeze of the past invoked functions: xntrace_user_freeze. You
can call it from any context, also from user-space. Check
/proc/ipipe/tracer for the output ("frozen") and tunables (specifially
"back_trace_points"). If help on interpreting the result is required,
post it (or relevant excerpts) here.

Jan

  </pre>
</blockquote>
</body>
</html>

--------------000909020400030907030903
Content-Type: text/x-vcard; charset=utf-8;
 name="smm.vcf"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="smm.vcf"

begin:vcard
fn:Sean McGranaghan
n:McGranaghan;Sean
org:The Appcon Group, Inc.
adr;dom:;;97 Ridgeland Rd;Rochester;NY;14623
email;internet:smm@domain.hid
title:Embedded Software Engineer
tel;work:585-427-7830
tel;fax:585-427-2116
x-mozilla-html:TRUE
version:2.1
end:vcard


--------------000909020400030907030903--

