Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Apple Message framework v1084)
From: Tadele Shiferaw <metitad@domain.hid>
In-Reply-To: <4DCC4471.5060207@domain.hid>
Date: Thu, 12 May 2011 22:39:40 +0200
Content-Transfer-Encoding: quoted-printable
Message-Id: <88FEA99F-FBC4-43D9-AAFF-97FF404EA642@domain.hid>
References: <DF7E26C2-E774-47BE-A9C9-D53789A4D44B@gmail.com>
	<4DCC4471.5060207@domain.hid>
Subject: Re: [Xenomai-help] xeno-test fail ????
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Xenomai-help@domain.hid


On May 12, 2011, at 10:34 PM, Gilles Chanteperdrix wrote:

> On 05/12/2011 08:40 PM, Tadele Shiferaw wrote:
>> After installing xenomai 2.5.6 with kernel linux 2.6.37 on my ibm =
laptop, I perform xeno-test and i get the following output=20
>>=20
>> dd workload started, pids 2801 stored in /va	=
r/lock/xeno-test.2659.pids
>> 2801 pts/0    00:00:00 dd
>> something died a 2801 or=20
>> something died a 2801 or
>> something died a 2801 or=20
>> something died a 2801 or
>> something died a 2801 or=20
>> something died a 2801 or
>>=20
>> Can anyone explain me what this message means?=20
>=20
> Please do not use xeno-test. Launch the tests by hand.
>=20
> --=20
>                                                                Gilles.

I dont understand what that means but I run xeno-test from xenomai/bin =
and that was the output. I saw a previous discussion with same problem =
and one suggestion was not to build the kernel with CONFIG_ACPI all =
disabled rather only CONFIG_ACPI_PROCESS ... So I am rebuilding the =
kernel to..But does the output mean a failure?

Thanks=20


