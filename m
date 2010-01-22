Message-ID: <4B596488.40805@domain.hid>
Date: Fri, 22 Jan 2010 09:40:40 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <hjbkl0$5lb$1@domain.hid>
In-Reply-To: <hjbkl0$5lb$1@domain.hid>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] Vortex86SX and TSC
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Max Vasin <max.vasin@domain.hid>
Cc: xenomai@xenomai.org

Max Vasin wrote:
> Hello,
> 
> I'm trying to port my application from the DiamonSystems Hercules II SBC 
> (with VIA C3 CPU) to the DiamonSystems Helios SBC (with Vortex86SX CPU). 
>   The application contains one RT task running at 50 kHz and three RT 
> tasks running at 2kHz. One iteration of the first task takes 15 us to 
> complete. Measured latencies on the Vortex86 CPU are about 40us with max 
> 56us, on the VIA C3 CPU are about 7us. Vortex86SX is 486 compatible, so 
> Xenomai is built without TSC support, but CPUID claims the the it 
> supports TSC. Is there a way to get kernel part of Xenomai to use TSC?

Xenomai uses TSC if Linux configuration option is enabled. So, to enable
the use of TSC, you will have to modify arch/x86/Kconfig.cpu.

The quick and dirty way would be to add M486 to the long "depends on"
list of the X86_TSC option.

-- 
					    Gilles.

