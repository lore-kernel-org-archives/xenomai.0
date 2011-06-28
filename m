Message-ID: <4E09DBC0.30705@domain.hid>
Date: Tue, 28 Jun 2011 15:48:48 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <4E09D058.10906@domain.hid>
In-Reply-To: <4E09D058.10906@domain.hid>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] Xenomai 2.6.5 with Linux 2.6.38.8 kernel
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Daniele Nicolodi <daniele@domain.hid>
Cc: xenomai@xenomai.org

On 06/28/2011 03:00 PM, Daniele Nicolodi wrote:
> Hello,
> 
> is the Xenomai 2.6.5 supposed to work with Linux 2.6.38.8 kernel and
> adeos patch 2.6.38.8-x86-2.10 supposed to work?
> 
> The above combination gives me an error compiling
> arch/x86/xenomai/hal_32.c in function rthal_arch_init where nmi_watchdog
> and NMI_IO_APIC are not defined. Indeed those are not defined anywhere
> in the kernel or xenomai source tree.

Disable NMI watchdog.

-- 
					    Gilles.

