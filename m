Message-ID: <45EBE237.1090906@domain.hid>
Date: Mon, 05 Mar 2007 10:26:15 +0100
MIME-Version: 1.0
Subject: Re: [Xenomai-help] CAN errors and real-time behaviour
References: <bc4264770703030609w188a675cj618872986ff1071c@domain.hid>
	<45EBD9A3.9000303@domain.hid>
In-Reply-To: <45EBD9A3.9000303@domain.hid>
Content-Type: text/plain; charset="iso-8859-1"; format="flowed"
Content-Transfer-Encoding: quoted-printable
From: Roland Tollenaar <rwatollenaar@domain.hid>
Reply-To: rolandtollenaar@domain.hid
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: =?ISO-8859-1?Q?St=E9phane_ANCELOT?= <sancelot@domain.hid>
Cc: xenomai@xenomai.org

Hi Stephane,

I would have no idea whether the problems are related. I am too much of=20
a novice myself. However I can confirm difference in behaviour between=20
having the bus live and having an unplugged thus unterminated bus. From=20
incidents I have seen this change in behaviour seems to be related to=20
flooding of the buffer with error messages in the case of a bus that is=20
down which results in system messages. But whether that would block X=20
from starting up for example I don't know. From what I gather X is a=20
normal program under linux and as such will not have priority over your=20
real-time tasks. Perhaps with a bus down you also have syslogd busier=20
than a one legged man in an ass-kicking contest, which along with the=20
priority demanded by your rt tasks leaves no time for X. However once=20
your bus is plugged in, syslogd stops complaining, processor time is=20
freed up and X gets some quality, one-on-one time with the CPU?

But others would be better judges than I at this stage.

Regards,

Roland.



St=E9phane ANCELOT wrote:
> Hi,
> May be this related to your problem,I am trying to deal with some=20
> problems regarding CAN applications when NOTHING IS CONNECTED and my=20
> system  :
>=20
> Like you I have a first  task that reads the CAN bus
> a second task is doing nothing than waiting for a a semaphore.
> A third  task begins to send two messages in can bus (the second message =

> has got error) and goes to 5ms peridoic loop
>=20
>=20
> The major problem is as follow :
> I launch my RT TASK : no problem .I can do things in my linux console .
>=20
> Now,  I start X , X begins to launch and is frozen.If I plug the bus=20
> CAN, "magician things " happen : X manage to launch and everything goes=20
> normal  ......
>=20
> important NOTE for the behavour : CAN RX has got a timeout of almost=20
> 100ms and tx of 10 ms. if something goes wrong task 2 rt_task_sleeps for =

> a while.
>=20
> I think the problem is related to can driver behavour.Do you think it is =

> related to the same problem origin you have?
>=20
>=20
> roland Tollenaar wrote:
>> HI,
>>
>> I thought I would put this in a separate thread.
>>
>> The experiment works as follows. I have a 1ms and a 2 ms rt periodic=20
>> task.
>>
>> In the real-time periodic task I am only reading out the message
>> buffer (only work done in the task). In the 2ms task I am doing
>> nothing.
>>
>> I always read-out the measured period times. This is done by writing
>> the measured value into a variable which is displayed in a separate
>> thread outside the rt tasks so the display does not influence the
>> measurement. (Unlike  printf is said to do).
>>
>> There is nothing connected to the rtcan2 device (Peak dongle). The
>> applicaiton runs fine the tasktimes relatively well maintained
>> (fluctuatin about 0.003ms) around 1ms and 2ms.
>>
>> The moment I write to the device using rtcansend eg:
>> ./rtcansend rtcan2 -i 0x700 0x03 0x02
>>
>> the buserror comes up and the protocol error. from that moment onwards
>> the messagebuffer gets flooded and does not stop being flooded forever
>> after.
>>
>> The period times then fluctuate badly up to 0.2ms around their nominal=20
>> values.
>>
>> This is not desirable behavior. Firstly its not necessary to have the
>> message buffer flooded all the time I would think. How do I change
>> that so that I will only pick up an error once in response to a failed
>> send?
>> Secondly what am I doing wrong that breaks the real-time behaviour? If
>> the bus gives an error on one part of the process I don;t want other
>> processes that may have nothing to do with the CAN bus to misbehave.?
>>
>> I do suspect that if I can prevent the message buffer flooding forever
>> and manage to clean it out that the behaviour will be better because
>> if its flooded then messages get sent to dmesg well wherever dmesg
>> reads from that is) and this may explain the behavior?
>>
>> Can anyone comment on this please?
>>
>> Regards,
>>
>> Roland.
>>
>> _______________________________________________
>> Xenomai-help mailing list
>> Xenomai-help@domain.hid
>> https://mail.gna.org/listinfo/xenomai-help
>>
>>
>=20
>=20

