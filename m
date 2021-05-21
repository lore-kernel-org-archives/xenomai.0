Subject: Re: xnsched_kick
References: <CAK6DXL2H4OuDGehPaHwDtArtg=Y2H+xs6eC49_9NueYPtxRCHA@mail.gmail.com>
 <87zgwocfoy.fsf@xenomai.org>
From: Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <64d36bcd-5459-6224-da92-5ac7c30128d8@siemens.com>
Date: Fri, 21 May 2021 17:13:54 +0200
MIME-Version: 1.0
In-Reply-To: <87zgwocfoy.fsf@xenomai.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Philippe Gerum <rpm@xenomai.org>, Marco Barletta <barlettamarco8@gmail.com>
Cc: xenomai@xenomai.org

On 21.05.21 16:41, Philippe Gerum via Xenomai wrote:
> 
> Marco Barletta via Xenomai <xenomai@xenomai.org> writes:
> 
>> Hi everyone, related to the sched_quota patch I posted about one week ago.
>> I'm trying to understand why xnsched_kick is needed, in which situation is
>> called. Reading the code it seems it's called when there's a xeno thread
>> that must be downgraded and scheduled in Linux, but I didn't understand why
>> there's the need to run to complention without respecting group budget. Can
>> you help me?
>> Best regards.
> 
> When a thread is forcibly kicked out of oob context by the core, this
> means that it ought to move quickly to in-band context in order to
> respond to a pending kernel event, such as handling a signal. e.g. we
> use xnthread_kick() to force a thread which is being sent a SIGTRAP
> signal by a debugger, to receive that signal - otherwise bad things may
> happen kernel-wise.
> 
> With that in mind, what would happen if a SCHED_QUOTA thread is kicked
> out, but belongs to a group which is given no runtime credit? Typically,
> the user might set the quota limit to 0% for any group. In that case,
> any thread from that group would be prevented from resuming, therefore
> could not honor the request for switching back to in-band mode asap,
> which is the only way to secure the handling of a pending kernel event
> (again, such as a pending signal). To prevent this, every scheduler
> module which might cause a thread to have no execution time due to its
> policy must implement the sched_kick handler so that we have a bypass
> method for that particular case.
> 
> SCHED_TP has no sched_kick handler because under such a policy, there is
> no provision for permanently depriving a thread of execution time. At
> worst, that thread would have to wait for a complete global time frame
> to elapse before receiving renewed runtime credit. This implies that we
> do expect the global time frame not to last for an unreasonably long
> time, which has been a safe bet for SCHED_TP so far.
> 

Thanks for the explanation! Would someone like to write a comment patch
for the quota sched handler?

Jan

-- 
Siemens AG, T RDA IOT
Corporate Competence Center Embedded Linux

