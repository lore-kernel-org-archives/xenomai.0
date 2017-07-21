References: <CAPkX=28=enHRyYSV==7ug49Gm7foPLsV4LorfWcnA8W75yyuPg@mail.gmail.com>
From: Philippe Gerum <rpm@xenomai.org>
Message-ID: <ed6ae28f-1b20-ff6c-c6ea-f5a3bab139c7@xenomai.org>
Date: Fri, 21 Jul 2017 14:53:43 +0200
MIME-Version: 1.0
In-Reply-To: <CAPkX=28=enHRyYSV==7ug49Gm7foPLsV4LorfWcnA8W75yyuPg@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Xenomai] Illegal instruction exception with
 IPIPE_TSC_TYPE_FREERUNNING_ARCH
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: =?UTF-8?B?Vmnhu4d0IEdpYW5nIE5ndXnhu4Vu?= <giangnv.is@gmail.com>, xenomai@xenomai.org

On 07/21/2017 01:59 PM, Việt Giang Nguyễn wrote:
> Good day,
> 
> I'm porting Xenomai to R-Car M2 board, which is Cortex A15.
> 
> *model name: ARMv7 Processor rev 2 (v7l)*
> *BogoMIPS: 20.00*
> *Features: swp half thumb fastmult vfp edsp neon vfpv3 tls vfpv4 idiva
> idivt lpae evtstrm*
> *CPU implementer: 0x41*
> *CPU architecture: 7*
> *CPU variant: 0x3*
> *CPU part: 0xc0f*
> *CPU revision: 2*
> 
> For TSC emulation, I see that's compatible with arm_arch_timer.
> 
> *timer {*
> *    compatible = "arm,armv7-timer";*
> *    ...*
> *};*
> 
> Now, the system can boot normally.
> 
> *[Xenomai] scheduling class idle registered.*
> *[Xenomai] scheduling class rt registered.*
> *I-pipe: head domain Xenomai registered.*
> *[Xenomai] Cobalt v3.0.5 (Sisyphus's Boulder) [DEBUG]*
> 
> However, latency test is failed with "Illegal instruction" exception, that
> happen when CPU jump to 0xffff0f04.
> 
> *Dump of assembler code from 0xffff0f04 to 0xffff0f64:*
> *   0xffff0f04:  mrrc    15, 0, r0, r1, cr14*
> *   0xffff0f08:  bx      lr*
> 
> Which is this line:
> https://git.xenomai.org/ipipe.git/tree/arch/arm/kernel/ipipe_tsc_asm.S?h=ipipe-core-3.10.32-arm-14#n292
> 
> That seams to reading CNTPCT, but now I have no idea why it is failed?

Did you enable the access to the physical counter from user-space?
(ARCH_TIMER_USR_PCT_ACCESS_EN)?

-- 
Philippe.

