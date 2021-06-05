References: <PR3PR02MB620234FC0751074AE334B463D13D9@PR3PR02MB6202.eurprd02.prod.outlook.com>
 <PR3PR02MB62022C741AA5039F06B4E367D13A9@PR3PR02MB6202.eurprd02.prod.outlook.com>
From: Philippe Gerum <rpm@xenomai.org>
Subject: Re: Xenomai ipipe x86 64 bits with 32 bits librairies
In-reply-to: <PR3PR02MB62022C741AA5039F06B4E367D13A9@PR3PR02MB6202.eurprd02.prod.outlook.com>
Date: Sat, 05 Jun 2021 15:15:24 +0200
Message-ID: <87im2sfo5v.fsf@xenomai.org>
MIME-Version: 1.0
Content-Type: text/plain
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: MONTET Julien <julien.montet@reseau.eseo.fr>
Cc: xenomai@xenomai.org


MONTET Julien via Xenomai <xenomai@xenomai.org> writes:

> Hello everyone,
>
> To keep you informed of my progress to run a 32bits program on x86 with Xenomai:
> -> I tried to build 32bits Xenomai library for a 64bits system built with a Cobalt version
> --> It doesn't work and stopped my exec or sudo /usr/xenomai/bin/latency with the error below
> --> 0"000.000| BUG in low_init(): [main] Cobalt core not enabled in kernel
>

You may want to double-check in the kernel log whether the core is
actually enabled. Early init errors might prevent this.

With dmesg, check that you do have an output of this sort:

[    0.098064] [Xenomai] scheduling class idle registered.
[    0.098074] [Xenomai] scheduling class rt registered.
[    0.098258] I-pipe: head domain Xenomai registered.
[    0.100609] [Xenomai] Cobalt v3.1

Any error encountered while initializing the Cobalt core would disable
it entirely for the whole session, hence receiving the low_init() error.

> -> I tried to build 64 bits Xenomai library for 64bits system built with Cobalt version
> --> The code doesn't build because it is waiting for 32bits library (alchemy, ...)
>
> There is still an other possibility I have in mind, but I don't know if it could work properly.
> During the kernel compilation I used "menuconfig" and noticed a line named "Binary Emulations". Inside it I found :
> [*] IA32 Emulation
> < > IA32 a.out support
> [ ] x32 ABI for 64-bit mode
>
> I am tempted to select "IA32 a.out support" and "x32 ABI for 64-bit mode" as well.
> Do these options have an impact on Xenomai or are they only used in a general case ?
>

All you need is CONFIG_IA32_EMULATION=y to enable 32bit user
compatibility mode over the x86_64 kernel.

-- 
Philippe.

