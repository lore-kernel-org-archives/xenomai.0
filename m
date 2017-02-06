Date: Mon, 6 Feb 2017 14:48:27 +0100
From: Henning Schild <henning.schild@siemens.com>
Message-ID: <20170206144827.0cd3be85@md1em3qc>
In-Reply-To: <23ea482b-c048-8190-e152-045255621def@xenomai.org>
References: <20170126155926.594b8e2b@md1em3qc>
 <20170127135222.28440-1-henning.schild@siemens.com>
 <20170127150422.6aef6bfd@md1em3qc>
 <437e7b70-9681-ac26-38bb-e528ea6a4831@xenomai.org>
 <20170127153652.36d0bb74@md1em3qc>
 <23ea482b-c048-8190-e152-045255621def@xenomai.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] [PATCH] testsuite/switchtest/x86: allow in kernel-FPU
	testing
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Philippe Gerum <rpm@xenomai.org>
Cc: xenomai@xenomai.org

On Thu, 2 Feb 2017 10:43:33 +0100
Philippe Gerum <rpm@xenomai.org> wrote:

> On 01/27/2017 03:36 PM, Henning Schild wrote:
> > On Fri, 27 Jan 2017 15:10:59 +0100
> > Philippe Gerum <rpm@xenomai.org> wrote:
> >   
> >> On 01/27/2017 03:04 PM, Henning Schild wrote:  
> >>> On Fri, 27 Jan 2017 14:52:22 +0100
> >>> Henning Schild <henning.schild@siemens.com> wrote:
> >>>     
> >>>> Not running the in-kernel FPU tests while Linux might be using
> >>>> the FPU in kernel-mode is a safeguard measure for development
> >>>> versions that might still have issues with FPU context
> >>>> switching. i.e. it prevents data corruption on RAIDs beeing
> >>>> triggered by an FPU Bug. In a bug-free kernel running the
> >>>> switchtest in kernel-mode is not a problem and may be desired
> >>>> for proper test-coverage.
> >>>>
> >>>> This patch introduces a command line option to switchtest to
> >>>> allow overriding the safeguard.    
> >>>
> >>> I am not sure i am happy with this solution either. Actually the
> >>> test should always run as part of the unit tests. It is very
> >>> valuable and skipping it "silently" is a really bad idea.
> >>> If it is really just disabled for when it might mess with your
> >>> raid on the machine you do kernel development on, maybe you
> >>> should not use such a machine for that?
> >>> So i am starting to think the test should run by default and the
> >>> conservative version should be opt-in instead of opt-out.
> >>>     
> >>
> >> A conservative version can only be opt-out, otherwise people may
> >> run into damages without knowing, which would defeat the intent of
> >> picking the conservative approach.  
> > 
> > There should at least be a prominent notice that an important test
> > was skipped. The once-printk is just not the right place. Maybe the
> > whole testcase should fail instead so that people have to say
> > --kfpu-may-be-skipped  
> 
> That sounds like a fair compromise.

I also like that better than what the current patch does.

> > 
> > Maybe i still did not fully understand why the test gets skipped. I
> > have seen CONFIG_CIFS_SMB2 trigger the FPU problem in the broken
> > 4.1. Would that be a reason to add that to the list of switches
> > skipping the test? Or is the whole thing really just there to
> > protect devs from messing up their raids?  
> 
> I seem to remember that Gilles and I eventually agreed a long time ago
> on skipping those tests, due to the impossibility for us to reach a
> proper test coverage for fpu in kernel space when those options are
> enabled, with potentially hard damages upon bugs (e.g. RAID). Given
> that fpu support in kernel space over real-time threads was already
> deprecated at that time, we did not see any point in making the test
> and maintenance process even more complex to keep it as a first class
> citizen.
> 
> > I do not see who does kernel development on a machine so valueable
> > to justify skipping such an important test for everyone.
> >   
> 
> Well, I must admit that I would not run a development version of any
> kernel code on a system which holds critically important data either.
> But I don't think that we can impose such a restriction on people
> competing for the Darwin Awards.
> 
> >> I'm still pondering whether this test makes sense in 3.x, given
> >> that official support for running fpu ops over rt threads in
> >> kernel space was dropped for that version. Too much of a mess.  
> > 
> > Ok, i am actually again looking primarily at xenomai-2 and was
> > planning on backporting whatever we come up with.
> >   
> 
> I'm ok with pushing this to the 2.x branch, but then I'll cowardly let
> you deal with any follow up from the user base regarding this.

Well if we do not need that in Xeno3 because there are no in-cobalt
fpu-threads anymore, than i guess we can forget about that patch.

It would only be useful for more kernel updates with Xeno2. So lets
forget about that one for now. We can revisit it in the unlikely event
of a Xeno2 kernel 4.4+ effort.

Henning


