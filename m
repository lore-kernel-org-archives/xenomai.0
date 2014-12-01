From: "Lennart Sorensen" <lsorense@csclub.uwaterloo.ca>
Date: Mon, 1 Dec 2014 18:57:25 -0500
Message-ID: <20141201235725.GK24110@csclub.uwaterloo.ca>
References: <314E5ECDAA86314791309FA670550F89C9C4FD8A@SINTEFEXMBX05.sintef.no>
 <20141201151951.GG24110@csclub.uwaterloo.ca>
 <20141201153057.GJ23220@hermes>
 <20141201233554.GI24110@csclub.uwaterloo.ca>
 <20141201233720.GJ28038@hermes>
 <20141201235043.GJ24110@csclub.uwaterloo.ca>
 <20141201235536.GK28038@hermes>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20141201235536.GK28038@hermes>
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
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: "xenomai@xenomai.org" <xenomai@xenomai.org>

On Tue, Dec 02, 2014 at 12:55:36AM +0100, Gilles Chanteperdrix wrote:
> What I mean is that if you are writing a driver and you care about
> irq latency, this information is important, it tells you can not pin
> the irq handler to a particular core, and so that if you plan to
> have a good latency, you should probably find an irq source which is
> directly tied to the GIC, and avoid the GPIOs.

That is certainly true.  The gpio irqs on the omap chips really seem
most suited to things like push buttons and cable connected detection
and such where speed isn't an issue.

-- 
Len Sorensen

