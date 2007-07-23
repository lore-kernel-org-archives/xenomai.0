Message-ID: <2ff1a98a0707230117n6407f270o9f58f44eeb4f9d9d@domain.hid>
Date: Mon, 23 Jul 2007 10:17:42 +0200
From: "Gilles Chanteperdrix" <gilles.chanteperdrix@xenomai.org>
In-Reply-To: <2862c2c80707230104y5e5c9cc0v8038458e8bcc5f1c@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <2862c2c80707222152t2037a987mca3f70d1da9865dd@domain.hid>
	<18084.23878.661537.272573@domain.hid>
	<2862c2c80707230104y5e5c9cc0v8038458e8bcc5f1c@domain.hid>
Subject: Re: [Xenomai-help] Xenomai Testsuite for AT91 - Illegal Instruction
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Yeoh Chun Yeow <yeohchunyeow@domain.hid>
Cc: "Xenomai-help@domain.hid" <xenomai@xenomai.org>

On 7/23/07, Yeoh Chun Yeow <yeohchunyeow@domain.hid> wrote:
> Dear Gilles,
>
> The same problem still occurs. Here is the /proc/xenomai/faults output:
>
> [root@domain.hid]
> cat /proc/xenomai/faults
> TRAP         CPU0
>   0:            0    (Data or instruction access)
>   1:            0    (Section fault)
>   2:            0    (Generic data abort)
>   3:            0    (Unknown exception)
>   4:            0    (Instruction breakpoint)
>   5:            0    (Floating point exception)
>   6:            0    (VFP Floating point exception)
>   7:            0    (Undefined instruction)
>
> Any ideas?

Did you compile Xenomai as module or in the kernel ? If compiled as
module, are the module loaded ? If yes, then try running your test
inside gdb to know which instruction triggers this error message.

-- 
                                               Gilles Chanteperdrix

