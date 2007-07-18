MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <18077.46993.931365.886132@domain.hid>
Date: Wed, 18 Jul 2007 08:47:45 +0200
In-Reply-To: <760425846A1BC44B8BD24361EF2E3451A69749@domain.hid>
References: <760425846A1BC44B8BD24361EF2E3451A69749@domain.hid>
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Subject: Re: [Xenomai-help] Writing from user space direct to IO Ports
	without	mode switches
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Renner Johannes <rennj1@domain.hid>
Cc: xenomai@xenomai.org

Renner Johannes wrote:
 > Hello everyone,
 > 
 > The outb functions to control parallel ports in my user mode RT task
 > causing inacceptable jitter and make the task unstable(-110) at
 > higher(10khz) output frequencies. I believe this is due to mode
 > switches form Primary to the Secondary mode.

You "believe" ?! You can check what happens using the same method as
ksrc/skins/native/snippets/sigxcpu.c


 >  I tried to access the
 > ports via /dev/mem and mmap() (method from
 > xenomai/examples/common/hw_direct_io.c) but thus mapping is
 > successful, writing -whatever- to the mapped pointer does not set any
 > IO's on my x86.

memory mapped I/O and inb/outb belong to different spaces.

  I have read that some Xenomai RT testing with the
 > Parallel port at frequencies above 200khz showed excellent
 > results. Which functions are used for such precise timings and are
 > they only available in kernel space?

Most functions available in kernel-space are available in
user-space. Check the API documentation.


 > 
 > Thanks in advance 
 > 
 > Johannes
 > <!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 3.2//EN">
 > <HTML>
 > <HEAD>
 > <META HTTP-EQUIV="Content-Type" CONTENT="text/html; charset=iso-8859-1">
 > <META NAME="Generator" CONTENT="MS Exchange Server version 6.5.7652.24">
 > <TITLE>Writing from user space direct to IO Ports without mode switches</TITLE>
 > </HEAD>
 > <BODY>
 > <!-- Converted from text/plain format -->
 > 
 > <P><FONT SIZE=2>Hello everyone,<BR>
 > <BR>
 > The outb functions to control parallel ports in my user mode RT task causing inacceptable jitter and make the task unstable(-110) at higher(10khz) output frequencies. I believe this is due to mode switches form Primary to the Secondary mode.<BR>
 > I tried to access the ports via /dev/mem and mmap() (method from xenomai/examples/common/hw_direct_io.c) but thus mapping is successful, writing -whatever- to the mapped pointer does not set any IO's on my x86.<BR>
 > I have read that some Xenomai RT testing with the Parallel port at frequencies above 200khz showed excellent results. Which functions are used for such precise timings and are they only available in kernel space?<BR>
 > <BR>
 > Thanks in advance<BR>
 > <BR>
 > Johannes</FONT>
 > </P>
 > 
 > </BODY>
 > </HTML>

Please no html.

-- 


					    Gilles Chanteperdrix.

