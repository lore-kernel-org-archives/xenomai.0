Message-ID: <50DF3491.1050905@xenomai.org>
Date: Sat, 29 Dec 2012 19:21:05 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <50df3123b46035.85423200@wp.pl>
In-Reply-To: <50df3123b46035.85423200@wp.pl>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Xenomai] Odp: Re: Xenomai 2.6.2 + Kernel 3.5.3 + AMD Phenom II
 X6 1055
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Mariusz Janiak <mariuszjaniak@wp.pl>
Cc: Xenomai <xenomai@xenomai.org>

On 12/29/2012 07:06 PM, Mariusz Janiak wrote:

> Dnia Sobota, 29 Grudnia 2012 17:51 Gilles Chanteperdrix <gilles.chantep=
erdrix@xenomai.org> napisa=C5=82(a)=20
>> On 12/28/2012 11:06 AM, Mariusz Janiak wrote:
>>
>>>    If you find useful please add bellow text to the TROUBLESHOOTING.a=
doc
>>>    file.
>>>
>>>    On AMD x86_64
>>>    ^^^^^^^^^^^^^
>>>    You will most likely also see the following message:
>>>    --------------------------------------------
>>>    I-pipe: cannot use LAPIC as a tick device
>>>    I-pipe: disable C1E power state in your BIOS
>>>    --------------------------------------------
>>>    Xenomai sends this message if C1E option is enabled in a BIOS. To =
fix
>>>    this issue please disable C1E support in the BIOS. In some Award B=
IOS
>>>    this option is located in the +Advanced BIOS Features->+ menu (+AM=
D
>>>    C1E Support+).
>>>    On some systems, above message may not appear in the system log.
>>>    IMPORTANT: Disabling +AMD K8 Cool&Quiet+ option in a BIOS does not=

>>>    solve the problem.
>>
>>
>> Hi Mariusz,
>>
>> thanks for the help text. Could you try the following patch=20
>> to see if it restores the message?
>>
>> diff --git a/arch/x86/kernel/apic/apic.c b/arch/x86/kernel/apic/apic.c=

>> index 7f07610..6cc9208 100644
>> --- a/arch/x86/kernel/apic/apic.c
>> +++ b/arch/x86/kernel/apic/apic.c
>> @@ -545,7 +545,8 @@ static void __cpuinit setup_APIC_timer(void)
>>  	memcpy(levt, &lapic_clockevent, sizeof(*levt));
>>  	levt->cpumask =3D cpumask_of(smp_processor_id());
>>  #ifdef CONFIG_IPIPE
>> -	if (!(lapic_clockevent.features & CLOCK_EVT_FEAT_DUMMY))
>> +	if (!(lapic_clockevent.features & CLOCK_EVT_FEAT_DUMMY)
>> +	    && !cpu_has_amd_erratum(amd_erratum_400))
>>  		levt->ipipe_timer =3D &__get_cpu_var(lapic_itimer);
>>  	else {
>>  	       printk(KERN_INFO
>>
>>
>> --=20
>>                                                                 Gilles=
=2E
>=20
> Hi Gilles,
>=20
> I confirm, the patch solve problem with printing warning messages in a =
system log. Executing 'dmesg | grep -i i-pipe' give following results
> =20
> I-pipe: cannot use LAPIC as a tick device
> I-pipe: disable C1E power state in your BIOS
> I-pipe: cannot use LAPIC as a tick device
> I-pipe: disable C1E power state in your BIOS
> I-pipe: cannot use LAPIC as a tick device
> I-pipe: disable C1E power state in your BIOS
> I-pipe: cannot use LAPIC as a tick device
> I-pipe: disable C1E power state in your BIOS
> I-pipe: cannot use LAPIC as a tick device
> I-pipe: disable C1E power state in your BIOS
> I-pipe: cannot use LAPIC as a tick device
> I-pipe: disable C1E power state in your BIOS
> I-pipe: could not find timer for cpu #1


Not really nice, could you try this one:

diff --git a/arch/x86/kernel/apic/apic.c b/arch/x86/kernel/apic/apic.c
index 7f07610..91531bb 100644
--- a/arch/x86/kernel/apic/apic.c
+++ b/arch/x86/kernel/apic/apic.c
@@ -545,14 +545,18 @@ static void __cpuinit setup_APIC_timer(void)
 	memcpy(levt, &lapic_clockevent, sizeof(*levt));
 	levt->cpumask =3D cpumask_of(smp_processor_id());
 #ifdef CONFIG_IPIPE
-	if (!(lapic_clockevent.features & CLOCK_EVT_FEAT_DUMMY))
+	if (!(lapic_clockevent.features & CLOCK_EVT_FEAT_DUMMY)
+	    && !cpu_has_amd_erratum(amd_erratum_400))
 		levt->ipipe_timer =3D &__get_cpu_var(lapic_itimer);
 	else {
-	       printk(KERN_INFO
-		      "I-pipe: cannot use LAPIC as a tick device\n");
-	       if (cpu_has_amd_erratum(amd_erratum_400))
-		       printk(KERN_INFO
-			      "I-pipe: disable C1E power state in your BIOS\n");
+		static atomic_t printed =3D ATOMIC_INIT(-1);
+		printk(KERN_INFO
+		       "I-pipe: cannot use LAPIC on cpu #%d as a tick device\n",
+		       smp_processor_id());
+		if (cpu_has_amd_erratum(amd_erratum_400)
+		    && atomic_inc_and_test(&printed))
+			printk(KERN_INFO
+			       "I-pipe: disable C1E power state in your BIOS\n");
 	}
 #endif /* CONFIG_IPIPE */
=20

--=20
                                                                Gilles.


