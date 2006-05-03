Message-ID: <4458A59D.4050901@domain.hid>
Date: Wed, 03 May 2006 14:44:13 +0200
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
Subject: Re: [Xenomai-help] Which kernel features to enable/disable?
References: <44589A3E.3020802@domain.hid>
In-Reply-To: <44589A3E.3020802@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Sean McGranaghan <smm@domain.hid>
Cc: xenomai@xenomai.org

Sean McGranaghan wrote:
> Hello all,
> 
> I am configuring a new PC for Xenomai 2.1 with a 2.6.16 kernel. In the 
> past I have always used a vanilla kernel in the default configuration. I 
> was wondering what features are recommended to enable or disable in the 
> default kernel configuration? For example I know to enable the SMI 
> workaround if the chipset supports it.
> 
> What about SMP?

If you have a SMP, HT or multi-core box, Xenomai will support this too 
(HT will introduce additional latency though). If not, well, it will 
still support this, but at the expense of the usual performance 
degradation of enforcing inter-CPU locks uselessly.

> Kernel pre-emption?

No problem.

> Power management ACPI/APM/frequency scaling?
>

Not all ACPI is bad, but you will need to check the options that you 
really need and which don't hurt your setup. Frequency scaling is bad 
for instance. However, you may want to enable ACPI only for the purpose 
of enumerating multiple CPUs if you need to do so for booting (HT comes 
to mind). APM is a no go.

> Or, are all these irrelevant because Xenomai sits ahead of the kernel in 
> the interrupt pipeline?
> 

This is unrelated. The pipeline only affects the dispatching of events 
(e.g. interrupts, faults, special kernel events).

> I had this thought because my new motherboard supports hyper-threading 
> and the vanilla kernel build includes SMP support.
>
> Thanks,
> Sean
> 
> _______________________________________________
> Xenomai-help mailing list
> Xenomai-help@domain.hid
> https://mail.gna.org/listinfo/xenomai-help


-- 

Philippe.

