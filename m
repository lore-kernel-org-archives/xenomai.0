Date: Wed, 12 Nov 2014 15:39:20 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Message-ID: <20141112143920.GU17476@sisyphus.hd.free.fr>
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

That would be look at omap-serial.c to see how it does it, and do
the same thing in a piece of code which registers a phony DT driver
matching the same string as omap-serial. It does not need to be a
kernel module, it can be put in the kernel itself.

> If not the 8250 suggestion works, I begin to believe that I have
> to abandon the xeno_1650A driver.

As you wish, but any of the three proposition takes one day maximum,
this is not a lot of work.

> Do you know anybody that have succeeded in running the xeno_16550A
> driver under such circumstances?

I have no idea.

-- 
					    Gilles.

