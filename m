MIME-Version: 1.0
In-Reply-To: <CAMwkeZyDjpqb11NoxUCTxwpmY5RV0bjRzAHG6HeeyW5RvXejDQ@mail.gmail.com>
References: <CAGc_wL0GYwEPJVMOBR_niJCd9bz2VWoTA7-q-MLOAR_WW2vm2g@domain.hid>
	<4E8AEB1D.2060706@domain.hid>
	<CAGc_wL11cKQhxRmgYB0wU-bFii3YaqjibjgWB+=Tob3tFjsfQQ@mail.gmail.com>
	<4E8B0DEA.8030102@domain.hid>
	<CAGc_wL2wb76-t7RBWJnKxgcvsrcKgnFgV4qkjvUgh5AvM7ie3g@domain.hid>
	<4E8B3744.2030407@domain.hid>
	<CAGc_wL2RgNKfMUyQURJ8G2ceaJtvnJL6LpFue3ekuwJ99vwPww@domain.hid>
	<4E8C3AF9.7070604@domain.hid>
	<CAMwkeZyDjpqb11NoxUCTxwpmY5RV0bjRzAHG6HeeyW5RvXejDQ@mail.gmail.com>
Date: Wed, 5 Oct 2011 23:28:55 +0200
Message-ID: <CAMesUR7Kn66LETRjRatAPJ5SFM+3EkkbSYwtPo8h1jP96crqYQ@mail.gmail.com>
From: Alexis Berlemont <alexis.berlemont@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Xenomai-help] Kernel configuration suggestions/hints
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: =?ISO-8859-1?Q?Fernando_Herrero_Carr=F3n?= <elferdo@domain.hid>
Cc: Xenomai help <xenomai@xenomai.org>

2011/10/5 Fernando Herrero Carr=F3n <elferdo@domain.hid>:
>
>
> 2011/10/5 Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
>>
>> On 10/05/2011 09:48 AM, Julien Delange wrote:
>> > On Tue, Oct 4, 2011 at 12:41 PM, Gilles Chanteperdrix
>> > <gilles.chanteperdrix@xenomai.org> wrote:
>> >> Another mail in that thread seem to suggest that it could be long. Ha=
ve
>> >> you tried timing the various parts of your loop to see where the time
>> >> is
>> >> spent?
>> >
>> > No, sorry, my bad. Unfortunately, I cannot make more tests at this
>> > time because I don't have the hardware.
>> > I will do additional investigation soon, I would have access to the
>> > acquisition card soon. My intent was to know if there was an obvious
>> > error either in my code or in my kernel configuration. Apparently not,
>> > so, I will try to figure out the root causes of these issues.
>>
>> It is my understaning when reading Fernando's answer to your mail that
>> you are not using the proper interface for what you are trying to do.
>>
>
> Yes, my suggestion is to use a different interface that will definitely
> provide higher acquisition speeds. However I am wondering if using the
> "instruction" interface the delay would be over the milliseconds. I'm
> recalling some tests that I did using comedi in linux user-space, that is
> without any real-time support software. I could acquire 8 channels and th=
e
> board's internal timer using the instruction list technique at 120us
> (microseconds) intervals. However my board has 8 parallel ADCs (NI 6143),=
 so
> check if yours has parallel or serial converters. If it has to serialize
> conversions then the overall acquisition period will increase.
>
> Back to your code, are you sure about=A0 "insn_tab[i].data_size =A0 =A0 =
=3D 8;"? Try
> data_size =3D 1 instead.
>

The field data_size is supposed to hold the size of the acquisition in byte=
s.

If you have an 8bits converter, 1 is OK; but according to the driver
Julien contributed, the converter width is 16bits.

> Best,
> Fernando
>
> _______________________________________________
> Xenomai-help mailing list
> Xenomai-help@domain.hid
> https://mail.gna.org/listinfo/xenomai-help
>
>

Alexis.

