Message-ID: <550BD231.5020002@web.de>
Date: Fri, 20 Mar 2015 08:54:25 +0100
From: Jan Kiszka <jan.kiszka@web.de>
MIME-Version: 1.0
References: <CADvZd9Z8LSPRMAJWb1Tp91i4i9N5wLGMxb3_suaDyFRwRiJd-w@mail.gmail.com>
 <CAEMXjGzNnwnrZOG4AFPbgKrJUpdHiuuVRFOAoKNasy-eVJQ0yg@mail.gmail.com>
 <CADvZd9bRzWJKP4ye48T6Jq-Y8wQH=GhpnqsUCcxGo0BMhi0BBg@mail.gmail.com>
 <CADvZd9aGmH0_xsYJ=CVn6813AWCE-B78zYrgh0vNhrBHZU=rfg@mail.gmail.com>
 <CADvZd9ZGNcYTt4WNLPJRL+J+MgLpRPRZsyQ9MY4ammYh+7B5Rg@mail.gmail.com>
In-Reply-To: <CADvZd9ZGNcYTt4WNLPJRL+J+MgLpRPRZsyQ9MY4ammYh+7B5Rg@mail.gmail.com>
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Xenomai] RT-CAN question (was: CAN bus on beaglebone black)
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Michael Haberler <haberlerm@gmail.com>, Steve B <sbattazzo@gmail.com>
Cc: xenomai <xenomai@xenomai.org>

On 2015-03-20 08:26, Michael Haberler wrote:
>>>> As I understand it from a quick and simple question I recently asked of
>>>> the list, if you're using the RTDM driver then its interrupt will be a=
mong
>>>> the few things able to pre-empt your high priority Xenomai task (assum=
ing
>>>> you have any running at the time). So if you really don't need the CAN=
 bus
>>>> to be "rt-safe" then it may in some cases be better to have it set up =
with
>>>> the regular Linux driver so that the i-pipe doesn't prioritize it over=
 your
>>>> RT tasks. That could also depend on how often you have frames coming i=
n and
>>>> whether or not you have danger of overrunning the hardware receive buf=
fer
>>>> if the interrupt service routine is neglected while your RT task is st=
ill
>>>> running.
>>>>
>>>> It could a bit tricky, though (modifications to the driver source), if
>>>> you wanted one CAN bus to be non-RT and one to be RT.
>>>>
>>>>
>>>> With the RTDM driver, I'm not sure if it uses a Xenomai system call to
>>>> open the socket (but I suspect that it may). If that's the case, then =
you
>>>> can open it from either a primary or secondary mode Xenomai thread, but
>>>> maybe not a regular Linux thread (i.e. a totally non-Xenomai applicati=
on or
>>>> a thread opened with __real_pthread_create).
>>>>
>>>
>>> reading the rtcansend.c and rtcanrecv.c source, all the preliminaries
>>> (create socket, bind, ioctl etc) are done in a Linux thread. Only the r=
ead
>>> and write ops are done in an RT thread. Just to check, I added a command
>>> line option to do rt_dev_rec*/rt_dev_send* operations from a Linux thre=
ad,
>>> and that seems to block.
>>>
>>
>> correction: in this case rt_dev_send fails with EPERM
>>
>> This thread suggests it is not possible to call this function from a
>> non-Xenomai thread:
>> http://sourceforge.net/p/rtnet/mailman/message/19223387/
>>
>> someody else tried the same thing before, looks like he did not get an
>> answer: http://www.xenomai.org/pipermail/xenomai/2012-April/025744.html
>>
> =

> the reason for this is obviously the NULL definitions for recvmsg_nrt and
> sendmsg_nrt in lines 1017 and 1020 here:
> =

> https://git.xenomai.org/xenomai-2.6.git/tree/ksrc/drivers/can/rtcan_raw.c=
#n1017
> =

> To enable non-RT recvmsg/sendmsg, is it OK to just set the recvmsg_nrt and
> sendmsg_nrt pointers to rtcan_raw_recvmsg and rtcan_raw_sendmsg as is done
> for instance with rtcan_raw_ioctl?
> =

> Or am I violating some fundamental assumption?

You are: *_nrt handlers must not use any RTDM (or Xenomai) services
internally that may block the caller - because they will run over Linux
context. But that condition is clearly not fulfilled for blocking
recvmsg and probably also sendmsg (to sync on available CAN buffers etc.).

In general, if you have the need for some use cases to operate a piece
of hardware with an RT driver, all users of that hardware have to go
that path and at least have to be Xenomai threads - can also be SCHED_OTHER.

If you have a CAN adapter with multiple controllers that can be operated
separately, you may also use different drivers - if both (Linux and
RTDM) support to be attached only to a subset of controllers.

Jan


-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 181 bytes
Desc: OpenPGP digital signature
URL: <http://www.xenomai.org/pipermail/xenomai/attachments/20150320/a167ca0=
3/attachment.sig>
