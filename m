Content-Type: text/plain;
	charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.17\))
Subject: Re: Xenomai Images - Password
From: =?utf-8?Q?Deniz_U=C4=9Fur?= <deniz343@gmail.com>
In-Reply-To: <B845B431-F685-4DE2-93D0-AC823151C7E3@gmail.com>
Date: Wed, 4 Nov 2020 22:33:26 +0300
Content-Transfer-Encoding: quoted-printable
Message-Id: <4AA60C97-3707-4AAB-BEEF-89DEC7B67D8F@gmail.com>
References: <AD19FEDC-0F4F-4749-9CE1-C5E38DC1B878@gmail.com>
 <be26f9ca-d3c8-c86d-d8aa-92aa53f65042@siemens.com>
 <4019C880-7DCD-43D9-A559-05570BD867EC@gmail.com>
 <1564cbf6-d4fa-1cdc-1996-20d71464af6c@siemens.com>
 <B845B431-F685-4DE2-93D0-AC823151C7E3@gmail.com>
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Jan Kiszka <jan.kiszka@siemens.com>
Cc: Xenomai <xenomai@xenomai.org>

Okay it looks like BB did not boot from sd card at all and loaded the =
pre-loaded linux. If you happen to know how to change that, I would be =
really glad. Otherwise we can close this thread.

Thank you for your help.

> On 4 Nov 2020, at 22:29, Deniz U=C4=9Fur <deniz343@gmail.com> wrote:
>=20
> It=E2=80=99s possible to login via serial console. What can I do from =
here to ensure that ssh is possible?
>=20
>> On 4 Nov 2020, at 22:22, Jan Kiszka <jan.kiszka@siemens.com> wrote:
>>=20
>> [re-adding the list]
>>=20
>> On 04.11.20 20:07, Deniz U=C4=9Fur wrote:
>>> The session seems to be established, only password is not accepted. =
Also no, I=E2=80=99m not using serial console. I tried to add a new user =
to customizations file but that did not worked.
>>=20
>> OK. I do not have a BeagleBone in reach, but I'm cross-checking via =
qemu-armhf ATM.
>>=20
>> Could you try logging in via the serial console? Would allow to check =
if the password was set, extract log information, possibly also running =
sshd with debug options on (sshd -ddd).
>>=20
>> Jan
>>=20
>>>> On 4 Nov 2020, at 22:02, Jan Kiszka <jan.kiszka@siemens.com> wrote:
>>>>=20
>>>> On 04.11.20 19:54, Deniz U=C4=9Fur via Xenomai wrote:
>>>>> Hello all,
>>>>> I=E2=80=99m successfully generating a BeagleBone Black image with =
optional xenomai-next recipe. When I plug it to BBB it seems to be =
working. However, the login for root/root does not work. I'm connecting =
on 192.168.7.2.
>>>>> Is the default password different from root?
>>>>=20
>>>> No... that is supposed to work. The password "root" is defined via =
conf/distro/xenomai-demo.conf.
>>>>=20
>>>> You are logging in via ssh? Is the session establish, just the =
password not accepted? Or are you logging in via serial console?
>>>>=20
>>>> Jan
>>>>=20
>>>> --=20
>>>> Siemens AG, T RDA IOT
>>>> Corporate Competence Center Embedded Linux
>>=20
>> --=20
>> Siemens AG, T RDA IOT
>> Corporate Competence Center Embedded Linux
>=20


