Date: Tue, 2 Dec 2014 00:55:36 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Message-ID: <20141201235536.GK28038@hermes>
References: <314E5ECDAA86314791309FA670550F89C9C4FD8A@SINTEFEXMBX05.sintef.no>
 <20141201151951.GG24110@csclub.uwaterloo.ca>
 <20141201153057.GJ23220@hermes>
 <20141201233554.GI24110@csclub.uwaterloo.ca>
 <20141201233720.GJ28038@hermes>
 <20141201235043.GJ24110@csclub.uwaterloo.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20141201235043.GJ24110@csclub.uwaterloo.ca>
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

On Mon, Dec 01, 2014 at 06:50:43PM -0500, Lennart Sorensen wrote:
> On Tue, Dec 02, 2014 at 12:37:20AM +0100, Gilles Chanteperdrix wrote:
> > On Mon, Dec 01, 2014 at 06:35:54PM -0500, Lennart Sorensen wrote:
> > > On Mon, Dec 01, 2014 at 04:30:57PM +0100, Gilles Chanteperdrix wrote:
> > > > On the other hand, this is just a warning, it does not prevent the
> > > > system from working, and this warning warns us about a real problem:
> > > > we can not set the irq affinity of this driver.
> > > 
> > > It was ugly and just a warning so I commented it out.
> > > 
> > > I don't think the hardware has any way to do affinity, so it can't be
> > > fixed, so the warning doesn't help.
> > 
> > Yes, but now you know it, without the message, you would not know it.
> 
> True, but it sure looks terrible in the logs given it looks about the
> same as a kernel crash.

To the uninformed yes. Kernel bugs begin with "BUG", kernel faults
(which would be what is nearest from a kernel crash) begin with
"Unhandled fault in kernel mode". Not with "Warning:".

> 
> And I still don't think there is anything that can be done about it.
> You can set the affinity of the GIC irq for the whole GPIO bank, but
> not for the individual pins of the gpio bank.

What I mean is that if you are writing a driver and you care about
irq latency, this information is important, it tells you can not pin
the irq handler to a particular core, and so that if you plan to
have a good latency, you should probably find an irq source which is
directly tied to the GIC, and avoid the GPIOs.

-- 
					    Gilles.

