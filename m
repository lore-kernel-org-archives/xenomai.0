Message-ID: <4E01E62D.8050504@domain.hid>
Date: Wed, 22 Jun 2011 14:55:09 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <18303_1308739447_4E01C777_18303_558_1_ECB646CBB62FD044927FDEDF0252D3E701E388B3612E@THSONEA01CMS03P.one.grp>	<4E01CA9A.2040709@domain.hid>	<17296_1308741006_4E01CD8E_17296_18611_1_ECB646CBB62FD044927FDEDF0252D3E701E388B361AA@THSONEA01CMS03P.one.grp>	<4E01CE25.2020202@domain.hid>
	<17288_1308741885_4E01D0FD_17288_343_1_ECB646CBB62FD044927FDEDF0252D3E701E388B36206@domain.hid>
	<4E01E0EE.90002@domain.hid>
	<18303_1308746837_4E01E455_18303_6972_2_ECB646CBB62FD044927FDEDF0252D3E701E388B3645B@THSONEA01CMS03P.one.grp>
In-Reply-To: <18303_1308746837_4E01E455_18303_6972_2_ECB646CBB62FD044927FDEDF0252D3E701E388B3645B@THSONEA01CMS03P.one.grp>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] Kernel panic on boot with 2.5.6
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: VEYSSIERE Nicolas <nicolas.veyssiere@domain.hid>
Cc: "xenomai@xenomai.org" <xenomai@xenomai.org>

On 2011-06-22 14:47, VEYSSIERE Nicolas wrote:
> Yes, my host is Windows, I can't change anything about that, and yes it is only for testing.
> 
> I changed my boot line : [    0.000000] Kernel command line: root=/dev/sda3 xeno_hal.cpufreq=1200 clocksource=tsc console=tty0 console=ttyS0,115200 noapic acpi=noirq video=vesafb:mtrr:3,ywrap vga=6
> 
> But I didn't find the range or the unit for cpufreq, and maybe I had to prefix clocksource with xeno_hal ?

Unit is HZ.

> 
> But I noticed this in the log : 
> 
> [    1.202694] BUG: unable to handle kernel NULL pointer dereference at 00000920
> [    1.202694] IP: [<c10736fe>] __xirq_end+0x12/0x2e
> [    1.202694] *pde = 00000000 
> [    1.202694] Oops: 0000 [#1] SMP
> 
> Can it be because SMP is activated and that virtualbox is enabling only 1 processor with 1 core ?

I don't know what vbox emulates in UP mode. We are only using it (for
Windows hosts) in SMP mode.

Jan

-- 
Siemens AG, Corporate Technology, CT T DE IT 1
Corporate Competence Center Embedded Linux

