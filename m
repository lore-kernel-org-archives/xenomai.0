Date: Mon, 7 Mar 2016 13:51:04 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Message-ID: <20160307125104.GB24055@hermes.click-hack.org>
References: <CANBp=-hcC5DHb=HpMzqbewQswwwh-dF-+i+DoOd6KRHoXbv2qw@mail.gmail.com>
 <CANBp=-iWByct=fMOPB6u8PrS10h2M0w9MbaOGrJAvfGqsjCVCw@mail.gmail.com>
 <20160307113708.GA24055@hermes.click-hack.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20160307113708.GA24055@hermes.click-hack.org>
Subject: Re: [Xenomai] Fwd: Latency test fails. Problem during installation
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Michele Belotti <miki.belotti@gmail.com>
Cc: xenomai@xenomai.org

On Mon, Mar 07, 2016 at 12:37:08PM +0100, Gilles Chanteperdrix wrote:
> > 
> > We follow the installation guide and the troubleshooting but the latency is
> > still very high with some high jumps.
> > We tried to deal with the different options described in the guide
> > 
> > CONFIG_CPU_FREQ, CONFIG_CPU_IDLE, CONFIG_CONTEXT_TRACKING_FORCE
> > XENO_OPT_STATS  NO_HZ_FULL_ALL  BSD_PROCESS_ACCT  but none has impacted the
> > system, only marginal improvements.
> 
> What about CONFIG_ACPI_CPUFREQ?

Sorry, CONFIG_ACPI_PROCESSOR.

-- 
					    Gilles.
https://click-hack.org

