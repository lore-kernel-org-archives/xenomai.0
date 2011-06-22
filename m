Message-ID: <4E01E0EE.90002@domain.hid>
Date: Wed, 22 Jun 2011 14:32:46 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <18303_1308739447_4E01C777_18303_558_1_ECB646CBB62FD044927FDEDF0252D3E701E388B3612E@THSONEA01CMS03P.one.grp>	<4E01CA9A.2040709@domain.hid>	<17296_1308741006_4E01CD8E_17296_18611_1_ECB646CBB62FD044927FDEDF0252D3E701E388B361AA@THSONEA01CMS03P.one.grp>	<4E01CE25.2020202@domain.hid>
	<17288_1308741885_4E01D0FD_17288_343_1_ECB646CBB62FD044927FDEDF0252D3E701E388B36206@domain.hid>
In-Reply-To: <17288_1308741885_4E01D0FD_17288_343_1_ECB646CBB62FD044927FDEDF0252D3E701E388B36206@domain.hid>
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

On 2011-06-22 13:24, VEYSSIERE Nicolas wrote:
> First time for me here.
> 
> The log are in the attachement.
> 

...

> [    0.383950] ------------[ cut here ]------------
> [    0.384950] WARNING: at arch/x86/kernel/apic/apic.c:1289 setup_local_APIC+0x1e1/0x2cb()
> [    0.385950] Hardware name: VirtualBox
> [    0.386950] Modules linked in:
> [    0.389949] Pid: 1, comm: swapper Not tainted 2.6.38-xenomai-r6 #1

What's your host system, Windows? If it's Linux, don't use VBox, use
QEMU/KVM (it's know to host Xenomai x86 without major problems, it's my
primary test platform for years).

What may help if you can't avoid VBox is to provide the host's CPU
frequency statically to Xenomai (xeno_hal.cpufreq=...) and enforce the
tsc as clocksource (clocksource=tsc). Timekeeping may go mad in the
guest, but it's for testing purposes only anyway.

Jan

-- 
Siemens AG, Corporate Technology, CT T DE IT 1
Corporate Competence Center Embedded Linux

