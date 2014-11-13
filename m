Date: Thu, 13 Nov 2014 09:48:16 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Message-ID: <20141113084816.GE4656@sisyphus.hd.free.fr>
References: <20141113072118.GL17476@sisyphus.hd.free.fr>
 <314E5ECDAA86314791309FA670550F89C676FCFC@SINTEFEXMBX05.sintef.no>
 <20141113075616.GA4656@sisyphus.hd.free.fr>
 <20141113080229.GB4656@sisyphus.hd.free.fr>
 <314E5ECDAA86314791309FA670550F89C676FDC4@SINTEFEXMBX05.sintef.no>
 <20141113082231.GC4656@sisyphus.hd.free.fr>
 <314E5ECDAA86314791309FA670550F89C676FDF9@SINTEFEXMBX05.sintef.no>
 <20141113083023.GD4656@sisyphus.hd.free.fr>
 <314E5ECDAA86314791309FA670550F89C676FE4A@SINTEFEXMBX05.sintef.no>
 <314E5ECDAA86314791309FA670550F89C676FE96@SINTEFEXMBX05.sintef.no>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <314E5ECDAA86314791309FA670550F89C676FE96@SINTEFEXMBX05.sintef.no>
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

On Thu, Nov 13, 2014 at 08:44:58AM +0000, Terje Frøysa wrote:
> Sorry Gilles,
> Still crashing....
> 
> First I booted OK with irq=0,0,0
> Verified all (other) parameters:
> 
> debian@beaglebone:/sys/module/xeno_16550A/parameters$ ls
> baud_base  irq  mem  regshift  regwidth  start_index  tx_fifo
> mem = 1208098816,1208107008,1209696256,0,0,0,0,0
> irq = 0,0,0,0,0,0,0,0
> regshift = 2
> regwiddth = 2

It is regwidth = 2, not regwiddth. Please make sure that both are
set correctly.

Also, could you try to only try one UART, the one you want to test?
There is no need to enable the other ones.

And in fact, I would test the one with the serial console, since it
is known to work.

-- 
					    Gilles.

