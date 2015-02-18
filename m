Date: Wed, 18 Feb 2015 15:54:40 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Message-ID: <20150218145440.GA30317@hermes.click-hack.org>
References: <54E456AE.8070003@free.fr>
 <20150218092420.GA25957@hermes.click-hack.org>
 <54E4795F.50309@siemens.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <54E4795F.50309@siemens.com>
Subject: Re: [Xenomai] AMD G/R serie
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Jan Kiszka <jan.kiszka@siemens.com>
Cc: "xenomai@xenomai.org" <xenomai@xenomai.org>

On Wed, Feb 18, 2015 at 12:37:03PM +0100, Jan Kiszka wrote:
> On 2015-02-18 10:24, Gilles Chanteperdrix wrote:
> > On Wed, Feb 18, 2015 at 10:09:02AM +0100, St??phane ANCELOT wrote:
> >> Hi,
> >> Is xenomai available for those platforms?
> >>
> >> AMD G or R series
> > 
> > What architectures are these beasts ? If x86, then yes, Xenomai
> > should work, and if it does not, it should not be hard to get it to work.
> 
> Yes, they are plain x86. No fundamental problems, but surprises can
> always happen.
> 
> I recently did some general latency testings (not with Xenomai, though)
> on the AMD-G series board we have here. The results still require closer
> examinations, but they were not as good as on usual x86 boxes (a few 10
> micros slower). That may be related to the specific board or bios, though.

If they are embedded/low power stuff, it probably makes more sense
to compare them with intel atom than with "usual x86 boxes". Unless
you consider atoms as usual. The typical worst case latency I get on
an intel atom 230 (admittedly not the most recent one) is around 30
us, the large latency being due to the time it takes to mask irqs at
IO-APIC level (ISTR I had found out that this went through the LPC
bus, which is obviously not designed for speed).

The latest benchmark I did may be found here:
https://xenomai.org/2014/08/benchmarks-xenomai-dual-kernel-over-linux-3-14/#on_x86

-- 
					    Gilles.

