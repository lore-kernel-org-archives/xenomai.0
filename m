Date: Mon, 1 Dec 2014 19:54:21 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Message-ID: <20141201185421.GD28038@hermes>
References: <314E5ECDAA86314791309FA670550F89C9C4FD8A@SINTEFEXMBX05.sintef.no>
 <20141201073433.GR2964@hermes>
 <314E5ECDAA86314791309FA670550F89C9C5006D@SINTEFEXMBX05.sintef.no>
 <20141201085028.GA21004@hermes>
 <314E5ECDAA86314791309FA670550F89C9C50321@SINTEFEXMBX05.sintef.no>
 <CAD3Bbm+rTuzSWJ+ikNMDZgi3CW7yO4wUgawQco+C4ChG-rLj8A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAD3Bbm+rTuzSWJ+ikNMDZgi3CW7yO4wUgawQco+C4ChG-rLj8A@mail.gmail.com>
Subject: Re: [Xenomai] WARNING: at arch/arm/kernel/ipipe.c:157
 ipipe_set_irq_affinity+0x47/0x70()
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Hidde Verstoep <hverstoep@e2mtechnologies.eu>
Cc: "xenomai@xenomai.org" <xenomai@xenomai.org>

On Mon, Dec 01, 2014 at 12:35:18PM +0100, Hidde Verstoep wrote:
> > By the way.. When compiling kernel for Xenomai, I am advised to
> > turn off CPU Frequency scaling "as it is known to cause
> > trouble". When enabled I could inspect and set the CPU clock
> > frequency by the "cpufreq-info" and "cpufreq-set". These tools
> > are no longer available and I don't find any settings in the
> > menuconfig.
> >
> > What is the default BBB CPU frequency when frequency scaling is turned off?
> 
> From my experience with the BBB and Xenomai:
> The default CPU frequency with frequency scaling turned off is 600
> MHz. This was not acceptable for me since the BBB supports 1000
> Mhz.

Well, to what frequency does u-boot set the processor? Because if
u-boot sets the frequency to 600 MHz and Linux does not change it,
chances are that if you set the frequency to 1 GHz in u-boot, Linux
will not change it either. This is what I do on the omap3 board I
use: set the frequency to 720 MHz in u-boot.

-- 
					    Gilles.

