Message-ID: <52D1896A.8070202@xenomai.org>
Date: Sat, 11 Jan 2014 19:11:54 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <44lhyrmuw9.fsf@be-well.ilk.org>
 <52CC7D71.4040703@steinkuehler.net> <52CC83F1.40000@xenomai.org>
 <52CC85C5.4060703@steinkuehler.net> <52CC8A18.2020807@xenomai.org>
 <52CCA101.2040604@steinkuehler.net>
 <3FA64D57-1BB1-4B4A-AB25-AC8E280105F8@mah.priv.at>
In-Reply-To: <3FA64D57-1BB1-4B4A-AB25-AC8E280105F8@mah.priv.at>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] i-pipe tracer on in production kernels? (was Re:
 Altera Cyclone V)
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Michael Haberler <mail17@mah.priv.at>
Cc: "xenomai@xenomai.org" <xenomai@xenomai.org>

On 01/11/2014 11:22 AM, Michael Haberler wrote:
> 
> http://www.xenomai.org/index.php/I-pipe:Tracer describes the trace
> API, which could be useful to track down issues
> 
> Q: does enabling the tracer incur significant overhead if compiled in
> but unused, or is it reasonable to leave it on in a production
> kernel?
> 
> if the former, we might have to build/make available a second i-pipe
> tracer enabled kernel to track down issues 'in the field'; if the
> latter, it'd be less build/distribution chores

Normally, with DYNAMIC_FTRACE, there should be a way to reduce the
overhead. Unfortunately, the I-pipe tracer disables DYNAMIC_FTRACE,
because at some point in the past, it did not work (with the I-pipe
tracer) on ARM. We could re-enable DYNAMIC_FTRACE and try and understand
why it does not work (if it still does not work), but that means you
would have to add patches on top of the I-pipe patch, because all I-pipe
patches released for some time, forbid DYNAMIC_FTRACE with the I-pipe
tracer, at least on ARM.

-- 
                                                                Gilles.

