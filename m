Message-ID: <4C289319.4050807@domain.hid>
Date: Mon, 28 Jun 2010 14:18:33 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <AANLkTimKEFqaOGLrvLhpf0FqqdTkAPraazAnbuUGMa0V@mail.gmail.com>
In-Reply-To: <AANLkTimKEFqaOGLrvLhpf0FqqdTkAPraazAnbuUGMa0V@mail.gmail.com>
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
> Hello,
> 
> I've been having this problem for some time now and I hope someone from
> the Xenomai community can help.
> Basically, my kernel does not want to boot with PMC card. I have managed
> to use console redirection of messages
> to the serial port and I can see the error messages. From what I can
> see, there is a problem with '/xnintr_irq_handler/' due
> to this message at boot time: /Xenomai: xnintr_irq_handler: IRQ10 not
> handled. Disabling IRQ line./

As repeated many times, disabling ACPI has been known to cause such
issues. So, you should keep ACPI enabled, only ACPI_PROCESSOR needs to
be disabled.

For IRQ conflicts, see:
http://www.xenomai.org/index.php/FAQs#What_can_I_do_if_Xenomai_and_Linux_devices_share_the_same_IRQ.3F

Also, to be sure that the problem you have is not a configuration issue,
try the Xenomai-patched linux kernel, with exactly the same
configuration, only with CONFIG_XENOMAI and CONFIG_IPIPE turned off. If
it does not boot, then the issue is not caused by Xenomai.

If it does boot, then please send another mail, including, this time:
- the version of the Linux kernel you use;
- the Adeos and Xenomai versions you use;
- the contents of /proc/interrupts and /proc/xenomai/irq;
- the full serial log, from the boot up to the bug;
- the two .config file, the one which boots, the one which does not.

-- 
					    Gilles.

