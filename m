References: <57226422.2010707@mitre.org>
 <20160429195415.GQ1881@hermes.click-hack.org>
From: Jeffrey Melville <jmelville@mitre.org>
Message-ID: <5723CD41.4070809@mitre.org>
Date: Fri, 29 Apr 2016 17:08:17 -0400
MIME-Version: 1.0
In-Reply-To: <20160429195415.GQ1881@hermes.click-hack.org>
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] Clarification on EINTR with wrapped select call.
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: "xenomai@xenomai.org" <xenomai@xenomai.org>

On 4/29/2016 3:54 PM, Gilles Chanteperdrix wrote:
> On Thu, Apr 28, 2016 at 03:27:30PM -0400, Jeffrey Melville wrote:
>> Hi,
>>
>> I wanted to clarify the expected behavior that would cause a wrapped
>> select() call to return EINTR when using the POSIX skin.
>>
>> I'm running Xenomai 2.6.4 (actually 2.6 git rev 4f349cf0553, with a99426
>> cherry-picked) with kernel 3.14.17 on a Zynq and the POSIX skin.
>>
>> We have a real-time thread (SCHED_FIFO, nonzero priority) that
>> frequently calls (wrapped) select() on a normal Linux UDP socket. We've
>> noticed that sometimes, when data is available on the socket, the call
>> to select will return -1 with errno EINTR. There is no other evidence in
>> the user application that a signal occurred. I suspect that it may be
>> related to SIGWINCH/SIGHARDEN but I don't know how this works in much
>> detail. I haven't been able to confirm this theory yet either. I see
>> that select does not have to respect SA_RESTART.
>>
>> With that in mind:
>> 1. Is it expected that a wrapped select() call returns EINTR during
>> normal mode transitions? It doesn't seem right to me.
> 
> Well, first, calling the wrapped select on plain linux descriptors
> is kind of stupid: Xenomai core will migrate the task to primary

I guess that's fair. In reality, the task is calling into a library
function for a library that we also link against Xenomai in this case.
The library is used on non-Xenomai systems (for different applications)
as well and I have tried to minimize the number of ifdefs, leaving plain
'select' etc. calls until I have a need to change it.

> mode, in order to execute the syscall, which will say "there is a
> linux file descriptor in that set, let us handle it with plain linux
> syscall", so the wrapped select call will call the plain linux
> select syscall which will cause the thread to switch to secondary

I didn't realize it always caused two mode switches until I looked at
the code further. I figured that the detection of plain Linux fds
happened in the userspace __wrap_select. Is that impossible because
userspace doesn't know where RTDM fds start?

> mode (and get a SIGDEBUG signal if it has enabled PTHREAD_WARNSW).
> Second, EINTR is very much likely returned by the 
> plain linux select syscall, and not by Xenomai syscall. Third, is
> not it because you have enabled PTHREAD_WARNSW on that thread?

I agree that EINTR is most likely being returned by the Linux select
syscall, but am not entirely clear where the signal is coming from.
PTHREAD_WARNSW is not enabled on this thread.
> 
>>
>> 2. If this isn't the expected behavior, what would you recommend as a
>> next debugging step? I suspect that handling every SIGWINCH will result
>> in a lot of noise.
> 
> I would recommend using __real_select with fdset containing only
> Linux file descriptors, in order to avoid the two mode switches per
> call. You can not mix Linux file descriptors with Xenomai file
> descriptors in fdset anyway, and have to have separate select loops
> for the two types of descriptors, as outlined here:
> https://xenomai.org/2014/08/porting-a-linux-application-to-xenomai-dual-kernel/#IO_multiplexing_with_select
Yeah, understood that mixing fds is bad news. RTDM descriptors are
multiplexed in a different thread. The sets aren't in any way related,
so the other caveats don't apply here. __real_select is probably the
easiest solution, even though I had tried to avoid it due to the reasons
above.
> 
> Regards.
> 
Thanks for your response,
Jeff

