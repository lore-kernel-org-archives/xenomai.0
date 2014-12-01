Date: Tue, 2 Dec 2014 00:37:20 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Message-ID: <20141201233720.GJ28038@hermes>
References: <314E5ECDAA86314791309FA670550F89C9C4FD8A@SINTEFEXMBX05.sintef.no>
 <20141201151951.GG24110@csclub.uwaterloo.ca>
 <20141201153057.GJ23220@hermes>
 <20141201233554.GI24110@csclub.uwaterloo.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20141201233554.GI24110@csclub.uwaterloo.ca>
Subject: Re: [Xenomai] WARNING: at arch/arm/kernel/ipipe.c:157
 ipipe_set_irq_affinity+0x47/0x70()
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Lennart Sorensen <lsorense@csclub.uwaterloo.ca>
Cc: "xenomai@xenomai.org" <xenomai@xenomai.org>

On Mon, Dec 01, 2014 at 06:35:54PM -0500, Lennart Sorensen wrote:
> On Mon, Dec 01, 2014 at 04:30:57PM +0100, Gilles Chanteperdrix wrote:
> > On the other hand, this is just a warning, it does not prevent the
> > system from working, and this warning warns us about a real problem:
> > we can not set the irq affinity of this driver.
> 
> It was ugly and just a warning so I commented it out.
> 
> I don't think the hardware has any way to do affinity, so it can't be
> fixed, so the warning doesn't help.

Yes, but now you know it, without the message, you would not know it.

-- 
					    Gilles.

