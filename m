Subject: Re: [lttng-dev] Using lttng-ust with xenomai
References: <CADYdroN-i9yrpd-wjPSW36GUptRV+kOCJT=Yv6+Z5sCVBmo_SQ@mail.gmail.com>
 <2012667816.853.1574437363737.JavaMail.zimbra@efficios.com>
 <4aab99be-5451-4582-f75d-7637614b1d37@siemens.com>
 <480743920.929.1574442078799.JavaMail.zimbra@efficios.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <f25860cc-e5b6-ae89-1a21-b85093291398@siemens.com>
Date: Fri, 22 Nov 2019 18:36:54 +0100
MIME-Version: 1.0
In-Reply-To: <480743920.929.1574442078799.JavaMail.zimbra@efficios.com>
Content-Type: text/plain; charset=utf-8; format=flowed
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
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Norbert Lange <nolange79@gmail.com>, lttng-dev <lttng-dev@lists.lttng.org>, paulmck <paulmck@kernel.org>, Xenomai <xenomai@xenomai.org>

On 22.11.19 18:01, Mathieu Desnoyers wrote:
>>>>
>>>> ## membarrier syscall
>>>>
>>>> I haven't got an explanation yet, but I believe this syscall does
>>>> nothing to xenomai threads (each has a shadow linux thread, that is
>>>> *idle* when the xenomai thread is active).
>>>
>>> That's indeed a good point. I suspect membarrier may not send any IPI
>>> to Xenomai threads (that would have to be confirmed). I suspect the
>>> latency introduced by this IPI would be unwanted.
>>
>> Is an "IPI" a POSIX signal here? Or are real IPI that delivers an
>> interrupt to Linux on another CPU? The latter would still be possible,
>> but it would be delayed until all Xenomai threads on that core eventual
>> took a break (which should happen a couple of times per second under
>> normal conditions - 100% RT load is an illegal application state).
> 
> I'm talking about a real in-kernel IPI (as in inter-processor interrupt).
> However, the way sys_membarrier detects which CPUs should receive that IPI
> is by iterating on all cpu runqueues, and figure out which CPU is currently
> running a thread which uses the same mm as the sys_membarrier caller
> (for the PRIVATE membarrier commands).
> 
> So I suspect that the Xenomai thread is really not within the Linux scheduler
> runqueue when it runs.

True. Xenomai first suspends the RT thread's Linux shadow and then kicks 
the Xenomai scheduler to interrupt Linux (and schedule in the RT 
thread). So, from a remote Linux perspective, something else will be 
running at this point.

Jan

-- 
Siemens AG, Corporate Technology, CT RDA IOT SES-DE
Corporate Competence Center Embedded Linux

