MIME-Version: 1.0
In-Reply-To: <4F950E77.1030606@domain.hid>
References: <CAKvQZ_2OhLoG4_rGJ1LgFnbdkK4X3zFV+4o-GnhSer8oS5U9Tw@domain.hid>
	<4F949BBF.6020008@domain.hid>
	<CAKvQZ_3gVgY4QPDa5Q7khu2Mm7eUWQnVUYJbwhfxGsTQPyVaSA@mail.gmail.com>
	<4F950E77.1030606@domain.hid>
Date: Wed, 25 Apr 2012 12:05:23 +0200
Message-ID: <CAKvQZ_1cohZPZ==AUG+QfMJ0-8VYcYLLLWSg7w8xtYp6dwXsJA@mail.gmail.com>
From: Willy Lambert <lambert.willy@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Xenomai-help] libnative and libxenomai dependy problem
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

2012/4/23 Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>:
> On 04/23/2012 03:57 AM, Willy Lambert wrote:
>> 2012/4/23 Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>:
>>> On 04/23/2012 01:57 AM, Willy Lambert wrote:
>>>> Hi,
>>>>
>>>> I just run into the same kind of problem of a one year old discussion =
:
>>>> http://www.mail-archive.com/xenomai@xenomai.org
>>>>
>>>> having such kind of errors :
>>>> /usr/lib/libnative.so.3: undefined symbol: xeno_current_mode_key
>>>> I have a xenomai 2.6.0 recompiled from sources with the --dl-open
>>>> option enabled.
>>>> root@domain.hid):~# cat /proc/xenomai/version
>>>> 2.6.0
>>>>
>>>>
>>>> I re-post something because I'm not sure it is up to date and as I
>>>> have the next version I am suprised the problem still arises
>>>>
>>>> I have 2 question :
>>>> _ did I missconfigured something in my compiller flags or linking ?
>>>> _ are the solutions of last thread still up to date ?
>>>>
>>>
>>> You need to dlopen libxenomai in order for dlopen(libnative) to succeed=
.
>>>
>>> --
>>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0Gilles.
>>
>> In fact I never called dlopen(libnative) myself. It is done in a
>> library to which I am linked. Do I have a to dlopen it in my personnal
>> code ?
>>
> you have to manage for dlopen(libxenomai) to be called before
> dlopen(libnative), and with the RTDL_GLOBAL flag so that libnative will
> find the symbols defined by libxenomai.
>
> --
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0Gilles.

Thanks for support. In fact I am not using dlopen directly (dynamic
linking) but in ordering the linking I got it working (without having
to set the flag which might be set underneath).
I'm quite surprised thougth that is is a "soft" dependency. Is it my
bad not having used --xeno-config directly ? (I use a shortcut because
all the stuff is under CMake and I am not an expert with it).

