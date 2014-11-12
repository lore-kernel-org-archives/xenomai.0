Date: Wed, 12 Nov 2014 21:01:25 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Message-ID: <20141112200125.GG17476@sisyphus.hd.free.fr>
References: <314E5ECDAA86314791309FA670550F89C676CD2D@SINTEFEXMBX05.sintef.no>
 <20141111140230.GA17476@sisyphus.hd.free.fr>
 <314E5ECDAA86314791309FA670550F89C676CE2D@SINTEFEXMBX05.sintef.no>
 <314E5ECDAA86314791309FA670550F89C676E884@SINTEFEXMBX05.sintef.no>
 <20141112134531.GP17476@sisyphus.hd.free.fr>
 <314E5ECDAA86314791309FA670550F89C676EB35@SINTEFEXMBX05.sintef.no>
 <20141112191631.GJ24110@csclub.uwaterloo.ca>
 <314E5ECDAA86314791309FA670550F89C676F324@SINTEFEXMBX05.sintef.no>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <314E5ECDAA86314791309FA670550F89C676F324@SINTEFEXMBX05.sintef.no>
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

On Wed, Nov 12, 2014 at 07:51:36PM +0000, Terje Frøysa wrote:
> Hello Len,
> 
> Thanks for your input.
> I have already considered using standard Linux serial drivers.
> The Debian 3.8.13-bone67 is currently supporting the omap_uart driver while the 8250 is parked on a side-track.
> According to R.C.Nelson it is not straight forward to switch driver (see his comments below).
> I don't know if the 8250-serial driver is the same as the 8250-omap you are referring,
> but if you have succeeded with the (an) 8250-omap driver I am very interested in learning how you did it.

Have you tried the patch I sent? Because without this patch the
xeno_16550A can not work on omap: omap serial uses 2 bytes wide
reads on 4 bytes wide registers (I think 4 bytes wide reads work
just as well, and maybe byte access, but the point is, each
registers occupies 4 bytes, so the offsets must be multiplied by 4),
whereas xeno_16550A uses byte access to invalid offsets, and cause
the abort you observe.

If you start using xeno_16550A, you will not have to care about
omap-serial or 8250.

> 
> I have also been searching for a user's manual or some c-code
> examples utilizing the omap_uart in a more elevated fashion, but I
> find only novice examples or python scripts.

The xeno_16550A ioctl API is documented here:
http://www.xenomai.org/documentation/xenomai-head/html/api/group__rtserial.html

This is not very complicated.


-- 
					    Gilles.

