Message-ID: <51650E75.2090503@web.de>
Date: Wed, 10 Apr 2013 09:02:13 +0200
From: Jan Kiszka <jan.kiszka@web.de>
MIME-Version: 1.0
References: <511CD2FB.7010502@gmail.com>
	<511DDBD5.4060505@web.de>	<51236088.1030402@gmail.com>
	<51236A75.5090400@siemens.com>	<5123C910.7090107@siemens.com>
	<5123DDBE.8060105@web.de>	<512778A0.6090300@gmail.com>
	<51277B66.60505@siemens.com>	<512B9A86.4060900@siemens.com>
	<512BB672.7080900@control.lth.se>	<512BB714.6080707@siemens.com>	<512BC4E2.4020605@control.lth.se>
	<512BDF7F.3030005@web.de>	<51308DC2.7040000@gmail.com>
	<5130B1AC.1090300@siemens.com> <516491AF.2080808@xenomai.org>
In-Reply-To: <516491AF.2080808@xenomai.org>
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Xenomai] (Boot)-problems with (current) ipipe patch on AMD FX
 61000 - 2.6.38.8 & 3.5.7
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: Manuel Huber <manuel.h87@gmail.com>, xenomai@xenomai.org

On 2013-04-10 00:09, Gilles Chanteperdrix wrote:
> On 03/01/2013 02:48 PM, Jan Kiszka wrote:
> =

>> On 2013-03-01 12:15, Manuel Huber wrote:
>>> On 2013-02-25 23:02, Jan Kiszka wrote:
>>>> On 2013-02-25 21:09, Anders Blomdell wrote:
>>>>> On 2013-02-25 20:10, Jan Kiszka wrote:
>>>>>> On 2013-02-25 20:07, Anders Blomdell wrote:
>>>>>>> On 2013-02-25 18:08, Jan Kiszka wrote:
>>>>>>>> As 3.5 is dead, this fix will never make it there unless we
>>>>>>>> back-port.
>>>>>>>> While I'm doing this, could you try if
>>>>>>>>
>>>>>>>>        git://git.xenomai.org/ipipe-jki.git for-upstream/master
>>>>>>> I'm probably more stupid than normal (i.e I can't find any ipipe for
>>>>>>> x86_64):
>>>>>>>
>>>>>>> # git clone git://git.xenomai.org/ipipe-jki.git for-upstream/master
>>>>>> git clone git://git.xenomai.org/ipipe-jki.git
>>>>>> git checkout -b for-upstream/master origin/for-upstream/master
>>>>> OK, thanks. Do I need to setup xenomai in order to gain any useful
>>>>> information, or is:
>>>>>
>>>>> CONFIG_IPIPE=3Dy
>>>>> CONFIG_IPIPE_LEGACY=3Dy
>>>>> CONFIG_IPIPE_CORE=3Dy
>>>>> CONFIG_IPIPE_CORE_APIREV=3D2
>>>>> CONFIG_IPIPE_TARGET_APIREV=3D1
>>>>> CONFIG_IPIPE_HAVE_HOSTRT=3Dy
>>>>> CONFIG_IPIPE_DELAYED_ATOMICSW=3Dy
>>>>> # CONFIG_IPIPE_DEBUG is not set
>>>>>
>>>>> sufficient?
>>>> Plain I-pipe will suffice as the the interrupt virtualization is
>>>> unconditional, thus __ipipe_handle_irq is always taken.
>>>>
>>>> Alternatively, here is the backported patch over 3.5.7:
>>>>
>>>> diff --git a/arch/x86/kernel/apic/io_apic.c
>>>> b/arch/x86/kernel/apic/io_apic.c
>>>> index 08e5ad4..aade7f0 100644
>>>> --- a/arch/x86/kernel/apic/io_apic.c
>>>> +++ b/arch/x86/kernel/apic/io_apic.c
>>>> @@ -234,11 +234,11 @@ int __init arch_early_irq_init(void)
>>>>           zalloc_cpumask_var_node(&cfg[i].old_domain, GFP_KERNEL, node=
);
>>>>           /*
>>>>            * For legacy IRQ's, start with assigning irq0 to irq15 to
>>>> -         * IRQ0_VECTOR to IRQ15_VECTOR on cpu 0.
>>>> +         * IRQ0_VECTOR to IRQ15_VECTOR for all cpu's.
>>>>            */
>>>>           if (i < legacy_pic->nr_legacy_irqs) {
>>>>               cfg[i].vector =3D IRQ0_VECTOR + i;
>>>> -            cpumask_set_cpu(0, cfg[i].domain);
>>>> +            cpumask_setall(cfg[i].domain);
>>>>           }
>>>>       }
>>>>   @@ -1181,8 +1181,9 @@ next:
>>>>           current_vector =3D vector;
>>>>           current_offset =3D offset;
>>>>           if (old_vector) {
>>>> -            cfg->move_in_progress =3D 1;
>>>>               cpumask_copy(cfg->old_domain, cfg->domain);
>>>> +            cfg->move_in_progress =3D
>>>> +               cpumask_intersects(cfg->old_domain, cpu_online_mask);
>>>>           }
>>>>           for_each_cpu_and(new_cpu, tmp_mask, cpu_online_mask)
>>>>               per_cpu(vector_irq, new_cpu)[vector] =3D irq;
>>>> @@ -1250,12 +1251,6 @@ void __setup_vector_irq(int cpu)
>>>>           cfg =3D irq_get_chip_data(irq);
>>>>           if (!cfg)
>>>>               continue;
>>>> -        /*
>>>> -         * If it is a legacy IRQ handled by the legacy PIC, this cpu
>>>> -         * will be part of the irq_cfg's domain.
>>>> -         */
>>>> -        if (irq < legacy_pic->nr_legacy_irqs && !IO_APIC_IRQ(irq))
>>>> -            cpumask_set_cpu(cpu, cfg->domain);
>>>>             if (!cpumask_test_cpu(cpu, cfg->domain))
>>>>               continue;
>>>> @@ -1380,13 +1375,6 @@ static void setup_ioapic_irq(unsigned int irq,
>>>> struct irq_cfg *cfg,
>>>>         if (!IO_APIC_IRQ(irq))
>>>>           return;
>>>> -    /*
>>>> -     * For legacy irqs, cfg->domain starts with cpu 0 for legacy
>>>> -     * controllers like 8259. Now that IO-APIC can handle this irq,
>>>> update
>>>> -     * the cfg->domain.
>>>> -     */
>>>> -    if (irq < legacy_pic->nr_legacy_irqs && cpumask_test_cpu(0,
>>>> cfg->domain))
>>>> -        apic->vector_allocation_domain(0, cfg->domain);
>>>>         if (assign_irq_vector(irq, cfg, apic->target_cpus()))
>>>>           return;
>>>>
>>>>
>>>> Jan
>>>>
>>>>
>>> Hey!
>>>
>>> I applied your patch and rebooted several times with and without serial
>>> console and it seems to have finally fixed the problem (but I've said
>>> that a lot recently... sorry again...). I've also tried the version of
>>> your branch and it compiled and booted.
>>
>> OK, perfect. Will send a pull request for I-pipe 3.5.7 to push this fix
>> upstream.
> =

> =

> Hi Jan,
> =

> did this patch make it to one of the branches in the ipipe-jki repository?

It's contained in both for-upstream/master and for-upstream/3.5, for a
long time.

Jan


-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 263 bytes
Desc: OpenPGP digital signature
URL: <http://www.xenomai.org/pipermail/xenomai/attachments/20130410/a476e6a=
1/attachment.pgp>
