Message-ID: <45FE4A3D.9050702@domain.hid>
Date: Mon, 19 Mar 2007 09:30:53 +0100
From: Wolfgang Grandegger <wg@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-help] RT-Socket-CAN bus error handling (was CAN errors
	and real-time behaviour (IRQ raise forever and may lock system))
References: <bc4264770703030609w188a675cj618872986ff1071c@domain.hid>
	<E1HOW5u-0006Ap-EW@mailer.emlix.com>
	<45F7DEA8.2050309@domain.hid>
	<E1HRSws-0007cE-R3@domain.hid>
	<45FBD768.9050407@domain.hid> <45FE4E96.4010103@domain.hid>
In-Reply-To: <45FE4E96.4010103@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: quoted-printable
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

St=E9phane ANCELOT wrote:
> Hi,
> only one comment :
> It is not anbsolutely necessary to disable bus error interrupt  " a new=
=20
> bus error in terrupt is not possible until the ecc register is read out=
=20
> once".
>=20
> only disabling reading of ecc in isr will disable new bei generation.

Ah, good hint. It might make the implementation simpler. I have to check.

Wolfgang.

> Wolfgang Grandegger wrote:
>> Hi Sebastian,
>>
>> Sebastian Smolorz wrote:
>>> Wolfgang Grandegger wrote:
>>>> Sebastian Smolorz wrote:
>>>>> Last summer we had a discussion about the BEI issue on the=20
>>>>> socketcan-ML.
>>>>> Two additional handling policies popped up:
>>>>> 1. The interface could restart itself after an amount of BEIs, thus
>>>>> taking responsibility from the user application.
>>>>> 2. The BEI could be completely disabled if no one is interested in=20
>>>>> this
>>>>> type of error frame.
>>>> I tried to implement 2. for SJA1000, but re-enabling the BIE on the =
fly
>>>> does not work. :-(. The controller requires a re-start of the device=
 to
>>>> get the bus error reporting back to work.
>>>
>>> Oh, really? I wasn't aware of this.
>>
>> Well, I got it working. Reading the ECC register after re-enabling the=
=20
>> bus error interrupts fixed the problem:
>>
>>     if (CAN_STATE_OPERATING(dev->state)) {
>>        chip->write_reg(dev, SJA_IER, chip->ier); /* update on the fly =
*/
>>        chip->read_reg(dev, SJA_ECC);
>>     }
>>
>>>>> Maybe it is time to think about the implementation of these=20
>>>>> policies as
>>>>> more and more users seem to run into the BEI issue with a disconnec=
ted
>>>>> bus. Wolfgang, Jan, what is your opinion?
>>>> Well, solution 2. with the limitations mentioned above is therefore=20
>>>> less
>>>> attractive because it interrupts the CAN traffic.
>>>
>>> True.
>>
>> Back to our preferred solution 1. Attached is a patch for review=20
>> including some other fixes and suggestions accumulated over time:
>>
>>      * ksrc/drivers/can/*: To avoid unnecessary bus error interrupt
>>      flooding, the option CONFIG_XENO_DRIVERS_CAN_BUS_ERR now allows t=
o
>>      enable bus error interrupts "on demand" only if an application is
>>      interested in such errors. It is automatically selected for CAN
>>      controllers supporting bus error interrupts like the SJA1000.
>>
>>      * include/rtdm/rtcan.h: Add some doc on bus-off and bus-error err=
or
>>      conditions and the restart policy.
>>
>>      * src/utils/can/rtcanconfig.c: Controller mode settings and doc
>>      has been corrected.
>>
>>>> The Socket-CAN implementation actually restarts the CAN controller=20
>>>> after a certain
>>>> amount of bus error interrupts (200 by default) which matches your=20
>>>> first
>>>> policy above. But in RT-Socket-CAN, we do not automatically re-start=
=20
>>>> the
>>>> device by purpose. Therefore I tend to just stop the device. It's th=
en
>>>> up to the application to restart it. What do you think?
>>>
>>> No fundamental objections but it would be best if an application=20
>>> would be informed of this special situation e.g. through an error=20
>>> frame with the meaning "controller was stopped because of a=20
>>> disconnected bus after trying to send 200 times the same message".
>>>
>>> A question pops up in this context: Why do we define=20
>>> CAN_ERR_RESTARTED if we never do this? Only to be compatible with=20
>>> Socket-CAN? Then I would propose to extend the documentation by=20
>>> pointing out that this will not appear under RT-Socket-CAN.
>>
>> Let's wait if solution 1. is sufficient. maybe we need 2. later as wel=
l.
>>
>> Wolfgang.
>>
>=20
>=20


