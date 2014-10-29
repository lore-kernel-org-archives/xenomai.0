Date: Wed, 29 Oct 2014 08:26:29 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Message-ID: <20141029072629.GB14496@sisyphus.hd.free.fr>
References: <54365E17.3020102@xenomai.org>
 <CACreCV+QtwuhhGeFpnuLP-6Y1FfLCQHqNkrzyfwgqEgrxXU9eQ@mail.gmail.com>
 <5436607B.7090609@xenomai.org>
 <CACreCV+HdWC9Deysy2miL2NZ65RFVRRk87uG9rBaUBrn=hhqag@mail.gmail.com>
 <5436A64B.90705@xenomai.org>
 <CACreCVJUPiiX_7733g1EWZCVmUH0oFWhLknhKB2K8se1fi4a1g@mail.gmail.com>
 <20141022062825.GC29673@sisyphus.hd.free.fr>
 <CACreCVJSytzK85ANWmwWjctBpJfEr1b916R6dNPmSGugN_vRLA@mail.gmail.com>
 <20141029061655.GA14496@sisyphus.hd.free.fr>
 <CACreCVL2OyGYeWSOPAxR3rWG_RWiN3BAcPck1VyTMjyrASyNoQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACreCVL2OyGYeWSOPAxR3rWG_RWiN3BAcPck1VyTMjyrASyNoQ@mail.gmail.com>
Subject: Re: [Xenomai] Switchtest failures on ODROIDU3
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: GP Orcullo <kinsamanka@gmail.com>
Cc: Xenomai <xenomai@xenomai.org>

On Wed, Oct 29, 2014 at 03:24:52PM +0800, GP Orcullo wrote:
> On Wed, Oct 29, 2014 at 2:16 PM, Gilles Chanteperdrix
> <gilles.chanteperdrix@xenomai.org> wrote:
> > On Wed, Oct 29, 2014 at 09:23:16AM +0800, GP Orcullo wrote:
> >> Exynos is not using the arm global timers.
> >
> > I do not understand what you mean... You said you had problems
> > when the global timer was shared with Linux, this patches tries to
> > address that by not remapping the global timer for xenomai, and
> > sharing the mapping defined by Linux. And now you say Exynos is not
> > using the global timers? You will have to explain a bit more than
> > that... I quote what you said:
> >
> >> >> The problem was traced to the tsc emulation,  the counter somehow gets
> >> >> messed up when the global timer is shared with Linux.
> >
> >
> 
> Sorry, I was referring to the global timer that exynos uses - MCT,
> multi core timer.

Ok, but Xenomai on cortex A9 enables the global timer as soon as the
local timer is enabled. How do you get around this, you do not
enable the TWD code on exynos ?

-- 
					    Gilles.

