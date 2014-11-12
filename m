From: "Lennart Sorensen" <lsorense@csclub.uwaterloo.ca>
Date: Wed, 12 Nov 2014 14:16:31 -0500
Message-ID: <20141112191631.GJ24110@csclub.uwaterloo.ca>
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

We just switched from using omap-serial to 8250-omap, and find it much
more stable.  I wonder if that would also allow doing what you are trying
to do.  I believe it just got merged to go into 3.19, but I applied it
with minimal other patched needed to 3.14 and with a few more patches
to 3.12.

Being a core 8250 driver would after all likely make doing 16550 stuff
easier.

-- 
Len Sorensen

