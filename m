Subject: Re: x86_64 kernel does not start under qemu
References: <CAFLxGvyyMEJ3t4K3dShxXMZccXCkuLN=bkTaTKLDugMieFD8ZA@mail.gmail.com>
 <73309048-fefd-20a4-31ae-1ce41b0fb8a6@siemens.com>
 <ddd256e9-0e93-30bc-ddf0-e4f333d24d7f@siemens.com>
 <3154485.mhzyMJEECq@blindfold>
From: Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <fc014cdd-e4a8-5363-e68e-adf9b311f8f0@siemens.com>
Date: Thu, 21 Mar 2019 17:07:47 +0100
MIME-Version: 1.0
In-Reply-To: <3154485.mhzyMJEECq@blindfold>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Richard Weinberger <richard@nod.at>, Philippe Gerum <rpm@xenomai.org>
Cc: "henning.schild@siemens.com" <henning.schild@siemens.com>, Lange Norbert <norbert.lange@andritz.com>, "Xenomai (xenomai@xenomai.org)" <xenomai@xenomai.org>

On 21.03.19 12:57, Richard Weinberger wrote:
> Am Donnerstag, 21. März 2019, 12:02:45 CET schrieb Jan Kiszka:
>> FWIW, I've just seen this issue as well, with QEMU in KVM mode: I ran into that
>> lockup when my host was under full load while Xenomai booted in the VM. And it
>> seems reproducible. Debugging...
> 
> Oh, good to hear that!
> I played a little with your config but got badly interrupted with other stuff.
> Your config seems to work but mostly because things are slower due to debugging stuff
> you've enabled. Maybe this info helps.
> 

It's a race, so everything that changes timing also changes
probabilities. I'm starting to nail it down:

(gdb) info threads
  Id   Target Id         Frame 
* 4    Thread 4 (CPU#3 [halted ]) __ipipe_halt_root (use_mwait=-2147483634) at ../arch/x86/kernel/ipipe.c:317
  3    Thread 3 (CPU#2 [running]) rep_nop () at ../arch/x86/include/asm/processor.h:655
  2    Thread 2 (CPU#1 [halted ]) __ipipe_halt_root (use_mwait=-2147483634) at ../arch/x86/kernel/ipipe.c:317
  1    Thread 1 (CPU#0 [halted ]) __ipipe_halt_root (use_mwait=-2147483634) at ../arch/x86/kernel/ipipe.c:317
(gdb) monitor info lapic
dumping local APIC state for CPU 3 

LVT0     0x00010700 active-hi edge  masked                      ExtINT (vec 0)
LVT1     0x00010400 active-hi edge  masked                      NMI   
LVTPC    0x00010400 active-hi edge  masked                      NMI   
LVTERR   0x000000fe active-hi edge                              Fixed  (vec 254)
LVTTHMR  0x00010000 active-hi edge  masked                      Fixed  (vec 0)
LVTT     0x000400ef active-hi edge                 tsc-deadline Fixed  (vec 239)
Timer    DCR=0x0 (divide by 2) initial_count = 0
SPIV     0x000001ff APIC enabled, focus=off, spurious vec 255
ICR      0x000008fd logical edge de-assert no-shorthand
ICR2     0x02000000 mask 00000010 (APIC ID)
ESR      0x00000000
ISR      239 
IRR      236 237 238 239 

APR 0x00 TPR 0x00 DFR 0x0f LDR 0x08 PPR 0xe0


So we are halting while we didn't finish vector 239 (timer) yet. And
that means we re-enabled interrupts while the timer was being processed
- a bug in I-pipe.

This is while another CPU tries to run ipipe_critical_enter, never
reaching CPU 3 this way (via IPI_CRITICAL_VECTOR = 236).

Jan

-- 
Siemens AG, Corporate Technology, CT RDA IOT SES-DE
Corporate Competence Center Embedded Linux

