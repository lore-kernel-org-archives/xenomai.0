Mime-Version: 1.0 (Apple Message framework v1084)
Content-Type: text/plain; charset=us-ascii
From: Jakub Nowacki <j.s.nowacki@domain.hid>
In-Reply-To: <4F0E12FA.8030606@domain.hid>
Date: Fri, 20 Jan 2012 17:18:05 +0000
Content-Transfer-Encoding: quoted-printable
Message-Id: <1B09CB90-7C04-4595-B7D4-19BFA9DF10AD@gmail.com>
References: <CA+fRa6cOs0iz37X8VKFPawXLDV4cDb5=u21FgS7JSP3dSmc+FQ@mail.gmail.com>
	<4F0E12FA.8030606@domain.hid>
Subject: Re: [Xenomai-help] troubles with library inclusion
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: xenomai@xenomai.org


On 11 Jan 2012, at 22:53, Gilles Chanteperdrix wrote:

> On 01/11/2012 11:49 PM, Daniele wrote:
>> Hello,
>>=20
>> We are trying to use xenomai with analogy library
>>=20
>> [xenomai 2.6.0, kernel 2.6.38.8]
>>=20
>> Compiling the program  we got the following error:
>>=20
>>=20
>> "undefined reference to
>> =
a4l_open<http://www.xenomai.org/documentation/trunk/html/api/group__descri=
ptor1__lib.html#ga810401871fe8005ee0157c6910f94466>
>> "
>>=20
>> The compiler detects correctly the function prototypes but it can't =
found
>> their complete definition.
>>=20
>> taking care of our MakeFile we also have read this:
>>=20
>> https://mail.gna.org/public/xenomai-help/2011-07/msg00036.html
>>=20
>> but we noticed that our makefile already contains this instructions =
for our
>> skin, native.
>>=20
>> How could we get rid of this?
>=20
> You need to link with the libanalogy driver, so, simply add =
"-lanalogy"
> on the compiler command line.
>=20

I had a similar problem. Namely, it was complaining about having =
undefined reference. I added the -lanalogy to the flags generated with =
'xeno-config --skin=3Dnative --ldflags' and everything compiled and =
linked correctly, but when I start my application I get error:

/usr/xenomai/lib/libanalogy.so.1: undefined symbol: rt_dev_ioctl

I after adding -lrtdm after -lanalogy everything, again, complied and =
linked correctly, but I get new error:

librtdm.so.1: shared object cannot be dlopen()ed

If I add -lrtdm before -lanalogy, I get the previous undefined symbol. =
To be absolutely sure I don't have a problem with my Xenomai-2.6.0 =
setup, I recompiled and installed it, but I'm still getting the errors. =
It does not seem to be a problem with other Xenomai shared objects path, =
since other SO are loaded correctly (Xenomai native skin threads work =
fine).

Thanks for the help in advance.

Best wishes,

Jakub=

