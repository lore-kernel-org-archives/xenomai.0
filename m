Date: Tue, 11 Nov 2014 15:16:18 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Message-ID: <20141111141618.GC17476@sisyphus.hd.free.fr>
References: <314E5ECDAA86314791309FA670550F89C676CD2D@SINTEFEXMBX05.sintef.no>
 <20141111140230.GA17476@sisyphus.hd.free.fr>
 <314E5ECDAA86314791309FA670550F89C676CE2D@SINTEFEXMBX05.sintef.no>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <314E5ECDAA86314791309FA670550F89C676CE2D@SINTEFEXMBX05.sintef.no>
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

On Tue, Nov 11, 2014 at 02:12:25PM +0000, Terje Frøysa wrote:
> Good question Gilles,
> 
> I have been studying the URL’s below and just copied the recipes
> as they (especially the last one) indicates that the installation
> is feasible on a bbb. When removing one driver (serial8259) and
> adding another (xeno_16550A) I saw no indications that this would
> affect the clock support for the UARTS.

With the move to DT and everything I have no idea if the clocks are
enabled by DT, or if there is code in the driver to do that. You
would have to check

> Can the lack of clock
> enable for the interface domain result in the boot-crash?

Yes.

> (The console UART works though, so at least the clock common to the
> UARTS is enabled).

I would believe each UART has its own interface clock. 

Also note that the interface clock is not the only clock needed, you
also need the "functional clock" for the device to work correctly.

-- 
					    Gilles.

