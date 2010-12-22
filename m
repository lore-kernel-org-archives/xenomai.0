Message-ID: <4D127ECE.8040802@domain.hid>
Date: Wed, 22 Dec 2010 23:42:22 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <20101216130423.19383g369jps4nk0@domain.hid>
	<4D0A0615.5080304@domain.hid>
	<20101222120352.14638lyeejpadxy8@domain.hid>
	<20101222161628.168821tlu4jc9wss@domain.hid>
In-Reply-To: <20101222161628.168821tlu4jc9wss@domain.hid>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] Gumstix / RTNET / INT Problem
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Michel He <michel.he@domain.hid>
Cc: xenomai@xenomai.org, "rtnet-users@domain.hid" <rtnet-users@domain.hid>

Michel He wrote:
> So here, I add some debug info:
> 
> <6>[  172.419753] Xenomai: suspending kernel thread bf062500  
> ('rtnet-stack') at 0xbf0ac72c after exception #8

Exception 8 is unaligned access.

> 
> bf062500 u STACK_manager        [rt_loopback]
> 
> Now, let's find 0xbf0ac72c
> 00000000 a tdma_proto.c [tdma]
> bf0abd7c t $a   [tdma]
> bf0abdf4 t $d   [tdma]
> bf0abdf8 t $a   [tdma]
> bf0abee0 t $d   [tdma]
> bf0abee4 t $a   [tdma]
> bf0abfcc t $d   [tdma]
> bf0abfd4 t $a   [tdma]
> bf0ac1fc t $d   [tdma]
> bf0ac208 t $a   [tdma]
> bf0acb28 t $d   [tdma]
> bf0acb40 t $a   [tdma]
> bf0acd70 t $d   [tdma]
> 
> bf0ac72c - bf0abd7c = 9b0
> 
> 
> 0000048c <tdma_packet_rx>:
> ...
>       9b0:	e186200c 	orr	r2, r6, ip

Well, you probably got the result wrong, or maybe you are not
disassembling the module currently running, or maybe the exception
address is off by +/-4. As far as I know, an unaligned access may only
happen when dereferencing a pointer, so the faulting instruction should
be an str, an ldr, an stm or an ldm (or maybe a coprocessor instruction).

ISTR we already saw this issue with RTnet on PXA, look in the archives,
I do not remember if it has been fixed, but I believe so, are you using
the last RTnet release?

> 
> However I have no idea how to correspond the 9b0 to which line of  
> codes from tdma_proto.c ?? Any idea ?

This is a basic GNU binutils question, it has nothing specific to do
with Xenomai or RTnet. If your module is compiled with debug infos, you
can use addr2line or use objdump -S instead of objdump -d.

-- 
                                                                Gilles.

