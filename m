Message-ID: <45EC2FCF.70601@domain.hid>
Date: Mon, 05 Mar 2007 14:57:19 +0000
From: =?ISO-8859-1?Q?St=E9phane_ANCELOT?= <sancelot@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-help] CAN errors and real-time behaviour (IRQ raise
	forever and may lock system)
References: <bc4264770703030609w188a675cj618872986ff1071c@domain.hid>
	<45EBD9A3.9000303@domain.hid> <45EBF37F.6090604@domain.hid>
	<E1HOBKy-0000tp-Kt@domain.hid>
In-Reply-To: <E1HOBKy-0000tp-Kt@domain.hid>
Content-Type: text/plain; charset="iso-8859-1"; format="flowed"
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
To: Sebastian Smolorz <ssm@domain.hid>
Cc: xenomai@xenomai.org



Sebastian Smolorz wrote:
> St=E9phane ANCELOT wrote:
>> I have checked what has happened when nothing plugged on canbus:
>>
>> a bus error occured .
>> when bus error occurs the ecc register contains possible error informati=
on.
>> once we read the ecc register (in isr routine) the error code register
>> mechanism is enabled again . Thus another bus error interrupt appears
>> again and a new BEI ocurs
>>
>> In this case, the system spend time in the ISR routine of the CAN
>> driver.It gives you enough time to run a linux console , but not to
>> launch other tasks like X...
>>
>> It would be necessary to find a way to manage this kind of problem and
>> avoiding enabling forever Bus Error Interrupt.
>=20
> Note that the current implementation of RT-Socket-CAN shows this behaviou=
r on=20
> purpose. See also [1] ("may flood!"). Whether this is the right handling =
or=20
> not may be discussed here. I admit that the current implementation forces=
 an=20
> application developer to take more responsibility but that is not a bug o=
f=20
> the underlying driver/stack per se. Look, you don't connect anything to t=
he=20
> CAN bus, start a *real-time* application which sends a message to a=20
> non-existent CAN node. This is an error situation an it is more than ever=
 for=20
> a real-time task. So the proper reaction for a RT-application would be to=
=20
> handle those errors and e.g. shut down the CAN interface which in this ca=
se=20
> will force the CAN hardware to stop its endless attempts to send the mess=
age.

I agree and this is what I was doing , however this does not seem to=20
work as expected in the driver.



> [1]http://www.xenomai.org/documentation/trunk/html/api/group__rtcan.html#=
g0b068b1221129441b89967ee2ddb9f44
>=20
> --
> Sebastian
>=20
>=20


