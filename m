MIME-Version: 1.0
In-Reply-To: <50129907.5040306@siemens.com>
References: <CALH4WdYdUKfMrsJUHqQYTh84GgMWErpCYUJMmZVtxxngdNoStQ@mail.gmail.com>
	<50129907.5040306@siemens.com>
Date: Fri, 27 Jul 2012 15:58:39 +0200
Message-ID: <CALH4WdYGnV6hwgAtLT5pLVsFaAqT5BmZS82ueZV9LRTuby-97A@mail.gmail.com>
From: Frederik Bayart <frederik.bayart@triphase.com>
Content-Type: text/plain; charset=ISO-8859-1
Subject: Re: [Xenomai] cpu usage
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Jan Kiszka <jan.kiszka@siemens.com>, xenomai@xenomai.org

The use case is : we are using an i7 processor. We noticed that
internally, the processor is shifting frequency to minimize idle time.
(This is not done by linux, we used cpufreq to avoid that but there is
still some software on the processor that is shifting frequency). This
has as consequence that the required rate of our realtime process,
which is a periodic task, becomes to fast for the processor.
To avoid downscaling of the cpu frequency, we had the  idea to run
additionally a busywait loop at priority 0 so that the processor is
always running at 100%, there is no idle time and the frequency will
not scale down.

We want only 1 core running at 100% for temperature reasons.

On 27 July 2012 15:35, Jan Kiszka <jan.kiszka@siemens.com> wrote:
> On 2012-07-27 15:04, Frederik Bayart wrote:
>> I'm running Xenomai 2.6.0 on Linux 2.6.38
>>
>> I have a dual core processor.
>> When I run a busywait loop on cpu 0 (see source in attachment), I
>> can't do anything anymore on the computer although cpu 1 is almost
>> entirely idle. I can't interrupt the busywait loop, login, type
>> something in a shell, ...
>> This is even the case if I run linux entirely on cpu 1 (by using
>> isolcpus=0 as kernel parameter)
>>
>> How can this be explained ?
>>
>> Is it possible to use cpu 0 at 100% for a xenomai tasks and cpu 1 for
>> normal linux tasks so that you can still work on the computer ?
>
> It's a FAQ: This is not possible with current Linux. It will lock up
> quite quickly if kernel helper threads for RCU or work queues cannot run
> once in a while. Also, time keeping will be affected. Due to the latter,
> you should release the core to Linux once every scheduling tick.
>
> Jan
>
> --
> Siemens AG, Corporate Technology, CT RTC ITP SDP-DE
> Corporate Competence Center Embedded Linux
>
>



-- 
Frederik Bayart | Senior software engineer
Triphase NV | Research Park Zone 1719 | Romeinse straat 18 | B-3001 Heverlee
T  +32 2 669 06 05 | E frederik.bayart@triphase.com | W www.triphase.com

