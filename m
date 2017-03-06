Date: Mon, 6 Mar 2017 13:00:19 +0100
From: Henning Schild <henning.schild@siemens.com>
Message-ID: <20170306130019.4a142b63@md1em3qc>
In-Reply-To: <45d853f4-7f82-3d1c-40a6-914df5e90c54@xenomai.org>
References: <20170303151838.35652dab@md1em3qc>
 <45d853f4-7f82-3d1c-40a6-914df5e90c54@xenomai.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] any extra reasons for -EINTR in xenomai
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Philippe Gerum <rpm@xenomai.org>
Cc: "xenomai@xenomai.org" <xenomai@xenomai.org>

Am Fri, 3 Mar 2017 16:57:04 +0100
schrieb Philippe Gerum <rpm@xenomai.org>:

> On 03/03/2017 03:18 PM, Henning Schild wrote:
> > Hi,
> > 
> > someone came to me asking about reasons why system calls would exit
> > with -EINTR on a xenomai 2 system. As far as i know there a are two
> > possible reasons for that to happen.
> > 1. the thread received a signal while being blocked in the call
> > 2. the thread got a rt_task_unblock
> > 
> > Now we are pretty sure that we can rule out both of these cases. It
> > is a complex system and there might be signals. But none of the
> > applications signal handlers was called and the application did not
> > exit, which only leaves very few signals as candidates. Because
> > almost all default signal handlers will end an application.
> > And my current assumption would be that default signal handlers
> > all have SA_RESTART and there would be no -EINTR. Which limits the
> > possible signals to the ones where a custom handler was installed
> > and SA_RESTART was not set. But according to the logs no custom
> > handler was called.
> > 
> > We know it happened while being blocked in rtdm_event_timedwait and
> > the documentation mentions the two reasons from above.
> >   
> 
> Somebody has to raise the XNBREAK bit in the tcb for this to happen,
> i.e. xnthread_set_info(thread, XNBREAK). There are four locations in
> the nucleus doing that, two of them happen in do_sigwake_event().
> Tracing there would rule out the consequence of receiving a regular
> signal.
> 
> In a related case, entering xnpod_suspend_thread() in a runnable state
> with the XNKICKED bit set would also cause the XNBREAK bit to be set,
> preventing the caller to block. This should only happen if a signal is
> raised from another CPU while the caller is traversing the Xenomai
> syscall path.
> 
> Finally, there is xnpod_unblock_thread() but that one won't be called
> unless the application forcibly unblocks a thread, which you already
> ruled out.

Thanks for the analysis. I looked at the code myself and came to the
same conclusion. To sum this up the first 3/4 are signal-related and
the 4th one is rt_task_unblock.
And looking at rtdm_event_timedwait it can clearly just happen under
that one condition (XNBREAK).

So i guess we are looking at a signal after all.

Henning






