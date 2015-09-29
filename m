Date: Tue, 29 Sep 2015 15:40:12 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Message-ID: <20150929134012.GD13638@hermes.click-hack.org>
References: <560A8662.8050204@sigmatek.at> <20150929153640.6acc16b5@md1em3qc>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20150929153640.6acc16b5@md1em3qc>
Subject: Re: [Xenomai] ipipe_read_tsc, ipipe_tsc2ns
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Henning Schild <henning.schild@siemens.com>
Cc: xenomai@xenomai.org

On Tue, Sep 29, 2015 at 03:36:40PM +0200, Henning Schild wrote:
> On Tue, 29 Sep 2015 14:38:58 +0200
> Johann Obermayr <johann.obermayr@sigmatek.at> wrote:
> 
> > in a loadable kernel module i use ipipe_read_tsc and ipipe_tsc2ns.
> > But at compiling i get follow warning.
> > 
> > WARNING: "__ipipe_kuser_tsc_freq" [km_testsample.ko] undefined!
> > 
> > we have ARM, Linux 3.0 + xenomai 2.6.2.1
> 
> You should be able to resolve that linking problem by exporting the
> missing symbol.
> Add a "EXPORT_SYMBOL_GPL(__ipipe_kuser_tsc_freq);" after its definition.

The functions ipipe_tsc2us/tsc2ns are really internal functions for
the I-pipe tracer, I am not sure we want to expose this interface.

-- 
					    Gilles.
https://click-hack.org

