From: Philippe Gerum <rpm@xenomai.org>
In-Reply-To: <4715C70F.4040501@domain.hid>
References: <4705ED3B.4070600@domain.hid>
	<2ff1a98a0710050130j7e0db84dq838aab0417c8bd3f@domain.hid>
	<4705FE04.7000909@domain.hid> <1191576011.20623.114.camel@domain.hid>
	<470611FA.30103@domain.hid> <1191592977.20623.142.camel@domain.hid>
	<470A26BC.506@domain.hid> <1192015852.22917.197.camel@domain.hid>
	<470F7F2E.3020206@domain.hid>  <470F82FF.9020701@domain.hid>
	<1192203284.6499.135.camel@domain.hid>  <470F978B.1000005@domain.hid>
	<1192207431.6499.161.camel@domain.hid>  <4715C70F.4040501@domain.hid>
Content-Type: text/plain
Date: Wed, 17 Oct 2007 10:41:11 +0200
Message-Id: <1192610471.5973.4.camel@domain.hid>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: Philippe Gerum <philippe.gerum@domain.hid>
Subject: Re: [Xenomai-help] awful latencies (~110us)
Reply-To: rpm@xenomai.org
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: CHABAL David <david.chabal@domain.hid>
Cc: xenomai@xenomai.org

On Wed, 2007-10-17 at 10:25 +0200, CHABAL David wrote:

> I met some problems after applying adeos-ipipe-2.6.20-i386-1.10-06.patch
> (sorry, if I post on the wrong mailing-list)
> 

The most recent patch for the 2.6.20 series is 1.10-08.

> 1. entry.S
> ==========
> [root@domain.hid linux-2.6.20]# make
>    CHK     include/linux/version.h
>    CHK     include/linux/utsrelease.h
>    CHK     include/linux/compile.h
> dnsdomainname: Unknown host
>    AS      arch/i386/kernel/entry.o
> arch/i386/kernel/entry.S: Assembler messages:
> arch/i386/kernel/entry.S:307: Error: invalid character '_' in mnemonic
> arch/i386/kernel/entry.S:398: Error: invalid character '_' in mnemonic
> arch/i386/kernel/entry.S:444: Error: invalid character '_' in mnemonic
> arch/i386/kernel/entry.S:536: Error: invalid character '_' in mnemonic
> make[1]: *** [arch/i386/kernel/entry.o] Error 1
> make: *** [arch/i386/kernel] Error 2
> 

Make sure to disable CONFIG_PARAVIRT.

-- 
Philippe.



