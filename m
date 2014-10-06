Date: Mon, 6 Oct 2014 10:51:34 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Message-ID: <20141006085134.GA17676@sisyphus.hd.free.fr>
References: <5431959D.8060504@xenomai.org>
 <20141005231208.GO14975@sisyphus.hd.free.fr>
 <201410061031.43615.leo@alaxarxa.net>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <201410061031.43615.leo@alaxarxa.net>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] [ANNOUNCE] Xenomai 3.0-rc1
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Leopold Palomo-Avellaneda <leo@alaxarxa.net>
Cc: xenomai@xenomai.org

On Mon, Oct 06, 2014 at 10:31:38AM +0200, Leopold Palomo-Avellaneda wrote:
> A Dilluns, 6 d'octubre de 2014, Gilles Chanteperdrix va escriure:
> > On Sun, Oct 05, 2014 at 09:01:49PM +0200, Philippe Gerum wrote:
> > >
> > > We are pleased to announce the official release of Xenomai 3.0-rc1,
> > > which starts the candidate release cycle for Xenomai 3.
> > >
> > > Xenomai 3 is the new architecture of our real-time framework,
> > > which can run its APIs side-by-side with Linux as a co-kernel system
> > > delivering very low latencies, or natively over unmodified Linux
> > > kernels. In the latter case, the mainline kernel can be supplemented by
> > > the preempt-rt patch to meet stricter real-time requirements.
> > >
> > > The dual kernel configuration is currently supported over arm 32bit,
> > > powerpc32, powerpc64, x86_32, x86_64 and blackfin, with a port to
> > > aarch64 planned on Q1-2015. The single/native kernel configuration runs
> > > on any CPU architecture Linux supports.
> > >
> > > = What's new in Xenomai 3?
> > >
> > > http://xenomai.org/introducing-xenomai-3/
>
> and RTNET ?

As you can see in the archive, rtnet is not there. But the work is
not finished, that is what "candidate release" means.


--
					    Gilles.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 190 bytes
Desc: Digital signature
URL: <http://www.xenomai.org/pipermail/xenomai/attachments/20141006/d2cd8b32/attachment.sig>
