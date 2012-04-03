Message-ID: <4F7AA9E8.5020900@domain.hid>
Date: Tue, 03 Apr 2012 09:42:32 +0200
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
References: <CAM1yFZ9GKhzvHNDufRQ2aJOH-gJkwv2-FmyhUx3RyS=06DSo4w@domain.hid>
	<4F7AA402.3040803@domain.hid> <4F7AA45B.4030908@domain.hid>
	<CAM1yFZ_GGO0T7uwCx3_yNZMrc2b9pyt=6jgE5toyucmCrk0+JA@mail.gmail.com>
In-Reply-To: <CAM1yFZ_GGO0T7uwCx3_yNZMrc2b9pyt=6jgE5toyucmCrk0+JA@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] Is it compulsory to apply the PREEMPT_RT patch
 (to Linux) when running Xenomai on the top of it?
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Anisha Kaul <born.rebel.83@domain.hid>
Cc: xenomai@xenomai.org

On 04/03/2012 09:37 AM, Anisha Kaul wrote:
> On 3 April 2012 12:48, Philippe Gerum<rpm@xenomai.org>  wrote:
>>> No.
>>
>> I mean: this is not implied, and you don't need _RT (actually, to have it,
>> you would need a specific interrupt pipeline patch).
>
> Thanks for replying.
>
> I read that this patch allows nearly all of the kernel to be
> preempted, with the exception of a few very small regions of code
> ("raw_spinlock critical regions"), can you please point out a few
> cases in which actually we "should" apply this patch?
>
> Xenomai already gives a hard real time, so why would we need this
> patch? Any hints please?
>
>

This is a different approach to a same problem:

- _RT attempts to make the whole regular kernel real-time aware.

- Xenomai 2.x provides a co-kernel for exclusively handling real-time 
processing.

There are pros and cons in the two approaches, this is basically why 
Xenomai 3 will allow both.

> -Anisha
>


-- 
Philippe.

