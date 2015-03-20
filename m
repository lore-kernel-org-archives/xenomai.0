MIME-Version: 1.0
In-Reply-To: <CADvZd9b9vxCGkWKGcdwudCKvMAsFFrZ0t-OHPFn53B4qE+DdDw@mail.gmail.com>
References: <CADvZd9Z8LSPRMAJWb1Tp91i4i9N5wLGMxb3_suaDyFRwRiJd-w@mail.gmail.com>
 <CAEMXjGzNnwnrZOG4AFPbgKrJUpdHiuuVRFOAoKNasy-eVJQ0yg@mail.gmail.com>
 <CADvZd9bRzWJKP4ye48T6Jq-Y8wQH=GhpnqsUCcxGo0BMhi0BBg@mail.gmail.com>
 <CADvZd9aGmH0_xsYJ=CVn6813AWCE-B78zYrgh0vNhrBHZU=rfg@mail.gmail.com>
 <CADvZd9ZGNcYTt4WNLPJRL+J+MgLpRPRZsyQ9MY4ammYh+7B5Rg@mail.gmail.com>
 <550BD231.5020002@web.de>
 <CADvZd9b9vxCGkWKGcdwudCKvMAsFFrZ0t-OHPFn53B4qE+DdDw@mail.gmail.com>
Date: Fri, 20 Mar 2015 10:42:05 -0700
Message-ID: <CAEMXjGz8o5UWpNhznHC5-RsjRh_FBRW6ug7rpR-Z5tPvHY34GA@mail.gmail.com>
From: Steve B <sbattazzo@gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Xenomai] RT-CAN question (was: CAN bus on beaglebone black)
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Michael Haberler <haberlerm@gmail.com>
Cc: xenomai <xenomai@xenomai.org>

Michael,
At least for the Beaglebone Black case, it is looking like you will have a
good and simple way of picking which driver you load.
I am working on getting the driver integrated to the Xenomai tree and in
the process making minor tweaks.. by changing the "compatibility" string to
something unique it looks like you can match the CAN device to the driver
in your device tree overlay. Should be no more having to load the original
driver first.

I have a bit of an issue that I'm trying to work around with splitting the
driver into the multiple source files, but once I get that sorted out it
should be ready to work that way!

On Fri, Mar 20, 2015 at 1:02 AM, Michael Haberler <haberlerm@gmail.com>
wrote:

> Jan -
>
> 2015-03-20 8:54 GMT+01:00 Jan Kiszka <jan.kiszka@web.de>:
>
>> On 2015-03-20 08:26, Michael Haberler wrote:
>> >>>> As I understand it from a quick and simple question I recently asked
>> of
>> >>>> the list, if you're using the RTDM driver then its interrupt will be
>> among
>> >>>> the few things able to pre-empt your high priority Xenomai task
>> (assuming
>> >>>> you have any running at the time). So if you really don't need the
>> CAN bus
>> >>>> to be "rt-safe" then it may in some cases be better to have it set
>> up with
>> >>>> the regular Linux driver so that the i-pipe doesn't prioritize it
>> over your
>> >>>> RT tasks. That could also depend on how often you have frames coming
>> in and
>> >>>> whether or not you have danger of overrunning the hardware receive
>> buffer
>> >>>> if the interrupt service routine is neglected while your RT task is
>> still
>> >>>> running.
>> >>>>
>> >>>> It could a bit tricky, though (modifications to the driver source),
>> if
>> >>>> you wanted one CAN bus to be non-RT and one to be RT.
>> >>>>
>> >>>>
>> >>>> With the RTDM driver, I'm not sure if it uses a Xenomai system call
>> to
>> >>>> open the socket (but I suspect that it may). If that's the case,
>> then you
>> >>>> can open it from either a primary or secondary mode Xenomai thread,
>> but
>> >>>> maybe not a regular Linux thread (i.e. a totally non-Xenomai
>> application or
>> >>>> a thread opened with __real_pthread_create).
>> >>>>
>> >>>
>> >>> reading the rtcansend.c and rtcanrecv.c source, all the preliminaries
>> >>> (create socket, bind, ioctl etc) are done in a Linux thread. Only the
>> read
>> >>> and write ops are done in an RT thread. Just to check, I added a
>> command
>> >>> line option to do rt_dev_rec*/rt_dev_send* operations from a Linux
>> thread,
>> >>> and that seems to block.
>> >>>
>> >>
>> >> correction: in this case rt_dev_send fails with EPERM
>> >>
>> >> This thread suggests it is not possible to call this function from a
>> >> non-Xenomai thread:
>> >> http://sourceforge.net/p/rtnet/mailman/message/19223387/
>> >>
>> >> someody else tried the same thing before, looks like he did not get an
>> >> answer:
>> http://www.xenomai.org/pipermail/xenomai/2012-April/025744.html
>> >>
>> >
>> > the reason for this is obviously the NULL definitions for recvmsg_nrt
>> and
>> > sendmsg_nrt in lines 1017 and 1020 here:
>> >
>> >
>> https://git.xenomai.org/xenomai-2.6.git/tree/ksrc/drivers/can/rtcan_raw.c#n1017
>> >
>> > To enable non-RT recvmsg/sendmsg, is it OK to just set the recvmsg_nrt
>> and
>> > sendmsg_nrt pointers to rtcan_raw_recvmsg and rtcan_raw_sendmsg as is
>> done
>> > for instance with rtcan_raw_ioctl?
>> >
>> > Or am I violating some fundamental assumption?
>>
>> You are: *_nrt handlers must not use any RTDM (or Xenomai) services
>> internally that may block the caller - because they will run over Linux
>> context. But that condition is clearly not fulfilled for blocking
>> recvmsg and probably also sendmsg (to sync on available CAN buffers etc.).
>>
>> In general, if you have the need for some use cases to operate a piece
>> of hardware with an RT driver, all users of that hardware have to go
>> that path and at least have to be Xenomai threads - can also be
>> SCHED_OTHER.
>>
>> If you have a CAN adapter with multiple controllers that can be operated
>> separately, you may also use different drivers - if both (Linux and
>> RTDM) support to be attached only to a subset of controllers.
>>
>> Jan
>>
>
> well thanks for the education! obviously a blunder in the making.
>
> I guess the dual-driver/controller solution you suggest is the way to go -
> containment by "ships in the night" is fine.
>
> Michael
>
>
>
