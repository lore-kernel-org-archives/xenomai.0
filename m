Message-ID: <4EA53424.6050803@domain.hid>
Date: Mon, 24 Oct 2011 11:47:16 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <584f2ab9.7f72956e.4e78ccaa.5171d@domain.hid>
	<4E78D7C0.2090108@domain.hid>
	<2b889a6c.722ea076.4ea51970.edef6@domain.hid>
	<4EA522E1.80207@domain.hid>
	<848f265.55f3d06f.4ea52ce9.ebedc@domain.hid>
In-Reply-To: <848f265.55f3d06f.4ea52ce9.ebedc@domain.hid>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Xenomai-help] installing xenomai on pandaboard
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Robert <robert-km@domain.hid>
Cc: xenomai@xenomai.org

On 10/24/2011 11:16 AM, Robert wrote:
>=20
>=20
> Dnia 24 pa=C5=BAdziernika 2011 10:33 Gilles Chanteperdrix <gilles.chant=
eperdrix@domain.hid> napisa=C5=82(a):
>=20
>> On 10/24/2011 09:53 AM, Robert wrote:
>>>
>>>
>>>
>>> Dnia 20 wrze=C5=9Bnia 2011 20:13 Gilles Chanteperdrix <gilles.chantep=
erdrix@domain.hid> napisa=C5=82(a):
>>>
>>>> On 09/20/2011 07:26 PM, Robert wrote:
>>>>> Can someone help me installing xenomai on panda?
>>>>>
>>>>> What should I do, to install xenomai on ubuntu host?
>>>>> Download kernel from kernel.org and patch it with xenomai and adeos=
-patch, or download kernel from git repository, or download ubuntu image-=
omap4 via apt-get source?
>>>>>
>>>>> The last one would download 2.6.38 kernel, but there is no adeos pa=
tch for this version yet.
>>>>> It is also possible to download 2.6.37-9, but the same problem.
>>>>
>>>> The upcoming xenomai 2.6.0 supports panda. It should be released rea=
l
>>>> soon now, in the mean-time, you can try xenomai 2.6.0-rc3.
>>>>
>>>>
>>>
>>> Hi again,
>>> I have downloaded xenomai 2.6.0-rc5, and kernel 2.6.38.8 from kernel.=
org to ubuntu 11.04 on pandaboard.
>>> Patched it with adeos included in xeno package.
>>>
>>> Compiled the kernel, modules and copied uImage to boot partition.
>>> After reboot i got the following dmesg | grep -i xeno:
>>> user@domain.hid$ dmesg | grep -i xeno
>>> [    1.195556] I-pipe: Domain Xenomai registered.
>>> [    1.195587] Xenomai: hal/arm started.
>>> [    1.195861] Xenomai: scheduling class idle registered.
>>> [    1.195861] Xenomai: scheduling class rt registered.
>>> [    1.199798] Xenomai: real-time nucleus v2.6.0-rc5 (head) loaded.
>>> [    1.199798] Xenomai: debug mode enabled.
>>> [    1.590240] Xenomai: native skin init failed, code -19.
>>> [    1.590270] Xenomai: starting POSIX services.
>>> [    1.980804] Xenomai: POSIX skin init failed, code -19.
>>> [    2.371429] Xenomai: RTDM skin init failed, code -19.
>>>
>>> user@domain.hid$ modprobe -l | grep -i xeno
>>> user@domain.hid$ modprobe xeno_native
>>> user@domain.hid$ modprobe -l | grep -i xeno
>>>
>>> user@domain.hid$ sudo ./xeno-test
>>> /usr/xenomai/bin/xeno-test-run-wrapper: 19: source: not found
>>> ./xeno-test failed: dead child 1238 not found!
>>
>> That is surprising, what shell do you use? Have you copied all files
>> installed by xenomai on the board root filesystem?
> =20
> I'm using bash.
> What do you mean, by all files? I just ran make and make install.

I take it you are not cross-compiling then? Anyway, to understand the
bug in xeno-test, you should try adding "set -x" in
xeno-test-run-wrapper, on the second line.

>=20
>=20
>>>
>>> user@domain.hid$ ./cond-torture-native
>>> Xenomai: incompatible feature set
>>> (userland requires "kuser_tsc fastsynch nosmp", kernel provides "sa11=
00 v6 eabi
>>> kuser_tsc fastsynch smp", missing=3D"nosmp").
>>>
>>> Should I disable smp in kernel config?
>>
>> That, or more likely enable smp in user-space configuration.
>>
> Now I try to compile without smp.

I would recommend not to do that. SMP is better tested than !SMP. And
anyway, it is a bit stupid to only use one core on the dual-core OMAP4.


--=20
					    Gilles.


