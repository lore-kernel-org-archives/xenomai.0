Message-ID: <45562072.3020206@domain.hid>
Date: Sat, 11 Nov 2006 20:11:46 +0100
From: Wolfgang Grandegger <wg@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-core] [PATCH] Xenomai configuration help for Linux 2.4
References: <4555C56B.3070205@domain.hid> <4555DFBE.4050609@domain.hid>
In-Reply-To: <4555DFBE.4050609@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Jan Kiszka <jan.kiszka@domain.hid>
Cc: xenomai-core <xenomai@xenomai.org>

Jan Kiszka wrote:
> Wolfgang Grandegger wrote:
>> Hello,
>>
>> the attached patch adds Xenomai configuration help for Linux 2.4:
> 
> Cool that you picked this up! Frankly, I didn't expect that this would
> really work without any pitfalls - but it seems to.

I immediately liked you idea. Having an easily accessible description of 
the Xenomai kernel configuration parameters helps users a lot. So far I 
just realized some problems with "choice" but they seem not related to 
the conversion. It's more likely a bug in menuconfig.

> Just one addition feature wish: Could you enhance it so that it can also
> upgrade an existing Configure.help patch? Maybe put some magic marks
> (comments) around the xeno stuff and remove the whole block before
> re-patching the help information?

You mean re-running "prepare-kernel" should update the Xenomai block in 
Configure.help? Doing it in the perl script should not be a big deal.

> Thanks,
> Jan (who wishes that this would also work for Kconfig->Config.in...)

Yeah, but...

Wolfgang.


