From: Giulio Moro <g.moro@qmul.ac.uk>
Subject: Re: Xenomai Images - Password
Date: Wed, 4 Nov 2020 19:37:30 +0000
Message-ID: <DBAPR07MB6600D50931CEBA9221BA59F0B5EF0@DBAPR07MB6600.eurprd07.prod.outlook.com>
References: <AD19FEDC-0F4F-4749-9CE1-C5E38DC1B878@gmail.com>
 <be26f9ca-d3c8-c86d-d8aa-92aa53f65042@siemens.com>
 <4019C880-7DCD-43D9-A559-05570BD867EC@gmail.com>
 <1564cbf6-d4fa-1cdc-1996-20d71464af6c@siemens.com>
 <B845B431-F685-4DE2-93D0-AC823151C7E3@gmail.com>,
 <4AA60C97-3707-4AAB-BEEF-89DEC7B67D8F@gmail.com>
In-Reply-To: <4AA60C97-3707-4AAB-BEEF-89DEC7B67D8F@gmail.com>
Content-Language: en-GB
MIME-Version: 1.0
Content-Type: text/plain; charset="windows-1254"
Content-Transfer-Encoding: quoted-printable
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Jan Kiszka <jan.kiszka@siemens.com>, =?windows-1254?Q?Deniz_U=F0ur?= <deniz343@gmail.com>
Cc: Xenomai <xenomai@xenomai.org>

The easiest way is to boot without sd card, login, and then

sudo su
dd if=3D/dev/zero of=3D/dev/mmcblk1 bs=3D1024k count=3D100

This should make the eMMC unbootable and so boot from SD. Otherwise you can=
 give power while holding down the USER button every time.
________________________________
From: Xenomai <xenomai-bounces@xenomai.org> on behalf of Deniz U=F0ur via X=
enomai <xenomai@xenomai.org>
Sent: Wednesday, November 4, 2020 7:33:26 PM
To: Jan Kiszka <jan.kiszka@siemens.com>
Cc: Xenomai <xenomai@xenomai.org>
Subject: Re: Xenomai Images - Password

Okay it looks like BB did not boot from sd card at all and loaded the pre-l=
oaded linux. If you happen to know how to change that, I would be really gl=
ad. Otherwise we can close this thread.

Thank you for your help.

> On 4 Nov 2020, at 22:29, Deniz U=F0ur <deniz343@gmail.com> wrote:
>
> It=92s possible to login via serial console. What can I do from here to e=
nsure that ssh is possible?
>
>> On 4 Nov 2020, at 22:22, Jan Kiszka <jan.kiszka@siemens.com> wrote:
>>
>> [re-adding the list]
>>
>> On 04.11.20 20:07, Deniz U=F0ur wrote:
>>> The session seems to be established, only password is not accepted. Als=
o no, I=92m not using serial console. I tried to add a new user to customiz=
ations file but that did not worked.
>>
>> OK. I do not have a BeagleBone in reach, but I'm cross-checking via qemu=
-armhf ATM.
>>
>> Could you try logging in via the serial console? Would allow to check if=
 the password was set, extract log information, possibly also running sshd =
with debug options on (sshd -ddd).
>>
>> Jan
>>
>>>> On 4 Nov 2020, at 22:02, Jan Kiszka <jan.kiszka@siemens.com> wrote:
>>>>
>>>> On 04.11.20 19:54, Deniz U=F0ur via Xenomai wrote:
>>>>> Hello all,
>>>>> I=92m successfully generating a BeagleBone Black image with optional =
xenomai-next recipe. When I plug it to BBB it seems to be working. However,=
 the login for root/root does not work. I'm connecting on 192.168.7.2.
>>>>> Is the default password different from root?
>>>>
>>>> No... that is supposed to work. The password "root" is defined via con=
f/distro/xenomai-demo.conf.
>>>>
>>>> You are logging in via ssh? Is the session establish, just the passwor=
d not accepted? Or are you logging in via serial console?
>>>>
>>>> Jan
>>>>
>>>> --
>>>> Siemens AG, T RDA IOT
>>>> Corporate Competence Center Embedded Linux
>>
>> --
>> Siemens AG, T RDA IOT
>> Corporate Competence Center Embedded Linux
>


