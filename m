Date: Mon, 17 Nov 2014 21:27:54 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Message-ID: <20141117202754.GI31920@sisyphus.hd.free.fr>
References: <20141001142416.GA4435@csclub.uwaterloo.ca>
 <20141107182600.GS24110@csclub.uwaterloo.ca>
 <545D12D2.2020104@xenomai.org>
 <20141117191237.GS24110@csclub.uwaterloo.ca>
 <20141117201435.GH31920@sisyphus.hd.free.fr>
 <20141117202425.GU24110@csclub.uwaterloo.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20141117202425.GU24110@csclub.uwaterloo.ca>
Subject: Re: [Xenomai] I-pipe error when requesting irq that is on omap gpio
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Lennart Sorensen <lsorense@csclub.uwaterloo.ca>
Cc: xenomai@xenomai.org

On Mon, Nov 17, 2014 at 03:24:25PM -0500, Lennart Sorensen wrote:
> On Mon, Nov 17, 2014 at 09:14:35PM +0100, Gilles Chanteperdrix wrote:
> > Well, have you tried triggering an I-pipe tracer trace to see what
> > happens in the interval?
> 
> I have never used the tracer. I suppose I should learn how.

It is not very complicated. I have already been told on this list
that it was not well documented. I do not think so, but I let you
judge of that.

http://xenomai.org/2014/06/using-the-i-pipe-tracer/

> 
> Any plans to merge that syscall.c fix into xenomai-2.6's tree for future
> 2.6.x releases?

Yes, that is, assuming there will be a future Xenomai 2.6 release. 

-- 
					    Gilles.

