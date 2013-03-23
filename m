Message-ID: <514D72E7.4060507@xenomai.org>
Date: Sat, 23 Mar 2013 10:16:23 +0100
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
References: <CAMJ=MEc9W3KvNuL6nLQUt_jDPY1zBfsEZJH2pQZs2kJj7g+KBg@mail.gmail.com>
	<514C9EE9.6000505@xenomai.org>
	<CAMJ=MEf_HMQFFQfHtVyWH4btgC0iO0K_ajcR6_ayUrADUQBoZw@mail.gmail.com>
In-Reply-To: <CAMJ=MEf_HMQFFQfHtVyWH4btgC0iO0K_ajcR6_ayUrADUQBoZw@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] xenomai-forge: psos skin does not take t_start flags
 into account
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Ronny Meeus <ronny.meeus@gmail.com>
Cc: xenomai@xenomai.org

On 03/22/2013 08:05 PM, Ronny Meeus wrote:
> On Fri, Mar 22, 2013 at 7:11 PM, Philippe Gerum <rpm@xenomai.org> wrote:
>> On 03/15/2013 02:10 PM, Ronny Meeus wrote:
>>>
>>> Hello
>>>
>>> In august last year I reported a problem with round-robin scheduling
>>> in the pSOS skin.
>>> See mail thread "xenomai-forge: round-robin scheduling in pSOS skin".
>>>
>>> Now that we stepped up to the latest version of Xenomai-forge, I was
>>> retrying the same test I did at that time.
>>> I observe that the situation has been improved: the roundrobin
>>> scheduling as such is now working well,
>>> but there is an issue with the initial flags passed to the t_start call.
>>>
>>> The flags are not correctly taken into account by the t_start call.
>>> The complete testcode is attached to the mail.
>>>
>>> I basically create 2 tasks which both consume all cpu power for some time.
>>> If I create the tasks with timeslice enabled:
>>>       t_create("WORK",10,0,0,0,&tid);
>>>       t_start(tid,T_TSLICE, perform_work, args);
>>>
>>> I get this result:
>>>
>>> # taskset 4 ./roundrobin.exe
>>>      0"000.493| WARNING: [main] Xenomai compiled with full debug enabled,
>>>                                 very high latencies expected
>>> [--enable-debug=full]
>>> 0 -> 7196
>>> 1 -> 0
>>>
>>> If I explicitly add code in the taskbody to enable the timeslicing:
>>>     unsigned long old_mode;
>>>     t_mode((T_TSLICE|T_NOTSLICE),T_NOTSLICE, &old_mode);
>>>     t_mode((T_TSLICE|T_NOTSLICE),T_TSLICE, &old_mode);
>>>
>>> I get this:
>>>
>>> # taskset 4 ./roundrobin.exe
>>>      0"000.491| WARNING: [main] Xenomai compiled with full debug enabled,
>>>                                 very high latencies expected
>>> [--enable-debug=full]
>>> 0 -> 3600
>>> 1 -> 3592
>>>
>>> The latter is the correct behavior: both tasks get equal cpu power.
>>> Note the t_mode is called 2 times to make sure the change of the state
>>> stored in the task object is taken into account.
>>>
>
> Philippe
>
>> My understanding is that your latest patch in commit #eaef6154 fixes the
>> issue.
>>
>
> I think this is not correct.
> The patch solved the large round-robin time, not the issue reported in
> this mail.
> What I observed during debugging this issue is that for example the
> timer used to implement the round-robin is not started when T_TSLICE
> is passed to the t_start call. If I change the mode in the taskbody
> itself the timer is started.
> I tried to start the timer after creating the thread but then I
> observed a crash. So it looked to me that these flags need to be
> processed in the trampoline code in the taskbody itself.
>

They are actually. testsuite/task8.c tests the behavior of the RR code. 
Could you run all the tests there, and report about task8? TIA,

e.g.

$ cd lib/psos/testsuite
$ make DESTDIR=<xenomai_install-dir> test

-- 
Philippe.

