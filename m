Message-ID: <4050B841.9030902@domain.hid>
Date: Thu, 11 Mar 2004 11:04:33 -0800
From: Paolo Mantegazza <mantegazza@domain.hid>
MIME-Version: 1.0
Subject: Re: [Adeos-main] 260 uSec latency and no idea why
References: <200403110326.33694.roloff@domain.hid>
In-Reply-To: <200403110326.33694.roloff@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: quoted-printable
Sender: adeos-main-admin@domain.hid
Errors-To: adeos-main-admin@domain.hid
List-Help: <mailto:adeos-main-request@domain.hid>
List-Post: <mailto:adeos-main@gna.org>
List-Subscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
List-Id: General discussion about Adeos <adeos-main.gna.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
List-Archive: <https://mail.gna.org/public/adeos-main/>
To: Dirk Roloff <roloff@domain.hid>
Cc: adeos-main@gna.org

Dirk Roloff wrote:
> Hello List,
>=20
> i have a interrupt latency of ~ 260 =B5Sec and i do not know why.
> I am using kernel 2.4.28 + adeos r10
> Have a Celeron 2 GHz. Single CPU with IO-APIC (But tested this also wit=
h noapic boot parameter)
> APM is disabled (The IDLE calls could cause some latency)
> Running in Textmode - so no X is started.
> Having a IDE-Device which dose not use DMA.
> Any more Infos needed ?
>=20
> The results are 4 to 8 =B5Sec latency in the Realtime Domain normaly bu=
t somtimes i see ~260 - 270 =B5Sek.
> The only thing i found in the kernel tree is the prink() funktion which=
 uses some spinlock which disables irq's.
> Could this be the source. Or has anybody a idea where to search deeper =
?
>=20
>=20
> How i mesure the delay: (This is only a test, because i have latency pr=
oblems with an ugly device driver)
>=20
> 1.) Connect pin 9 to 10 of my ParPort. So if i set Pin 10 up it aserts =
a IRQ 7 on Pin 9
> 2.) Write a module to messure the latency.
>=20
> Short description:
>=20
> - creating a proc-fs entry=20
> - create a relatime domain with higher Priority then Linux.
> - in the domain main adeos_virtualize_irq(7, &rt_latency_isr,rt_latency=
_ack, IPIPE_PASS_MASK | IPIPE_HANDLE_MASK );
>=20
> The proc-fs read function i will=20
> {
>     interruptcount=3D0;
>=20
>     adeos_hw_local_irq_save( flags );
>     do_gettimeofday(&tv[0]);
>     outb(0x80,SPPDATAPORT); /* assert the interrupt signal */
>     adeos_hw_local_irq_restore( flags );
>=20
>     while( !interruptcount )
>     {
>             latency_sleep(1);
>                         if(signal_pending(current)) break;
>     }
>=20
>    calc timediff between tv[0] tv[1] tv[2] and tv[3] and give the reslu=
t back
> }
>=20
> in rt_latency_ack,=20
> {
> 	do_gettimeofday(&tv[1]);
> 	return 0;
> }
>=20
> in rt_latency_isr the realtime isr
> {
> 	do_gettimeofday(&tv[2]);
> }
> in the Linux isr
> {
>   do_gettimeofday(&tv[3]);
>   outb(0x00,SPPDATAPORT); /* deassert the interrupt signal */
>   interruptcount++;
> }
>=20

Have you tried using rt_get_cpu_time_ns to avoid mixing up with Linux stu=
ff?
Have you checkd the interrupt level acknolwdge jitter/latency using the=20
calibration tool available in RTAI?
Can you change your code so that it can be used anywhere? In such a case =

it would be simple to run it on a safe machine (e.g. mine) and see if it =

can be repeated, or is machine specific (yours).

Paolo.


