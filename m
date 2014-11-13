Date: Thu, 13 Nov 2014 09:02:29 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Message-ID: <20141113080229.GB4656@sisyphus.hd.free.fr>
References: <314E5ECDAA86314791309FA670550F89C676E884@SINTEFEXMBX05.sintef.no>
 <20141112134531.GP17476@sisyphus.hd.free.fr>
 <314E5ECDAA86314791309FA670550F89C676EB35@SINTEFEXMBX05.sintef.no>
 <20141112145117.GV17476@sisyphus.hd.free.fr>
 <314E5ECDAA86314791309FA670550F89C676EBE1@SINTEFEXMBX05.sintef.no>
 <20141112151305.GW17476@sisyphus.hd.free.fr>
 <314E5ECDAA86314791309FA670550F89C676FC45@SINTEFEXMBX05.sintef.no>
 <20141113072118.GL17476@sisyphus.hd.free.fr>
 <314E5ECDAA86314791309FA670550F89C676FCFC@SINTEFEXMBX05.sintef.no>
 <20141113075616.GA4656@sisyphus.hd.free.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20141113075616.GA4656@sisyphus.hd.free.fr>
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

On Thu, Nov 13, 2014 at 08:56:16AM +0100, Gilles Chanteperdrix wrote:
> On Thu, Nov 13, 2014 at 07:53:13AM +0000, Terje Frøysa wrote:
> > Thanks Gilles,
> > 
> > Patch ran without problems now. Checked source and found it correctly patched.
> > 
> > I am going to compile a new kernel.
> > I have three UARTS.
> > I am tempted to do as follows:
> > 
> > 1. Disable the 8250 (It is not applicable anyhow in current version)
> > 2. Enable omap_uart on UART 1
> > 3. Install xeno_16550A in kernel.
> > 4. Apply kernel parameters for UART 2 and 4 for the xeno_16550A.
> > 5. If successful, try the cross-link between UART 2 and 4.
> > 
> > If you see some caveats regarding my plan, please tell.
> 
> Well, this is risky, I would:
> - enable neither omap_uart nor 8250 in kernel configuration
> - plug UART2 to the PC with a USB-serial cable if the PC does not
> have a serial port.

And first test the PC <-> board serial link with a kernel with a
working omap-serial, with UART2 plugged to the PC. To be sure that
the PC side is working.

-- 
					    Gilles.

