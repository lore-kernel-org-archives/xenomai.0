Date: Sat, 29 Dec 2012 19:06:27 +0100
From: "Mariusz Janiak" <mariuszjaniak@wp.pl>
Message-ID: <50df3123b46035.85423200@wp.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-2"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
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
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: Xenomai <xenomai@xenomai.org>

Dnia Sobota, 29 Grudnia 2012 17:51 Gilles Chanteperdrix <gilles.chanteperdr=
ix@xenomai.org> napisa=B3(a)=20
> On 12/28/2012 11:06 AM, Mariusz Janiak wrote:
>=20
> >    If you find useful please add bellow text to the TROUBLESHOOTING.adoc
> >    file.
> >=20
> >    On AMD x86_64
> >    ^^^^^^^^^^^^^
> >    You will most likely also see the following message:
> >    --------------------------------------------
> >    I-pipe: cannot use LAPIC as a tick device
> >    I-pipe: disable C1E power state in your BIOS
> >    --------------------------------------------
> >    Xenomai sends this message if C1E option is enabled in a BIOS. To fix
> >    this issue please disable C1E support in the BIOS. In some Award BIOS
> >    this option is located in the +Advanced BIOS Features->+ menu (+AMD
> >    C1E Support+).
> >    On some systems, above message may not appear in the system log.
> >    IMPORTANT: Disabling +AMD K8 Cool&Quiet+ option in a BIOS does not
> >    solve the problem.
>=20
>=20
> Hi Mariusz,
>=20
> thanks for the help text. Could you try the following patch=20
> to see if it restores the message?
>=20
> diff --git a/arch/x86/kernel/apic/apic.c b/arch/x86/kernel/apic/apic.c
> index 7f07610..6cc9208 100644
> --- a/arch/x86/kernel/apic/apic.c
> +++ b/arch/x86/kernel/apic/apic.c
> @@ -545,7 +545,8 @@ static void __cpuinit setup_APIC_timer(void)
>  	memcpy(levt, &lapic_clockevent, sizeof(*levt));
>  	levt->cpumask =3D cpumask_of(smp_processor_id());
>  #ifdef CONFIG_IPIPE
> -	if (!(lapic_clockevent.features & CLOCK_EVT_FEAT_DUMMY))
> +	if (!(lapic_clockevent.features & CLOCK_EVT_FEAT_DUMMY)
> +	    && !cpu_has_amd_erratum(amd_erratum_400))
>  		levt->ipipe_timer =3D &__get_cpu_var(lapic_itimer);
>  	else {
>  	       printk(KERN_INFO
>=20
>=20
> --=20
>                                                                 Gilles.

Hi Gilles,

I confirm, the patch solve problem with printing warning messages in a syst=
em log. Executing 'dmesg | grep -i i-pipe' give following results
=20
I-pipe: cannot use LAPIC as a tick device
I-pipe: disable C1E power state in your BIOS
I-pipe: cannot use LAPIC as a tick device
I-pipe: disable C1E power state in your BIOS
I-pipe: cannot use LAPIC as a tick device
I-pipe: disable C1E power state in your BIOS
I-pipe: cannot use LAPIC as a tick device
I-pipe: disable C1E power state in your BIOS
I-pipe: cannot use LAPIC as a tick device
I-pipe: disable C1E power state in your BIOS
I-pipe: cannot use LAPIC as a tick device
I-pipe: disable C1E power state in your BIOS
I-pipe: could not find timer for cpu #1

Mariusz.




