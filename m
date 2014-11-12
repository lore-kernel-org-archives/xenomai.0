Date: Wed, 12 Nov 2014 15:30:26 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Message-ID: <20141112143026.GT17476@sisyphus.hd.free.fr>
References: <20141107095222.GD6724@sisyphus.hd.free.fr>
 <586279251.109308096.1415364479248.JavaMail.root@zimbra90-e16.priv.proxad.net>
 <20141107195807.GD17476@sisyphus.hd.free.fr>
 <545FA90B.4040407@free.fr>
 <20141110123657.GJ17476@sisyphus.hd.free.fr>
 <54626A2E.6020307@free.fr>
 <20141111200358.GL17476@sisyphus.hd.free.fr>
 <54635DD7.9090800@free.fr>
 <20141112133447.GO17476@sisyphus.hd.free.fr>
 <54636E3F.1070207@free.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <54636E3F.1070207@free.fr>
Subject: Re: [Xenomai] IMX kernel 3.0.35_4.1.0 +
 adeos-ipipe-3.0.43-mx6q-1.18-14 -> very slow boot
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Thierry Bultel <tbultel@free.fr>
Cc: nicolas Mabire <nicolas.mabire@basystemes.fr>, xenomai@xenomai.org

On Wed, Nov 12, 2014 at 03:27:11PM +0100, Thierry Bultel wrote:
> Le 12/11/2014 14:34, Gilles Chanteperdrix a écrit :
> >On Wed, Nov 12, 2014 at 02:17:11PM +0100, Thierry Bultel wrote:
> >>Le 11/11/2014 21:03, Gilles Chanteperdrix a écrit :
> >>>On Tue, Nov 11, 2014 at 08:57:34PM +0100, Thierry Bultel wrote:
> >>>>Le 10/11/2014 13:36, Gilles Chanteperdrix a écrit :
> >>>>>You can use printascii in the timer interrupt acknowledge routine to
> >>>>>print a character every HZ ticks, this will give bad latency, but
> >>>>>should work.
> >>>>>
> >>>>
> >>>>For unknown reason, the kernel gets stuck after
> >>>>"console [tty0] enabled, bootconsole disabled" if I use printascii
> >>>>in do_local_timer().
> >>>>earlyprintk seems broken as well.
> >>>
> >>>Without doing this, does earlyprintk work?
> >>
> >>No it does not. In fact, this kernel is strange with early debug.
> >>Namely, even without earlyprintk, when it comes to disable the
> >>bootconsole to use the normal one, it uses then re-prints everything
> >>was printed before, making think that it has restarted from the
> >>beginning.
> >>
> >>I confirm that calling printascii in do_local_timer() leads to a
> >>kernel panic. Same thing if I use __ipipe_serial_debug instead.
> >>I have used a counter (one per cpu) to start logging after 30000
> >>ticks and it crashes after that delay.
> >
> >Having looked at the sources, I do not find a debug-macro.S for
> >imx6. So, I doubt printascii can work at all. Maybe a first step is
> >to implement this missing support.
> 
> I think that the implementation is in arch/arm/plat-mxc/include
> /mach/debug-macro.S

And the debug UART you are using is UART2 ?

-- 
					    Gilles.

