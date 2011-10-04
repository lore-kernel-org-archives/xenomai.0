Message-ID: <4E8AE5A6.6090306@domain.hid>
Date: Tue, 04 Oct 2011 12:53:26 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <20110926090226.9C75AD68@domain.hid>
In-Reply-To: <20110926090226.9C75AD68@domain.hid>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] Frequency downscaling of new intel CPU
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Petr Cervenka <grugh@domain.hid>
Cc: xenomai-help <xenomai@xenomai.org>

On 09/26/2011 09:02 AM, Petr Cervenka wrote:
> 
> Hello.
> 
> I recently tried newer computer and I suprusingly realized that it is bigger load than the old one with our xenomai application.
> The problem is in the frequency downscaling of the processor when the load in under 100%.
> Of course I have disabled CPU_FREQ, ACPI_PROCESSOR and INTEL_IDLE as suggested.
> Later I tried also to disable CPU_IDLE, 7300_IDLE (intel chipset idle memory) and all power efficiency settings in the BIOS, but without success.
> The experienced behaviour is following:
> when the process is waiting for an event, the processor lowers its frequency and when the event happens it tries to restore (slowly) its nominal frequency.
> 
> Do you have any advice or tip what to try, because I'm really desperate?

Have you tried:
- enabling SMI workaround (and do not forget to check the boot logs to
check that it actually works with the chipset you use);
- if that fails, adding "idle=poll" to kernel arguments?

-- 
                                                                Gilles.

