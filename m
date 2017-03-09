Date: Thu, 9 Mar 2017 10:05:30 +0100
From: Henning Schild <henning.schild@siemens.com>
Message-ID: <20170309100530.1d5a4782@md1em3qc>
In-Reply-To: <ffae09d9-b277-24a7-8fd6-809e13ef8ba6@siemens.com>
References: <558D5FAD.3060003@siemens.com> <20170307193444.79df74cd@md1em3qc>
 <507e7a5d-284f-7098-7736-4644c4cd8b87@xenomai.org>
 <ffae09d9-b277-24a7-8fd6-809e13ef8ba6@siemens.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] Heads up: some race condition fixes for Xenomai 3
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Jan Kiszka <jan.kiszka@siemens.com>
Cc: Xenomai <xenomai@xenomai.org>

Am Wed, 8 Mar 2017 12:25:26 +0100
schrieb Jan Kiszka <jan.kiszka@siemens.com>:

> On 2017-03-08 09:54, Philippe Gerum wrote:
> > On 03/07/2017 07:34 PM, Henning Schild wrote:  
> >> Am Fri, 26 Jun 2015 16:20:29 +0200
> >> schrieb Jan Kiszka <jan.kiszka@siemens.com>:
> >>  
> >>> Hi,
> >>>
> >>> just pushed 3 patches to git.xenomai.org/xenomai-jki.git for-forge
> >>> that are supposed to fix race conditions while manipulating
> >>> xnthread::state and info (both need to be nklock-protected).
> >>> Please review if finding and fixes make sense.
> >>>
> >>>       cobalt/kernel: Fix locking for xnthread info manipulations
> >>>       cobalt/kernel: Fix locking for setting XNFPU
> >>>       cobalt/kernel: Rework thread debugging helpers
> >>>
> >>> Maybe some of the issues also exist in Xenomai 2, didn't check
> >>> yet.  
> >>
> >> After looking deeper into the the mysterious -EINTR i asked about
> >> a few days ago we now got a trace that suggests something is going
> >> wrong. Jan remembered the race in thread flag manipulation he
> >> found in Xeno3.
> >>
> >> I did not do a thorough code analysis yet but instead just put two
> >> asserts into xnthread_set_info and xnthread_clear_info.
> >> 1. !xnlock_is_owner(&nklock)
> >> 2. xnpod_current_thread() != thread_to_update
> >>
> >> Both cases do happen. The flags are manipulated without holding the
> >> lock and the flags are manipulated from another context. I guess
> >> that suggests that the race found in xenomai3 is also in xenomai2.
> >>  
> > 
> > I would not compare both code bases. Much rewrite took place from
> > the legacy nucleus to the cobalt core.
> > 
> > I have reviewed every single statement involving set/clear info
> > bits in 3.x and I can't seem to find any unlocked access for those.
> > Any specifics about the exact locations where your debug statements
> > trigger? 
> 
> One quickly discoverable example is in xnshadow_harden
> (xnthread_set/clear_info(curr, XNATOMIC) without nklock protection).
> And Henning also confirmed that the info field is not used only
> thread-locally, though I don't have his finding in mind. I could
> imagine, though, that do_sigwake_event would make a good one.

Here some information to what i found with the two assertions:

Xenomai: nklock not held while calling xnthread_set_info info 0 40
xnshadow_harden

Xenomai: nklock not held while calling xnthread_set_info info 0 100
xnshadow_map

Xenomai: current thread ffffffff81bb7600 != thread ffffc900001eb440
when calling xnthread_set_info info 0 40
xnshadow_harden

Xenomai: current thread ffffffff81bb7600 != thread ffffc900001eb440
when calling xnthread_set_info info 0 100
xnshadow_map

So as Jan said, XNATOMIC (0x40) in _harden and XNPRIOSET (0x100) in
_map. Both are used without locking and to manipulate remote threads.
But those are just samples from a few runs, there may be more cases.

Henning

> So I'm pretty sure we have the same issue in Xenomai 2 as in 3. Too
> bad I didn't follow up on the backport topic back then. Do you see any
> reasons why that could be complicated?
>
> 
> Jan
> 


