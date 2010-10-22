Message-ID: <4CC20AD2.4060501@domain.hid>
Date: Sat, 23 Oct 2010 00:06:10 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <AANLkTinN+KBK2B77opSCwDvb9bneObxL1+FTmmwpQGup@domain.hid>
In-Reply-To: <AANLkTinN+KBK2B77opSCwDvb9bneObxL1+FTmmwpQGup@domain.hid>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] Slow hard drive access in xenomai
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

Peter Pastor wrote:
> Hey there,
> 
> I am running xenomai 2.5.4 on linux 2.6.31.4-ipipe. (.config is attached)
> 
> The system is running fairly stable, however, the hard drive access is
> very slow.
> 
> When running
> $ hdparam -tT /dev/sdh
> 
> I get a access rate of around 3mb/s under xenomai. However, when I boot
> the regular ubuntu (non-rt) kernel I get an access rate of about 120mb/s
> 
> I do not really know where to start looking for the cause of this
> problem. I disabled CONFIG_PCI_MSI (see config). Also, i can see that
> IRQ16 is shared between ioc0 (I assume that is my hard drive)

Nope, your hard disk controller is "ahci". The question now is to know
if the configuration with which you have this issue is exactly the same
as the non-RT one, only with Xenomai enabled. If you are in this case,
then please send the two boot logs.

Also, does this happen while running any Xenomai program?
Do you really need things like NUMA, SPARSEMEM, SECCOMP, AUDITSYSCALL,
KPROBES, FTRACE, SELINUX?


-- 
                                                                Gilles.

