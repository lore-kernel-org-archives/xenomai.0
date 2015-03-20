MIME-Version: 1.0
In-Reply-To: <CADvZd9aGmH0_xsYJ=CVn6813AWCE-B78zYrgh0vNhrBHZU=rfg@mail.gmail.com>
References: <CADvZd9Z8LSPRMAJWb1Tp91i4i9N5wLGMxb3_suaDyFRwRiJd-w@mail.gmail.com>
 <CAEMXjGzNnwnrZOG4AFPbgKrJUpdHiuuVRFOAoKNasy-eVJQ0yg@mail.gmail.com>
 <CADvZd9bRzWJKP4ye48T6Jq-Y8wQH=GhpnqsUCcxGo0BMhi0BBg@mail.gmail.com>
 <CADvZd9aGmH0_xsYJ=CVn6813AWCE-B78zYrgh0vNhrBHZU=rfg@mail.gmail.com>
Date: Fri, 20 Mar 2015 08:26:19 +0100
Message-ID: <CADvZd9ZGNcYTt4WNLPJRL+J+MgLpRPRZsyQ9MY4ammYh+7B5Rg@mail.gmail.com>
From: Michael Haberler <haberlerm@gmail.com>
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
To: Steve B <sbattazzo@gmail.com>
Cc: xenomai <xenomai@xenomai.org>

2015-03-20 7:58 GMT+01:00 Michael Haberler <haberlerm@gmail.com>:

