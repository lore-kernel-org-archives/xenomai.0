Date: Fri, 10 Apr 2015 20:55:11 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Message-ID: <20150410185511.GT20752@hermes.click-hack.org>
References: <CAJZRki9RpfcQQ+c8oz1bJ7RsFQE4MrsQdULxvHAuh-STi0fhkQ@mail.gmail.com>
 <20150409210713.GH20752@hermes.click-hack.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20150409210713.GH20752@hermes.click-hack.org>
Subject: Re: [Xenomai] Why does mqueue.h define mqd_t as unsigned
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Phil Mitchell <p.mitch@gmail.com>
Cc: Xenomai Mailing List <xenomai@xenomai.org>

On Thu, Apr 09, 2015 at 11:07:13PM +0200, Gilles Chanteperdrix wrote:
> On Thu, Apr 09, 2015 at 04:52:26PM -0400, Phil Mitchell wrote:
> > Dear All,
> > 
> > mqueue.h defines mqd_t as an unsigned long. The function mq_open returns
> > type mqd_t and states that -1 is returned in case of error.
> > 
> > Is mqd_t defined incorrectly or am I missing something?
> 
> The specification does not say what mqd_t should be and says that
> mq_open returns (mqd_t)-1, not -1, and (unsigned long)-1 is valid,
> so, this is valid even if a bit strange. mqd_t is an opaque type for
> the user anyway, so its actual type should not matter to you.
> 
> But in fact we do not even need a long type since what is returned
> is a file descriptor, so, we could have typedef int mqd_t like
> glibc.

In fact mqd_t is already an int in the following case:
- in kernel-space where it gets defined by kernel/types.h
- in user-space when the glibc has mqueue.h, since then include that
header.

The only remaining cases where we use unsigned long are:
- glibc without an mqueue.h, but I believe they are rare now a days
- when compiling for xeno-sim, which has been unusable with recent
compilers for years now.

So, I think we do not care.

-- 
					    Gilles.

