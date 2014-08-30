Message-ID: <540124B3.9000706@xenomai.org>
Date: Sat, 30 Aug 2014 03:11:15 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <CACreCV+9seA7yp8gmjvOb6CQ7-Fbt-HyQ6YAoB_dqtmqmyvy7Q@mail.gmail.com>	<53FDFD27.2010207@xenomai.org>	<CACreCV+cQTO-5iFCCvC15VxNzXuvKkLN+_gUTex-r3Y1cByUkw@mail.gmail.com>	<53FF33CE.10303@xenomai.org>	<D024AFFD.53F9%donald.poole@swri.org>	<CACreCV+8qTgd6y0UuRmMQEhX_mM4PfxP2yjANerZ07SmwkmkEg@mail.gmail.com>	<53FF5B81.7030408@xenomai.org>	<CACreCVJ+2nEakHkkZgL=c+u7rW8S2tY-3qTWyw=AtkCH39n=rw@mail.gmail.com>	<53FF7649.30907@xenomai.org>
 <CACreCVKEyocU22ns2dURJxB-=mhTPqtEw62oEOo+edB4ZLDK9w@mail.gmail.com>
In-Reply-To: <CACreCVKEyocU22ns2dURJxB-=mhTPqtEw62oEOo+edB4ZLDK9w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] ODROID-U3 porting problems
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: GP Orcullo <kinsamanka@gmail.com>
Cc: "xenomai@xenomai.org" <xenomai@xenomai.org>

On 08/30/2014 02:17 AM, GP Orcullo wrote:
> On Fri, Aug 29, 2014 at 2:34 AM, Gilles Chanteperdrix
> <gilles.chanteperdrix@xenomai.org> wrote:
>> On 08/28/2014 07:05 PM, GP Orcullo wrote:
>>> On Fri, Aug 29, 2014 at 12:40 AM, Gilles Chanteperdrix
>>> <gilles.chanteperdrix@xenomai.org> wrote:
>>>> On 08/28/2014 06:34 PM, GP Orcullo wrote:
>>>>> So far it passes all the regression tests except for the switchtest.
>>>>
>>>> What error do you get with switchtest ? If pthread_create fails with
>>>> resource unavailable error, see:
>>>>
>>>> http://xenomai.org/troubleshooting-a-dual-kernel-configuration/#pthread_create_Resource_temporarily_unavailable
>>>>
>>>> If this is another error, please post the error message and kernel log here.
>>>>
>>>> --
>>>>                                                                 Gilles.
>>>
>>> Running "switchtest rtk0" fails with "Xenomai: suspending kernel
>>> thread f00bb710 ('rtk1/0') at 0xc0020c8c after exception #0x0"
>>>
>>> The address is traced to the I-pipe timer interrupt call-back. I think
>>> I maybe missing some spinlocks somewhere.
>>
>> If you are using per-cpu hardware timers, no spinlock is needed, since
>> each cpu accesses its own timer. If you are using the same (hardware)
>> timer on several cpus, then it is not going to work anyway, Xenomai
>> wants one hardware timer per cpu.
>>
>> --
>>                                                                 Gilles.
> 
> I'm using the mct per-cpu hw timers and it's actually similar to
> smp_twd except that the base address is different for each cpu. The
> code where switch test fails is on the tick acknowledgement:
> 
> [  224.612412] Xenomai: suspending kernel thread f00d7710 ('rtk1/3')
> at 0xc0020c8c after exception #0x0
> 
> static void mct_tick_ack(void)
> {
> c0020c6c:       e92d4008        push    {r3, lr}
>         struct mct_clock_event_device *mevt = this_cpu_ptr(&percpu_mct_tick);
> c0020c70:       eb092cf5        bl      c026c04c <debug_smp_processor_id>
> c0020c74:       e3022908        movw    r2, #10504      ; 0x2908
> c0020c78:       e34c2064        movt    r2, #49252      ; 0xc064
> c0020c7c:       e30b3570        movw    r3, #46448      ; 0xb570
> c0020c80:       e34c3061        movt    r3, #49249      ; 0xc061
> 
>         exynos4_mct_write(0x1, mevt->base + MCT_L_INT_CSTAT_OFFSET);
> c0020c84:       e7922100        ldr     r2, [r2, r0, lsl #2]
> c0020c88:       e3a00001        mov     r0, #1
> c0020c8c:       e0823003        add     r3, r2, r3
> c0020c90:       e5931004        ldr     r1, [r3, #4]
> c0020c94:       e2811030        add     r1, r1, #48     ; 0x30
> }
> c0020c98:       e8bd4008        pop     {r3, lr}
> 
> static void mct_tick_ack(void)
> {
>         struct mct_clock_event_device *mevt = this_cpu_ptr(&percpu_mct_tick);
> 
>         exynos4_mct_write(0x1, mevt->base + MCT_L_INT_CSTAT_OFFSET);
> c0020c9c:       eaffff8a        b       c0020acc <exynos4_mct_write>
> 
> 
> Writing to the mct registers is a bit slow I think this is the reason
> why the switch test fails:

No, the problem is using smp_processor_id() over a xenomai kernel
thread, it can not work.

Normally, this should not happen. arch/arm/include/asm/percpu.h defines
__my_cpu_offset not to use smp_processor_id(), so this_cpu_ptr should
not use smp_processor_id. You have to figure out why __my_cpu_offset
does not get defined in arch/arm/include/asm/percpu.h

-- 
                                                                Gilles.

