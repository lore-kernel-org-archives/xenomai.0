Message-ID: <4C0FA7E6.3060806@domain.hid>
Date: Wed, 09 Jun 2010 16:40:38 +0200
From: Daniele Nicolodi <daniele@domain.hid>
MIME-Version: 1.0
References: <4C04E8D8.8030101@domain.hid>	<4C04EDAF.1080800@domain.hid>	<4C051100.7000803@domain.hid>	<4C051E26.8020102@domain.hid>	<4C053217.5010809@domain.hid>	<4C053608.3030604@domain.hid>	<4C06011A.7020507@domain.hid>	<4C07A9F4.7090709@domain.hid>
	<4C07AC61.4040705@domain.hid> <4C07B031.6090504@domain.hid>
	<4C07B530.3040200@domain.hid> <4C07B70E.6050303@domain.hid>
	<4C07BC21.1080907@domain.hid>
In-Reply-To: <4C07BC21.1080907@domain.hid>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] Linux kernel 2.6.32.14 and Xenomai 2.5.2 does
	not boot
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Jan Kiszka <jan.kiszka@domain.hid>
Cc: xenomai@xenomai.org

On 03/06/10 16:28, Jan Kiszka wrote:
>> And from the .config Daniele posted, it appears that he disabled APIC,
>> so that Xenomai is trying to use the 8254.
> 
> Right. And the HPET is on, so this programmed to fail.
> 
> Daniele, please enable CONFIG_X86_UP_APIC or disable CONFIG_HPET_TIMER -
> just as Kconfig warned you.

Thanks. I enabled this setting, but the kernel message at boot is still
there, but, if I understood correctly this is expected.

I haven't made any progress trying to use Ipipe 2.6. At the moment I do
not have time to debug it further. I'll stick to kernel version
2.6.30.10 and Ipipe 2.4.

Cheers,
-- 
Daniele

