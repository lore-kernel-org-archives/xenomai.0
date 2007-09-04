From: Philippe Gerum <rpm@xenomai.org>
In-Reply-To: <46DC76CE.8000905@domain.hid>
References: <46DC149F.80307@domain.hid> <1188844344.28092.46.camel@domain.hid>
	<46DC76CE.8000905@domain.hid>
Content-Type: text/plain
Date: Tue, 04 Sep 2007 11:50:38 +0200
Message-Id: <1188899438.28092.123.camel@domain.hid>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: Philippe Gerum <philippe.gerum@domain.hid>
Subject: Re: [Xenomai-core] VxWorks skin is missing new VxWorks headers
	for	RTP
Reply-To: rpm@xenomai.org
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Ravid Baruch Naali <ravidbn@domain.hid>
Cc: xenomai@xenomai.org

On Tue, 2007-09-04 at 00:04 +0300, Ravid Baruch Naali wrote:
> I imagined thats the policy.
> 
> But is it worth investing time in? or is there higher priority task I
> can be assigned to?
> 

I don't think RTP is high priority for now.

Two other tasks would have a much more significant impact, both for
Xenomai users and developers.

1) Make Valgrind usable with Xenomai apps; of course without any
real-time guarantee anymore, but this would nevertheless plug a serious
hole in the development toolset available to users.

2) We do, certainly, definitely, desperately miss an automated way to
get performance charts for a few selected Xenomai tests, which would
allows us to conduct comparative analysis between versions, and find out
what's right or wrong with our changes.

For instance, we are currently maintaining seven architecture ports;
each time something changes in some part of Xenomai's generic code, we
have no freaking idea whether all archs benefit from such change, or if
at least no arch gets penalized by it. And the very same goes for the
interrupt pipeline, for which any hazardous change may generate adverse
effects on an even much larger scale. Let me put this bluntly: this
won't fly much longer; we are losing precious time getting rid of any
regression way after it has actually happened into the code, because we
cannot easily and routinely COMPARE how different versions behave. Aside
of this, we don't have any factual data regarding how Xenomai evolved
over time in terms of latency, code footprints and so on.

What we need is a simple automated way to a given test on any given
Xenomai version (actually a SVN commit number would be much better)
extracted from our repository, draw a few charts summing up the results,
and move those results to our website periodically or even as soon as
they are available. _This_ would help users to understand the current
trend and why we did some changes (or why we should not have done them),
and allow developers to pull the brake each time a serious regression is
visible from those charts.

Simple and easy:

TEST/x86: interrupt latency to kernel handler [latency -t2]

(latency in us)
^
|                                        x (XX us) <= Houston, we have a problem.
|      x (ZZ us)
|                                          
|                     x (YY us)
|                           
+--------------------------------------------------->
    commit#72  ...    commit#2004      commit#<any>
     (v2.0)              (v2.3)

Another test could analyse the task dispatch latency, another one the
code footprints in kernel space, and so on. Once this framework is
available, we would find the various hardware to run the tests on and
get the results from, that is not an issue anymore.

Besides, tackling this issue is quite a good way to have his feet wet
almost immediately with the Xenomai framework as a power user, and also
to get immediate reward for such work, since we would push its results
online routinely.

Please, somebody implement this, damnit! Or I'm going to rewrite the
entire Xenomai stack in Bourne shell with Java applets for speedups, so
you could not complain about bad latencies and unwanted overhead
anymore.

Thank you,

>  
> 
> 
> Philippe Gerum wrote:
> 
> > On Mon, 2007-09-03 at 17:05 +0300, Ravid Baruch Naali wrote:
> >   
> >> Hello again,
> >>
> >>
> >> Preface:
> >>
> >> As of VxWorks 6.x vxworks implement RTP which is an implementation of
> >> user space processes with real time capabilities, which of course
> >> include an extended API, which from my testings I discovered that we do
> >> not support yet.
> >>
> >>
> >> Currently extending the VxWorks API is not in Xenomai task list, does it
> >> have any demand?
> >>
> >> If I'll take it as a my task, do we have any legal issues with using
> >> Wind River's headers?
> >>     
> >
> > This matter is muddy; fair use, interoperability, and copyrights of
> > header files and/or their contents is a legal mess.
> >
> > Our policy is simple: paste-copy of any portion of any proprietary
> > licensed header is unwanted and will be systematically rejected. You
> > need to implement your own header, defining what you need for satisfying
> > all the references within the emulator your are writing from scratch.
> >
> > You should also explicitly mention in the copyright notice that the
> > resulting software is an emulator. We claim to mimick the original
> > software as correctly as possible, according to the API specs which have
> > been made publically available by the copyright holder of the original
> > work, with all the limitations inherent to such exercise. In any case,
> > we don't claim to produce a copy of the original software we only
> > emulate. In short, Xenomai is a Chameleon, not a clone.
> >
> >   
> >> If any of my assumptions is false or if you have any comment/answers
> >> please reply.
> >>
> >>
> >> thanks
> >>
> >> Ravid
> >>
> >>     
> 
> 
-- 
Philippe.



