From: Dirk Roloff <roloff@domain.hid>
Date: Thu, 11 Mar 2004 03:26:33 +0100
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
Message-Id: <200403110326.33694.roloff@domain.hid>
Subject: [Adeos-main] 260 uSec latency and no idea why
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
To: adeos-main@gna.org

Hello List,

i have a interrupt latency of ~ 260 =B5Sec and i do not know why.
I am using kernel 2.4.28 + adeos r10
Have a Celeron 2 GHz. Single CPU with IO-APIC (But tested this also with no=
apic boot parameter)
APM is disabled (The IDLE calls could cause some latency)
Running in Textmode - so no X is started.
Having a IDE-Device which dose not use DMA.
Any more Infos needed ?

The results are 4 to 8 =B5Sec latency in the Realtime Domain normaly but so=
mtimes i see ~260 - 270 =B5Sek.
The only thing i found in the kernel tree is the prink() funktion which use=
s some spinlock which disables irq's.
Could this be the source. Or has anybody a idea where to search deeper ?


How i mesure the delay: (This is only a test, because i have latency proble=
ms with an ugly device driver)

1.) Connect pin 9 to 10 of my ParPort. So if i set Pin 10 up it aserts a IR=
Q 7 on Pin 9
2.) Write a module to messure the latency.

Short description:

=2D creating a proc-fs entry=20
=2D create a relatime domain with higher Priority then Linux.
=2D in the domain main adeos_virtualize_irq(7, &rt_latency_isr,rt_latency_a=
ck, IPIPE_PASS_MASK | IPIPE_HANDLE_MASK );

The proc-fs read function i will=20
{
    interruptcount=3D0;

    adeos_hw_local_irq_save( flags );
    do_gettimeofday(&tv[0]);
    outb(0x80,SPPDATAPORT); /* assert the interrupt signal */
    adeos_hw_local_irq_restore( flags );

    while( !interruptcount )
    {
            latency_sleep(1);
                        if(signal_pending(current)) break;
    }

   calc timediff between tv[0] tv[1] tv[2] and tv[3] and give the reslut ba=
ck
}

in rt_latency_ack,=20
{
	do_gettimeofday(&tv[1]);
	return 0;
}

in rt_latency_isr the realtime isr
{
	do_gettimeofday(&tv[2]);
}
in the Linux isr
{
  do_gettimeofday(&tv[3]);
  outb(0x00,SPPDATAPORT); /* deassert the interrupt signal */
  interruptcount++;
}

Could anybody help ?

Thanks=20
Dirk Roloff



