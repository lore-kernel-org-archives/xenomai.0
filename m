From: Philippe Gerum <rpm@xenomai.org>
In-Reply-To: <AANLkTi=6d4sZN11G0TfDXZPfwS8dDkhgE=LjnGcS4AG1@domain.hid>
References: <AANLkTi=6d4sZN11G0TfDXZPfwS8dDkhgE=LjnGcS4AG1@domain.hid>
Content-Type: text/plain; charset="UTF-8"
Date: Sat, 09 Oct 2010 10:03:52 +0200
Message-ID: <1286611432.13186.200.camel@domain.hid>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] Xenomai and PEAK can bus card problem
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Peter Pastor <peter.pastor@domain.hid>
Cc: xenomai@xenomai.org

On Fri, 2010-10-08 at 23:44 -0700, Peter Pastor wrote:
> Hey there,
> 
> I installed Xenomai 2.5.2 with Linux 2.6.31.4 kernel (ubuntu 9.10).
> Everything seemed to work just fine. However, after inserting the PEAK
> PCI can bus card the Xenomai kernel stopped booting while normal
> kernels (non-xenomai) still boot.
> 
> I am running a 64 bit dell precision workstation (T7500) with 8 cores
> and a NVIDIA 4800 FX. The attached text file contains the output of
> lspci -vvv -nn. 
> 
> I followed the install instruction for Xenomai 2.5.2 as posted here
> http://wiki.barrett.com/support/wiki/InstallXenomai25
> 
> Unfortunately, I have no idea how to debug this problem. I have the
> "feeling" that it has to do with the APIC and the way interrupts are
> assigned.
> 
> Attached is also 2 syslogs of failed boots. I really hope that someone
> can make sense out of them or at least can give me some hints on how
> to trace down the problem.

Your .config would be valuable as well.

Try disabling CONFIG_PCI_MSI if it is present.

> 
> I recompiled Xenomai with linux 2.6.31.8 with the adeos patch provided
> by Xenomai, but still, I got the same trouble.
> 
> Thanks,
>  peter
> _______________________________________________
> Xenomai-help mailing list
> Xenomai-help@domain.hid
> https://mail.gna.org/listinfo/xenomai-help

-- 
Philippe.



