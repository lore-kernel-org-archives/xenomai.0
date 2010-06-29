Message-ID: <4C2A1C03.9080304@domain.hid>
Date: Tue, 29 Jun 2010 18:14:59 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <AANLkTimKEFqaOGLrvLhpf0FqqdTkAPraazAnbuUGMa0V@mail.gmail.com>	<4C289319.4050807@domain.hid>
	<AANLkTin9R46PUKwDQw_nXck_RkL9TH01Qqhuw-7YwmDT@mail.gmail.com>
In-Reply-To: <AANLkTin9R46PUKwDQw_nXck_RkL9TH01Qqhuw-7YwmDT@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] IRQ conflict issues with and ESD PMC card.
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Nape Ibrahim Lentsoane <nape.lentsoane@domain.hid>
Cc: xenomai@xenomai.org

Nape Ibrahim Lentsoane wrote:
> 
> I turned off CONFIG_XENOMAI and CONFIG_IPIPE and the machine boots with
> no problems.
> I use:
> --Linux kernel version 2.6.32.11
> --adeos-ipipe-2.6.32.11-x86-2.
> 6-03. intalled via the debian package: linux-patch-xenomai (2.5.3-2)
> --Xenomai version 2.5.3

Could you try and enable the APIC and local APIC ? Here you are
configured with PIC only, which only has 16 irqs. Also what hardware are
you running on?

-- 
					    Gilles.

