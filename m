References: <CAMES2hcz4K0DXAcktWZ0-DCqA1ds9b=oCfwNET8YaCq9sa+NGw@mail.gmail.com>
 <877d6sv1xg.fsf@xenomai.org>
From: Philippe Gerum <rpm@xenomai.org>
Subject: Re: Building example code with EVL
Date: Wed, 11 May 2022 12:19:49 +0200
In-reply-to: <877d6sv1xg.fsf@xenomai.org>
Message-ID: <87wnestlkv.fsf@xenomai.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Roberto Ferri <ironsnetwork@gmail.com>
Cc: xenomai@xenomai.org


Philippe Gerum <rpm@xenomai.org> writes:

> Roberto Ferri via Xenomai <xenomai@xenomai.org> writes:
>
>> Hello!
>>
>> My team and I are trying to build an EVL-based application on a *Raspber=
ry
>> Pi 4B* [1] without success. We followed the steps reported in the guide =
[2]
>> to compile the code in [3].
>>
>> It would be great if you could tell us what we did wrong.
>>
>> Many thanks for your work!
>>
>> [1] kernel 5.15.35-v8, compiled using
>> https://source.denx.de/Xenomai/xenomai4/linux-evl
>>
>> [2] https://evlproject.org/core/user-api/#build-evl-app
>>
>> [3] https://evlproject.org/core/user-api/thread/#thread-services
>>
>>
>>
>> More info Building example code (#1) =C2=B7 Issues =C2=B7 xenomai / xeno=
mai4 / libevl
>> =C2=B7 GitLab (denx.de)
>> <https://source.denx.de/Xenomai/xenomai4/libevl/-/issues/1>
>>
>>
>
> Mm, <sched.h> is involuntarily shadowed by the libevl version. This is a
> breakage introduced by two recent changes: 034e4fd, made worse by
> bfa2c4b.
>
> A fix will be available from the master branch in a couple of hours
> today. Thanks for the test case.

Please let me know if [1] fixes the issue as expected. This passed my
Yocto build test with a couple of applications here.

https://source.denx.de/Xenomai/xenomai4/libevl/-/commit/21e9a5f2154c65bdd29=
0122dcfd4ce257da0e199

--=20
Philippe.

