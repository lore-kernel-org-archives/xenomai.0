Message-ID: <52D13631.2060100@xenomai.org>
Date: Sat, 11 Jan 2014 13:16:49 +0100
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

You should run some tests to answer that question: measure the latency
with tracer compiled-in but not enabled, and with tracer completely
disabled. I would expect to see a difference between the two
configurations, but I do not know if it would be very significant.

-- 
                                                                Gilles.

