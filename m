Date: Wed, 25 Mar 2015 10:20:01 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Message-ID: <20150325092001.GI15125@hermes.click-hack.org>
References: <55127004.3010708@mitrol.it>
 <20150325083622.GF15125@hermes.click-hack.org>
 <55127908.5050202@mitrol.it>
 <20150325090354.GG15125@hermes.click-hack.org>
 <55127BB1.7040804@mitrol.it>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <55127BB1.7040804@mitrol.it>
Subject: Re: [Xenomai] fault in ppd_lookup_inner
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Paolo Minazzi <Paolo.Minazzi@mitrol.it>
Cc: xenomai@xenomai.org

On Wed, Mar 25, 2015 at 10:11:13AM +0100, Paolo Minazzi wrote:
> Il 25/03/2015 10:03, Gilles Chanteperdrix ha scritto:
> >On Wed, Mar 25, 2015 at 09:59:52AM +0100, Paolo Minazzi wrote:
> >>Il 25/03/2015 09:36, Gilles Chanteperdrix ha scritto:
> >>>On Wed, Mar 25, 2015 at 09:21:24AM +0100, Paolo Minazzi wrote:
> >>>>Hello all,
> >>>>I'm stressing an arm IMX6 boardwith
> >>>>- kernel 3.0.35
> >>>>- I-pipe 1.18-13
> >>>>- xenomai 2.6.3
> >>>Do you observe the same behaviour with Xenomai 2.6.4 ?
> >>>
> >>I have added all fix of 2.6.4 to my 2.6.3 (seeing changelog) but I have the
> >>same behaviour.
> >>It is not easy see the problem.
> >Why not simply testing 2.6.4, with everything, not only what appear
> >as fixes?
> >
> >Also, do you have the same problem if you dlopen something more
> >innocuous than libvncserver ?
> >
> I understand ... I port the fix to avoid compatililityproblem.
> I made only ksrc changes, so my user space is 100% compatible.

There is no compatibility problem between versions of a stable
branch. 2.6.4 is compatible with 2.6.0, 2.6.1, 2.6.2, 2.6.3. It is
even ABI compatible, you do not even have to recompile your
applications.

> I understand that you do not agree with me because you prefer a clean 2.6.4.
> I can try an other library. Do you mean a smaller library?

Any library that everybody has on his system, to allow reproducing
the issue. You could also try replacing the dlopen with a nanosleep.

> This is a strange test. I'm trying it because in the past I have had some
> memory corruption that make system instable.
> I would like to be sure about it.

I do not doubt that you observed an issue. I would simply like to be
sure that it has not already been fixed in Xenomai or the I-pipe
patch.

-- 
					    Gilles.

