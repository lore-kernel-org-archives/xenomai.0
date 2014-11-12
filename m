Date: Wed, 12 Nov 2014 15:51:17 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Message-ID: <20141112145117.GV17476@sisyphus.hd.free.fr>
References: <314E5ECDAA86314791309FA670550F89C676CD2D@SINTEFEXMBX05.sintef.no>
 <20141111140230.GA17476@sisyphus.hd.free.fr>
 <314E5ECDAA86314791309FA670550F89C676CE2D@SINTEFEXMBX05.sintef.no>
 <314E5ECDAA86314791309FA670550F89C676E884@SINTEFEXMBX05.sintef.no>
 <20141112134531.GP17476@sisyphus.hd.free.fr>
 <314E5ECDAA86314791309FA670550F89C676EB35@SINTEFEXMBX05.sintef.no>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <314E5ECDAA86314791309FA670550F89C676EB35@SINTEFEXMBX05.sintef.no>
Subject: Re: [Xenomai] xeno_16550A driver install problems.
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Terje =?utf-8?Q?Fr=C3=B8ysa?= <Terje.Froysa@sintef.no>
Cc: "Xenomai@xenomai.org" <Xenomai@xenomai.org>

On Wed, Nov 12, 2014 at 02:32:40PM +0000, Terje Frøysa wrote:
> Thanks for your quick reply Gilles,
> 
> - Changing omap-serial driver is not a tempting solution.
> - I'll try out your 8250 suggestion.
> - I have not figured out how to " arrange for the clocks to be started", would that be writing a kernel module that initiates the UART clock systems?
> 
> If not the 8250 suggestion works, I begin to believe that I have to abandon the xeno_1650A driver.
> Do you know anybody that have succeeded in running the xeno_16550A driver under such circumstances?

I just had a quick look at the omap-serial.c driver and:
- it does not do anything that I can see to enable its clocks
- it does NOT  use byte access but word access, that is, its registers
are 16 bits wide.

Unfortunately, as far as I can tell, the xeno_16550A driver only
supports byte access. So, if you want it to work, you have to modify
the driver to accept a "regshift" parameter applied to all offsets
and use the corresponding readw if regshift is 2 or readl if
regshift is 4.

-- 
					    Gilles.

