From: trem <tremyfr@domain.hid>
Date: Sun, 29 Apr 2007 17:07:57 +0200
Message-ID: <f12ccd$u8h$1@domain.hid>
References: <f10l2a$rdk$1@domain.hid> <463457A0.7030008@domain.hid>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
In-Reply-To: <463457A0.7030008@domain.hid>
Sender: news <news@domain.hid>
Subject: Re: [Xenomai-help] very simple example for rtdm
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

Jan Kiszka wrote:
> trem wrote:
>> Hi
>>
>> I've written a very simple example for rtdm. And I would be pleased to
>> get a feedback about it. You can found it here :
>>
>> http://zarb.org/users/svn/trem/trem/kernel/xenomai/rtdm/
>>
> 
> Looks good and (almost) clean. A few remarks and some suggestion:
> 
>  o Use kernel coding style for the driver (linux/scripts/Lindent +
>    manual tweaking)

I don't know this kernel coding style for driver. I only know kernel
coding (Documentation/CodingStyle). But I'll apply this coding style as
soon as I found them.

>  o Put your driver under RTDM_CLASS_EXPERIMENTAL, TESTING is for
>    benchmarks and regression test drivers. And you don't need
>    rttesting.h.

yes, done.

>  o As RTDM is mainly about "RT", why not switching to .read_rt and
>    .write_rt? That means of course creating a shadow thread in
>    read_simple_rtdm.

I supose that it needs to add a rt task in read_simple_rtdm,
and all read/write will be done in this task. My goal was to
do a as simple as possible example, but this idea add some
code. Is this added code really usefull for a simple example ?

>  o Once you are real-time with read/write, you could demonstrate
>    synchronisation. One FAQ is "How do I wait with my application on
>    something inside a driver?" You could do rtdm_sem_up on write and
>    rtdm_sem_[timed]down on read.

Same answer that former. I prefer to keep a really simple example.

> Alternatively:
> 
>  o What about creating a small series of RTDM examples, consisting of
>    two demos so far: the first one a reduced version of you current
>    code, just showing device registration and handler invocation, the
>    second one about read/write and synchronisation. And if you feel like
>    doing more, one could certainly continue this series with further
>    aspects...

Could you stop to read my mind ? ;)
I like this idea, and I'm ready to work on a series of example.

I propose to write an example per concept (synchronisation, task, clock,
....). Of course, each example should have a lot of comment that explain
everything. With the idea, that the series could be used as a tutorial.

> Are you interested that we merge your example(s) into the Xenomai repos
> (examples/rtdm/driver-api)? I would welcome this and support your effort!

I think it's the logical behaviour of the previous question (and
answer). So if you think that this example is good enough, I'll be
pleased to see it added in the repository.

> Jan

regards,
trem


