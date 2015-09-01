Date: Tue, 1 Sep 2015 21:44:51 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Message-ID: <20150901194451.GB32489@hermes.click-hack.org>
References: <CAJqUr7ybpmgOev-iPaQ-iMEAF8SBocn54vyYSbLcm9spMY=FBg@mail.gmail.com>
 <55E5E453.1080400@xenomai.org>
 <CAPuu0=jX6ig5L7SJrmPVOhCmOm=gwxEmTafTpOqzE85hOji8CA@mail.gmail.com>
 <55E5F849.1070708@xenomai.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <55E5F849.1070708@xenomai.org>
Subject: Re: [Xenomai] xenomai/ipipe arm64 port
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Jorge Ramirez Ortiz <jro@xenomai.org>
Cc: "xenomai@xenomai.org" <xenomai@xenomai.org>

On Tue, Sep 01, 2015 at 03:11:05PM -0400, Jorge Ramirez Ortiz wrote:
> On 09/01/2015 02:27 PM, Dmitriy Cherkasov wrote:
> > We have seen this before, but so far have not found a way to consistently
> > reproduce it.
> > 
> > There are some caveats with the current way context switching is done in Xenomai.
> > 
> > On armv7, there was a completely separate implementation of
> > xnarch_switch_to(), as well as separate fpu and TLS switching.
> > At this stage for armv8 however, we are doing a direct call to
> > the kernel's __switch_to(), which then performs the relevant
> > register switches.

On arm 32 bits, the only difference between xnarch_switch_to and
switch_to is the FPU switch, IIRC, switch_to triggers a notifier
which I believe can not be called from primary domain. Or maybe it
can, but the FPU switch, can not be the same as Xenomai "FPU state
state machine", does not work the same as Linux.

-- 
					    Gilles.
https://click-hack.org

