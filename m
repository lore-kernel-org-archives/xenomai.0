Message-ID: <4B27C8B0.3030902@domain.hid>
Date: Tue, 15 Dec 2009 18:34:40 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <1260281665.792922.9257.nullmailer@domain.hid>	<4B1E6B1B.5080306@domain.hid>	<1260370202.738468.27358.nullmailer@domain.hid>	<4B1FEC63.9070100@domain.hid>	<1260439679.561436.26932.nullmailer@domain.hid>	<4B20E2D7.8060103@domain.hid>
	<4B241D1B.1030002@domain.hid>
In-Reply-To: <4B241D1B.1030002@domain.hid>
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] xenomai 2.4.10 - invalid opcode: 0000
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Petr Cervenka <grugh@domain.hid>
Cc: xenomai-help <xenomai@xenomai.org>

Jan Kiszka wrote:
> Jan Kiszka wrote:
>> ...
>> Reproducible with your .config under kvm, will investigate later.
>>
> 
> It looks like we have a problem with CONFIG_PREEMPT on x86-SMP at the
> moment (2.6.30&.31, maybe also older kernels). You may try with
> CONFIG_PREEMPT_VOLUNTARY/NONE, but I can't promise that this heals the
> issue, maybe it just makes it far less probable.
> 
> The corruption is easy to reproduce - but always at different spots,
> thus it's very hard to catch. Still investigating.
> 

I think I found all gremlins, the last one [1] was probably the major
contributor. Could you try if the patches in [2] help you? Works for me
so far.

Jan

[1]http://permalink.gmane.org/gmane.linux.kernel.adeos.general/1491
[2]http://git.kiszka.org/?p=ipipe-2.6.git;a=shortlog;h=refs/heads/queues/2.6.31-x86

-- 
Siemens AG, Corporate Technology, CT T DE IT 1
Corporate Competence Center Embedded Linux

