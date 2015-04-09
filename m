Date: Fri, 10 Apr 2015 00:29:14 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Message-ID: <20150409222914.GJ20752@hermes.click-hack.org>
References: <CAJZRki9RpfcQQ+c8oz1bJ7RsFQE4MrsQdULxvHAuh-STi0fhkQ@mail.gmail.com>
 <oqegntropy.fsf@merlin.sez.to>
 <20150409220956.GE29558@csclub.uwaterloo.ca>
 <20150409221718.GI20752@hermes.click-hack.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20150409221718.GI20752@hermes.click-hack.org>
Subject: Re: [Xenomai] Why does mqueue.h define mqd_t as unsigned
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Lennart Sorensen <lsorense@csclub.uwaterloo.ca>
Cc: Xenomai Mailing List <xenomai@xenomai.org>

On Fri, Apr 10, 2015 at 12:17:18AM +0200, Gilles Chanteperdrix wrote:
> On Thu, Apr 09, 2015 at 06:09:56PM -0400, Lennart Sorensen wrote:
> > On Thu, Apr 09, 2015 at 02:11:53PM -0700, Paul Janzen wrote:
> > > Phil Mitchell <p.mitch@gmail.com> writes:
> > > 
> > > > mqueue.h defines mqd_t as an unsigned long. The function mq_open returns
> > > > type mqd_t and states that -1 is returned in case of error.
> > > >
> > > > Is mqd_t defined incorrectly or am I missing something?
> > > 
> > > The man page says mq_open returns (mqd_t)(-1) on error. If you include
> > > that cast when you test the return value it works, even if mqd_t is
> > > unsigned.  (Or a pointer.)
> > 
> > Yuck!
> > 
> > Some of us try to avoid explicit casts since they are a great way to
> > hide bugs in ways the compiler can't help you find.
> > 
> > Making a cast required by design seems like a major design bug that
> > ought to be fixed.
> 
> This design is specified by POSIX. This looks like a "fighting the
> windmill" case.

I think the upside of this design is that it allows mqd_t being
implemented as a pointer or as an integer, this gives freedom to the
implementer by making the type opaque.

-- 
					    Gilles.

