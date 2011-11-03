Date: Thu, 3 Nov 2011 13:00:42 -0400
Message-ID: <20111103170042.GD30117@domain.hid>
References: <20111102201210.GY30117@domain.hid>
	<4EB1B691.9020801@domain.hid>
	<20111103151353.GB30117@domain.hid>
	<4EB2B58F.3070600@domain.hid>
	<20111103161844.GC30117@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20111103161844.GC30117@domain.hid>
From: lsorense@domain.hid (Lennart Sorensen)
Subject: Re: [Adeos-main] irq related kernel crash with adeos 3.0.4 powerpc.
List-Id: General discussion about Adeos <adeos-main.gna.org>
List-Unsubscribe: <https://mail.gna.org/options/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
List-Archive: </public/adeos-main>
List-Post: <mailto:adeos-main@gna.org>
List-Help: <mailto:adeos-main-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
To: Lennart Sorensen <lsorense@domain.hid>
Cc: adeos-main@gna.org, Philippe Gerum <rpm@xenomai.org>

On Thu, Nov 03, 2011 at 12:18:44PM -0400, Lennart Sorensen wrote:
> On Thu, Nov 03, 2011 at 04:38:55PM +0100, Philippe Gerum wrote:
> > Thanks. Meanwhile you may want to try this one. This is aimed at fixing an issue with acking
> > cascaded IPIC irqs over the pipeline.
> > 
> > http://download.gna.org/adeos/patches/v3.x/powerpc/adeos-ipipe-3.0.8-powerpc-2.13-04.patch
> 
> I sure will.
> 
> I do happen to have cascaded IRQs since we have an IRQ controller in an
> FPGA connected to the external IRQ lines on the 8360.
> 
> I don't know if the quickengine IRQs qualify as cascaded to the ipic
> or not.  They probably do.
> 
> Anyhow, compiling now, should be testing in about 20 minutes or so,
> or right after lunch.

Well that fixed the crash.

Now I have to go figure out why the ucc_geth ports can't seem to get
link up with 3.0.  But that's a different problem.

-- 
Len Sorensen

