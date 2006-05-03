Message-ID: <4458A245.5000006@domain.hid>
Date: Wed, 03 May 2006 14:29:57 +0200
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
Subject: Re: [Xenomai-help] Buffer Overrun -> Kernel Explosion
References: <6ee4c8380604272202q3109a3b9n71e0327de76730b8@domain.hid>
	<44589714.10800@domain.hid>
In-Reply-To: <44589714.10800@domain.hid>
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Jan Kiszka <jan.kiszka@domain.hid>
Cc: xenomai@xenomai.org, "Brian L." <bluczkie@domain.hid>

Jan Kiszka wrote:
> Brian L. wrote:
> 
>>I'm finally set up with netconsole to catch panics/crashes when they
>>happen so now I can report more information on the one I alluded to a
>>week or two ago in my "General Question.." thread.
>>
>>What I did to cause it was write past the end of a buffer returned by
>>rt_queue_alloc. I'm not entirely sure if this message came at the
>>moment of the write (unlikely, IMHO) or later when more xnheap
>>activity took place. The crash popped up in several different ways
>>depending on what code paths I enabled/disabled.
>>
>>What concerns me is that polluting an xnheap can bring the system to
>>its knees so harshly. I can see why it could be *very* hard to police
>>this sort of problem without destroying the performance of xnheap, so
>>it wouldn't surprise me if this is "normal". Still, though, it's sad
>>that user-space code can bring the system down after something as
>>innocent as a fencepost error in a string copy routine...
>>
>>Thoughts? I've pasted the console dump below.
>>
> 
> 
> I remember that control structures and data are tightly knotted in
> xnheaps, but I agree with you that this should not lead so easily to
> such crashes for user space apps. Maybe some magic number check could
> help to reduce the chance for now.
> 
> A cleaner long-term solution would be to decouple both regions.
> Philippe, is this feasible (I'm not that deep in the internals of xnheap)?
> 

Almost everything could be done, with the proper overhead, I mean. As 
you know, there are quite a number of ways to kill your box with RT 
activity, even without trashing Xenomai's internal data structures. 
Causing a fencepost error when copying data that trashes other crucial 
application data comes to mind, which in turns might cause all sort of 
weird behaviours, including hard lockups due to unexpected infinite 
loops; this might also happen whether the system data are isolated in a 
write protected segment or not. The same goes with plain MMIO areas, 
just write garbage over such memory which might have I/O side-effects, 
and watch the box go south, no need for Xenomai here.

Since providing isolated individual data buffers is out of question for 
obvious performance reasons, rt_queue_read/write introduced in 2.2 
provide a way to send/receive data blocks without having to share the 
memory with the heap, at the expense of the data being transfered 
to/from kernel space during the calls.

In contrast, rt_queue_send/receive have been designed to handle the 
internal buffer space immediately, so that applications could prepare 
significant amount of data directly into it before transmission, which 
saves the ultimate copy to transfer the buffer, at the expense of being 
able to access the entire heap memory with no particular protection too. 
As our friend Spider-Man says, "With great power comes great 
responsibility".

-- 

Philippe.

