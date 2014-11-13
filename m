From: "Lennart Sorensen" <lsorense@csclub.uwaterloo.ca>
Date: Thu, 13 Nov 2014 09:59:34 -0500
Message-ID: <20141113145934.GL24110@csclub.uwaterloo.ca>
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
> baud_base = 115200,115200,115200,0,0,0,0,0
> tx_fifo = 64,64,64,0,0,0,0,0
> start_index = 1
> 
> Then setting 
>        xeno_16550A.irq=73,74,45 \
> 
> Rebooted and crashed:
> 
> [    2.491980] Unhandled fault: external abort on non-linefetch (0x1028) at 0xfa022008

An external abort is often (almost always in my experience) what happens
when you try to access a register on something that is either not powered
on, or does not have clocks enabled.

So you may unfortunately need to get into clock setup.

-- 
Len Sorensen

