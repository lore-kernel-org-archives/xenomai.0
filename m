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
Date: Tue, 08 May 2007 15:28:53 +0200
Message-Id: <1178630933.5045.4.camel@domain.hid>
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

This sounds reasonable, since IPIs are SMP specific.

> 
> Regards
> 
> Mathias
> 
> > > as mentioned in my previous mail, the new patch works fine. However, I get
> > the error
> > > APIC error on CPU0: 00(20)
> > > APIC error on CPU1: 00(40)
> > > when unloading (rmmod) xeno_native.
> > > I have looked closed to that issue and I have found out that this happens
> > > within the inline function xnarch_notify_halt() (file pod.h)
> > > 
> > >     for(cpu=0; cpu < nr_cpus-1; ++cpu)
> > >         down(&xnarch_finalize_sync);
> > > 
> > 
> > It's likely happening a few lines earlier, when sending IPI2 to
> > synchronize all CPUs during Xenomai shutdown. Ok, I will have a look
> > asap.
> > 
> 
> 
-- 
Philippe.



