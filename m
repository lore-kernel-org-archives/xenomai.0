Date: Mon, 3 Nov 2014 21:03:14 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Message-ID: <20141103200314.GE18422@sisyphus.hd.free.fr>
References: <94331816.zv1NYeHro4@riemann> <20141031200007.GC378@sumost.ca>
 <5454ADDF.4040604@xenomai.org> <6071747.2uXMl1ZSO0@riemann>
 <54573A6D.1030201@xenomai.org> <20141103155947.GA15262@sumost.ca>
 <5457AD81.7090200@xenomai.org> <20141103183747.GB15262@sumost.ca>
 <5457DF1C.4060209@xenomai.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5457DF1C.4060209@xenomai.org>
Subject: Re: [Xenomai] Message Pipe services behaviour
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Philippe Gerum <rpm@xenomai.org>
Cc: Xenomai@xenomai.org

On Mon, Nov 03, 2014 at 09:01:32PM +0100, Philippe Gerum wrote:
> On 11/03/2014 07:37 PM, Steve M. Robbins wrote:
> > On Mon, Nov 03, 2014 at 05:29:53PM +0100, Philippe Gerum wrote:
> > 
> >> Just to make sure we are on the same page, as Dietmar mentioned in an
> >> earlier mail, read() as implemented by the rt-pipe driver only returns
> >> _one_ message at a time, although > 1 could be pending. One has to
> >> iterate over a read() loop using a non-blocking fd on the /dev/rtp
> >> device to get them all.
> > 
> > Aha!  Thanks (and to Dietmar).  I completely missed this fact.  I'll
> > go re-write the read as a loop and see if it works better.  I should read
> > until the read() returns 0 (bytes read)?
> > 
> 
> Until you get -1 with errno == EWOULDBLOCK. Zero would rather mean that
> the other end of pipe has been disconnected, just like with a regular FIFO.
> 

Just a stupid question: should not calling select then read make as
long as there are some messages to read?

-- 
					    Gilles.

