Message-ID: <4BE31B88.5000102@domain.hid>
Date: Thu, 06 May 2010 21:42:00 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <o2hcfed72901005060052o40bcc542gf42d45e3488c43f1@domain.hid>		<4BE27AA7.2070302@domain.hid>	<i2kcfed72901005060830q1d29f948x4b558e2cf8cb617a@domain.hid>
	<4BE315C9.1050008@domain.hid>
In-Reply-To: <4BE315C9.1050008@domain.hid>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] Problem getting the time with a kernel patched
 with xenomai
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Divi Oillo <divi.oillo@domain.hid>
Cc: Xenomai help <xenomai@xenomai.org>

Gilles Chanteperdrix wrote:
> Divi Oillo wrote:
>> I don't have CONFIG_HPET=y and CONFIG_HPET_MMAP=y in the .config of my
>> patched kernel. How can I configure my patched kernel to fix my problem?
>> Can I add these two options in my patched kernel .config?
> 
> Yes you can, but more important than the kernel options are the run time
> decisions, of which you are informed in the kernel logs, as my last mail
> already told you. Anyway, all this is not really specific about Xenomai,
> so you would probably be better of finding some web site explaining
> high-res timers in details.

for instance:
http://elinux.org/High_Resolution_Timers#How_to_detect_if_your_timer_system_supports_high_resolution



-- 
					    Gilles.