>
>
> 2015-03-20 7:15 GMT+01:00 Michael Haberler <haberlerm@gmail.com>:
>
>>
>>
>> 2015-03-19 19:44 GMT+01:00 Steve B <sbattazzo@gmail.com>:
>>
>>>
>>>
>>> On Thu, Mar 19, 2015 at 2:57 AM, Michael Haberler <haberlerm@gmail.com>
>>> wrote:
>>>
>>>> status:
>>>>
>>>> I have Steve Batazzo's driver running on the beaglebone, using a stock
>>>> Xenomai kernel from Robert Nelson's repo (linux-image-3.8.13-xenomai-r71
>>>> from http://repos.rcn-ee.net/debian/), current driver out of tree at
>>>> https://github.com/mhaberler/rtcan-bb branch mah
>>>>
>>>> I also have a preliminary HAL driver for machinekit which talks to a
>>>> Trinamic motor over RT-CAN just fine (beaglebone for now, x86 once I
>>>> get a
>>>> CAN PCI card).
>>>>
>>>> I'm working with Steve to get the driver polished and hope we can
>>>> inject it
>>>> into the Xenomai foodchain eventually, after which it will be eventually
>>>> picked up by Robert's periodic builds, and the whole thing becomes an
>>>> 'apt-get install' - affair. But we're not there yet.
>>>>
>>>>
>>>> I have a few questions on RT-CAN (I guess really RTDM):
>>>>
>>>> - can the RTDM API (
>>>> https://xenomai.org/documentation/trunk/html/api/group__userapi.html)
>>>> be
>>>> used from a normal Posix thread (non-RT) just alike? from the rtcansend*
>>>> utilities src it looks like at least for setup, even if the send/receive
>>>> ops are done in an RT thread.
>>>>
>>>> - socket-CAN and RT-CAN interworking: I assume this is an either-or
>>>> affair,
>>>> right? (background: for some jobs the RT-CAN features are overkill, and
>>>> in
>>>> that case something like the python-can binding would be convenient to
>>>> use)
>>>>
>>>> - in case the above answers are 'yes' and 'no, it's either/or': anybody
>>>> aware of Python bindings for RTDM?
>>>>
>>>> sorry for the noobish questions, climbing the learning curve
>>>>
>>>> - Michael
>>>> _______________________________________________
>>>> Xenomai mailing list
>>>> Xenomai@xenomai.org
>>>> http://www.xenomai.org/mailman/listinfo/xenomai
>>>>
>>>
>>> I am thinking that if the RTDM version of the driver is overkill for
>>> what you are doing, then it may be best to just use the regular Linux
>>> driver.
>>>
>>
>> certainly no point in using RT-CAN for say wiggling a led or querying a
>> slow sensor. But if the API could be used from non-Xenomai threads as well,
>> then I do not have to force the decision for either-or setup ahead of time.
>>
>> the specific application where socket-CAN is not an option would run as
>> part of a motion control loop with intelligent motor drives, which is
>> timing-critical for position feedback and stall detection. This is similar
>> to other interface types already in use in this setting, like Ethernet, so
>> just another modality. As for contention, I would probably not mix traffic
>> types on a bus.
>>
>>
>> CAN aside, part of the exercise is to learn how to modify drivers to
>> RTDM: for instance, we would gain big time from a SPI RTDM driver on
>> certain platforms (actually I would appreciate any pointers to references
>> how to approach that problem).
>>
>>
>>> As I understand it from a quick and simple question I recently asked of
>>> the list, if you're using the RTDM driver then its interrupt will be among
>>> the few things able to pre-empt your high priority Xenomai task (assuming
>>> you have any running at the time). So if you really don't need the CAN bus
>>> to be "rt-safe" then it may in some cases be better to have it set up with
>>> the regular Linux driver so that the i-pipe doesn't prioritize it over your
>>> RT tasks. That could also depend on how often you have frames coming in and
>>> whether or not you have danger of overrunning the hardware receive buffer
>>> if the interrupt service routine is neglected while your RT task is still
>>> running.
>>>
>>> It could a bit tricky, though (modifications to the driver source), if
>>> you wanted one CAN bus to be non-RT and one to be RT.
>>>
>>>
>>> With the RTDM driver, I'm not sure if it uses a Xenomai system call to
>>> open the socket (but I suspect that it may). If that's the case, then you
>>> can open it from either a primary or secondary mode Xenomai thread, but
>>> maybe not a regular Linux thread (i.e. a totally non-Xenomai application or
>>> a thread opened with __real_pthread_create).
>>>
>>
>> reading the rtcansend.c and rtcanrecv.c source, all the preliminaries
>> (create socket, bind, ioctl etc) are done in a Linux thread. Only the read
>> and write ops are done in an RT thread. Just to check, I added a command
>> line option to do rt_dev_rec*/rt_dev_send* operations from a Linux thread,
>> and that seems to block.
>>
>
> correction: in this case rt_dev_send fails with EPERM
>
> This thread suggests it is not possible to call this function from a
> non-Xenomai thread:
> http://sourceforge.net/p/rtnet/mailman/message/19223387/
>
> someody else tried the same thing before, looks like he did not get an
> answer: http://www.xenomai.org/pipermail/xenomai/2012-April/025744.html
>

the reason for this is obviously the NULL definitions for recvmsg_nrt and
sendmsg_nrt in lines 1017 and 1020 here:

https://git.xenomai.org/xenomai-2.6.git/tree/ksrc/drivers/can/rtcan_raw.c#n1017

To enable non-RT recvmsg/sendmsg, is it OK to just set the recvmsg_nrt and
sendmsg_nrt pointers to rtcan_raw_recvmsg and rtcan_raw_sendmsg as is done
for instance with rtcan_raw_ioctl?

Or am I violating some fundamental assumption?

- Michael

>
>
>> The RTDM user API manual refers to Device Profiles, but it's unclear to
>> me if the answer really is "generally no", "generally yes", or "depends on
>> driver". Probably the latter, but I still have to understand the causal
>> chain.
>>
>>>
>>> Unfortunately I don't have an answer on the Python bindings
>>>
>>
>> If no answer comes up, but the RTDM API could be used from a normal Linux
>> thread, then what I would likely do is to extend the python-can bindings
>> for this interface type. Otherwise no point anyway I guess.
>>
>> - Michael
>>
>
>
