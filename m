Date: Tue, 18 Nov 2014 20:00:14 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Message-ID: <20141118190014.GC3177@sisyphus.hd.free.fr>
References: <20141117202754.GI31920@sisyphus.hd.free.fr>
 <20141117214734.GW24110@csclub.uwaterloo.ca>
 <20141117215458.GM31920@sisyphus.hd.free.fr>
 <20141117221001.GX24110@csclub.uwaterloo.ca>
 <20141117221542.GN31920@sisyphus.hd.free.fr>
 <20141118152422.GY24110@csclub.uwaterloo.ca>
 <20141118152649.GC26237@sisyphus.hd.free.fr>
 <20141118184843.GZ24110@csclub.uwaterloo.ca>
 <20141118185131.GB3177@sisyphus.hd.free.fr>
 <20141118185657.GA24110@csclub.uwaterloo.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20141118185657.GA24110@csclub.uwaterloo.ca>
Subject: Re: [Xenomai] I-pipe error when requesting irq that is on omap gpio
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Lennart Sorensen <lsorense@csclub.uwaterloo.ca>
Cc: xenomai@xenomai.org

On Tue, Nov 18, 2014 at 01:56:57PM -0500, Lennart Sorensen wrote:
> On Tue, Nov 18, 2014 at 07:51:31PM +0100, Gilles Chanteperdrix wrote:
> > I would take the simple approach: disable the smartidle in the probe
> > function for all GPIO banks if IS_ENABLED(CONFIG_IPIPE)
> > 
> > Otherwise, the enable_irqdesc/disable_irqdesc functions already
> > keep track of which bank has real-time irq handlers registered, and
> > it is already conditionally compiled only if CONFIG_IPIPE is
> > enabled. So, you can add your code there.
> 
> I will consider that after doing my other test.  For me adding one flag
> to the dtb for our board seems less invasive, but for ipipe overall it
> would be better to make ipipe turn of smartidle on the IRQ supporting
> gpio banks.

RT IRQs only, we do not care about NRT IRQS, they can depend on the
dts parameter. Anyway, if you tell me where the code you are talking
about can be found, I can propose a patch that you test, and merge
it if it works for you.

-- 
					    Gilles.

