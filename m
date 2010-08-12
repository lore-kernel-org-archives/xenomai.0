MIME-Version: 1.0
In-Reply-To: <4C63E156.2020102@domain.hid>
References: <20100812093944.14467.qmail@domain.hid>
	<4C63E156.2020102@domain.hid>
Date: Thu, 12 Aug 2010 14:04:30 +0200
Message-ID: <AANLkTik6rvKbm3JPQMpWQYzoqYA6RmwgLp7zFSDt5ECB@mail.gmail.com>
From: Eric Noulard <eric.noulard@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Xenomai-help] Timing calculation
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Wolfgang Grandegger <wg@domain.hid>
Cc: Xenomai help <xenomai@xenomai.org>

2010/8/12 Wolfgang Grandegger <wg@domain.hid>:
> On 08/12/2010 11:39 AM, prakash srinivasan wrote:

>>
>> start=3Drt_timer_read();
>>
>> for()
>>
>> {}
>>
>> end=3Drt_timer_read();
>>
>> printf(TOTAL LOOP TIMING=3D%ld us\n", (long)((rt_timer_ticks2ns(end-star=
t))/1000);
>
> What does:
>
> =A0printf(TOTAL LOOP TIMING=3D%lld us\n", rt_timer_ticks2ns(end-start)/10=
00);

I was trying to check the exact type of
 RTIME (return type of rt_timer_read())
and
SRTIME (expectted argument type and return type of rt_timer_ticks2ns)
and
RTIME unsigned long long

so theoretically you would need the "%lld" (long long) format for
rt_timer_ticks2ns returned value.

whereas you would need "%llu" for rt_timer_read() value.

If you try to print unsigned value with a signed format you'll get
signed "print out" interpretation of the unsigned value,
as you said:
"Early I gave (long)(start). The output was negative."

May be it would be worth having some RTIME_FORMAT
and STRIME_FORMAT macros in order to avoid that?
--=20
Erk
Membre de l'April - =AB promouvoir et d=E9fendre le logiciel libre =BB -
http://www.april.org

