MIME-Version: 1.0
In-Reply-To: <58a6d462bfc384.64095769@wp.pl>
References: <58a6d462bfc384.64095769@wp.pl>
From: Norbert Lange <nolange79@gmail.com>
Date: Fri, 17 Feb 2017 12:19:24 +0100
Message-ID: <CADYdroNowcAVO6W=3seGL_1jN5+fJsNvnJv3MoTrzKvyPV=ZNQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Xenomai] RtNet and Interrupts
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Mariusz Janiak <mariuszjaniak@wp.pl>
Cc: Xenomai <xenomai@xenomai.org>

2017-02-17 11:45 GMT+01:00 Mariusz Janiak <mariuszjaniak@wp.pl>:
> Dnia Pi=C4=85tek, 17 Lutego 2017 11:18 Norbert Lange <nolange79@gmail.com=
> napisa=C5=82(a)
>> Hello,
>>
>> I wonder if the Rtnet Stack is driven at packet level, ie. if after
>> every one received packet( or even buffer) an IRQ is received.
>> I worked on a Project where a similar Problem with Ethernet
>> communication had to be solved, and I just queued up enough receive
>> buffers and just picked up anything that arrived at the start of a
>> timeslot.
>>
>> On 100Mbit and a 1ms timeslot, I calculated a max. of 150 received
>> pakets. Not that realtime communication can get anywhere close to
>> that, but you have to deal with worst cases and guarantee that your
>> system aint missing the cpu time spend in IRQs for other things - even
>> if you just decide to drop all those packets, the IRQ overhead would
>> be there.
>>
>> So is Rtnet using "polling" at timeslots, or irqs?
>
> Hi,
>
> As far as I know, RTnet is interrupt driven stack, it means that after re=
ception of each packet the interrupt is generated and handled by the NIC dr=
iver. This is one of the reasons why porting of the RT driver  to new NICs =
is so problematic, especially now when new drivers support NAPI.

Seems to be a bad Idea, I guess most RT communication is continuous,
means there is not a question whether packets arrived but only how
much of them.If I worked with irqs in the project above, the weak ARM
CPU wouldn`t be able to do anything else.
No efforts in using something similar to "New API"? (who comes up with
such names...)

>
>> Kind Regards,
>> Norbert
>>
>> PS.
>> Complete unrelated, but are there any big companies using Xenomai /
>> Rtnet that can be named?
>
> I know that Universities use it a lot in the field of robotics (eg. SOEM =
+ OROCOS). There is a port of the RTnet stack for microcontrolers if you ar=
e interested (RTnet Embedded)
>
> https://bitbucket.org/mariuszjaniak/rtnet-embedded

Actually I am, sounds like you know about "RTnet Embedded" =3D).

The reason I ask is that I want to push this at the company I work,
unfortunately higher ups typically are most impressed if some rich
companies are using it (and claims that it is the most popular thing
ever).

>
> Best regards,
> Mariusz

Thanks, Norbert

