From: Philippe Gerum <rpm@xenomai.org>
In-Reply-To: <15573283.1178627888504.JavaMail.ngmail@domain.hid>
References: <1178627340.5045.3.camel@domain.hid>
	<1178385693.2406.7.camel@domain.hid> <463AE7D3.6030401@domain.hid>
	<24394502.1178264721982.JavaMail.ngmail@domain.hid>
	<13626574.1178266851510.JavaMail.ngmail@domain.hid>
	<1178281223.29093.83.camel@domain.hid>
	<23990358.1178625225906.JavaMail.ngmail@domain.hid>
	<15573283.1178627888504.JavaMail.ngmail@domain.hid>
Content-Type: text/plain
Date: Tue, 08 May 2007 15:37:40 +0200
Message-Id: <1178631460.5045.6.camel@domain.hid>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: Philippe Gerum <philippe.gerum@domain.hid>
Subject: Re: [Xenomai-help] Xenomai and MSI enabled crashes kernel
Reply-To: rpm@xenomai.org
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: "M. Koehrer" <mathias_koehrer@domain.hid>
Cc: xenomai@xenomai.org, jan.kiszka@domain.hid

On Tue, 2007-05-08 at 14:38 +0200, M. Koehrer wrote:
> Hi Philippe,
> 
> perhaps one more information regarding that issue: 
> When I disable SMP, it seems to work fine (APIC and local APIC are enabled).

This should improve things:

--- a/arch/i386/kernel/ipipe.c
+++ b/arch/i386/kernel/ipipe.c
@@ -373,7 +373,7 @@ int fastcall __ipipe_send_ipi (unsigned ipi, cpumask_t cpumask)
        cpu_clear(cpuid,cpumask);

        if (!cpus_empty(cpumask))
-               send_IPI_mask(cpumask,ipi + FIRST_EXTERNAL_VECTOR);
+               send_IPI_mask(cpumask,ipipe_apic_irq_vector(ipi));

        if (self)
                ipipe_trigger_irq(ipi);

-- 
Philippe.



