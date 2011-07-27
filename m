Message-ID: <4E2FD923.2040003@domain.hid>
Date: Wed, 27 Jul 2011 11:23:47 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <4E2EAB0F.6050109@domain.hid>
In-Reply-To: <4E2EAB0F.6050109@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-core] Debugging Xenomai kernel
List-Id: Xenomai life and development <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: zenati <omar.zenati@domain.hid>
Cc: Xenomai core <Xenomai-core@domain.hid>

On 2011-07-26 13:54, zenati wrote:
> Dear,
> 
> I'm trying to debug Xenomai kernel with GDB and Qemu.

QEMU in emulation or KVM mode?

> So, I launch
> Xenomai in Qemu and make it waiting for GDB. Then I start GDB and
> connect them to Qemu, make breakpoint at the desired function to debug
> and start Xenomai. If the function belongs to the linux kernel, the
> execution stop at the breakpoint. But, if the function belongs to the
> Xenomai nucleus, GDB recognize the breakpoint at the execution but don't
> stop.

Is Xenomai built as module or part of the main kernel image? The latter
is simpler to handle as you don't have to deal with modules as symbol
sources, find out their addresses, and load them at the right location.

> 
> Is it possible to debug Xenomai with GDB and Qemu?

Definitely.

> Is it the good way to debug?
> 
> Thank you for your attention and your help.
> Sincerely,
> 
> Omar ZENATI

Jan

-- 
Siemens AG, Corporate Technology, CT T DE IT 1
Corporate Competence Center Embedded Linux

