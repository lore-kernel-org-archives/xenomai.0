Subject: Re: Re: Re: Antwort: Re: [Xenomai-help] pSOS skin questions
MIME-Version: 1.0
Message-ID: <OFED2D8080.907D82EC-ONC12571EF.0047B742@domain.hid>
From: "Thomas Necker" <Thomas.Necker@domain.hid>
Date: Wed, 20 Sep 2006 15:21:28 +0200
Content-Type: text/plain; charset="us-ascii"
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: xenomai@xenomai.org

>> 1) The program segfaults sometimes. It's not predictable whether
>>    it'll happen or not. Starting the same program 10 times may
>>    result in some segfaults and some complete runs. Adding a printf
>>    for error checking can massively alter the crash likelyhood. When
>>    it crashes, its always the same picture: A pSOS event is sent
>>    from one task to another. The receiveing task is released from its
>>    blocking ev_receive and continues. However, if this now running task
>>    calls psos_current_task() it gets the id of the task the event has
>>    been sent from! Somehow something seems to be completely mixed up
>>    in the nucleus. After two days of search I'm running out of ideas
>>    what to look for.
>
>Try raising the size of the task stacks. If printf() increases the
>occurences of faults, then it's likely related to a stack overflow.
>
>>  I'd be thankful for some ideas where to place
>>    some hooks to identify the problem. Things get complicated because
>>    program changes (I tried to reduce the problem to a simple example)
>>    ususally make the problem go away and debugging hardly works, see 2)

I raised the stack to 40k each task, which is ten times as much as under
original pSOS - still segfaults. Also, printfs rather *reduce* the 
likelyhood
of a crash - maybe because of timing changes. I don't think, I'm going to 
make
progress without understanding some of the Xenomai internals. Where is the
best place when I want to trace the "firing" of an event?

>The UVM has some known issues when traced over GDB, which do not exist
>when running over a direct call interface, like POSIX, VxWorks or the
>native skin. Ok, this is not going to help you since such interface is
>not available yet for the pSOS skin, but that's a known issue. I'll try
>to have a look when time allows.

I already wondered that UVM support is "deprecated" according to the 
config file.
What are the plans here: have a pSOS direct call interface, get rid of 
pSOS
support or keep the UVM but unmaintained?

Thomas


