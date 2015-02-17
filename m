From: "Lennart Sorensen" <lsorense@csclub.uwaterloo.ca>
Date: Tue, 17 Feb 2015 13:19:32 -0500
Message-ID: <20150217181932.GK30245@csclub.uwaterloo.ca>
References: <CALe7ZU0Y4hb0d7ANK9gitLLaQnGFiH8LpH3ZaTQ5MHLCYjAf=w@mail.gmail.com>
 <20150216092513.GA1914@hermes.click-hack.org>
 <20150217173314.GI30245@csclub.uwaterloo.ca>
 <20150217181133.GB17681@hermes.click-hack.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20150217181133.GB17681@hermes.click-hack.org>
Subject: Re: [Xenomai] rtdm_irq_request not registering irq
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: JAY KOTHARI <jaikothari10@gmail.com>, xenomai <xenomai@xenomai.org>

On Tue, Feb 17, 2015 at 07:11:33PM +0100, Gilles Chanteperdrix wrote:
> in 3.x
> 
> https://git.xenomai.org/xenomai-3.git/commit/?id=a8d0efffc57464b03e93e0d0f4308a34faed21c2
> 
> not yet fixed in 2.6 git.

OK, so that's a surprisingly small change for that bug.  I think it
makes sense.

> And if your irq chip uses the irq_startup callback:
> 
> https://git.xenomai.org/ipipe.git/commit/?id=b3f0bfe5fb1ee0ae079e281b44e591745d1c6c61

Ok, I thought it might be related.  Makes a lot of sense now.  I always
thought it odd that request_irq seemed to be required in addition to the
realtime call.  Nice to know why that was needed and that in the future
it won't be.

-- 
Len Sorensen

