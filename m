From: Rodrigo Rosenfeld Rosas <lbocseg@domain.hid>
Subject: Re: [Xenomai-core] RTDM and Timer functions
Date: Mon, 13 Mar 2006 22:36:12 -0300
References: <200603091443.25714.lbocseg@domain.hid>
	<200603131631.26195.lbocseg@domain.hid> <4415FAC5.7050608@domain.hid>
In-Reply-To: <4415FAC5.7050608@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
Message-Id: <200603132236.12791.lbocseg@domain.hid>
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Jan Kiszka <jan.kiszka@domain.hid>
Cc: xenomai-core <xenomai@xenomai.org>

Em Segunda 13 Mar=3DE7o 2006 20:05, Jan Kiszka escreveu:
> ...
>>> We would definitely need a good name for it,
>>> rtdm_clock_read_ex(<clock-id>), rtdm_clock_read_tsc(),
>>> rtdm_clock_read_monotonic()? I'm not going to break rtdm_clock_read() by
>>> adding an argument (otherwise, I would have to fix too many drivers on
>>> my own... :-/).
>>
>> That is the idea, I think. I agree that rtdm_clock_read() should be kept
>> as it is (the API/definition). No body is asking you to change it. Adding
>> rtdm_clock_read_tsc() would be sufficient in my opinion whilst it mainta=
=3D
in
>> coherency with other skins.
>
>Thinking about this more thoroughly, a few questions popped up for me:
>
>o When we call it rtdm_clock_read_tsc(), we should actually return the
>  raw TSC values, shouln't we? But then we also need conversion
>  functions (rtdm_clock_tsc2ns, rtdm_clock_ns2tsc). Or should we always
>  convert to nanoseconds on return? POSIX and Native are different in
>  this regard.

I would prefer returning always ns, but both solutions would fit my needs, =
=3D
so=3D20
I'm not really worried about this topic.

>o What would be the core rationale behind it, having a high-resolution
>  time stamp? What are the primary use cases? I'm asking for this so
>  that I can clearly differentiate between this new service and the
>  existing one in the docs. Also, giving an abstract description would
>  leave more options to the actual implementation on other archs or
>  platforms.

As I've said, I think that it is good to give some independency to the driv=
=3D
er,=3D20
at least to the time related functions, for not depending on the user chose=
=3D
n=3D20
timer behaviour for some delay routines. Eg, I would like to wait a specifi=
=3D
ed=3D20
amount of us before testing some register. That is a quite normal task when=
=3D
=3D20
developing drivers. Another one is for timeouts on short delays. In those=
=3D20
cases, we want a good resolution, but this should be independent of the=3D20
user's timer choice IMO.

Rodrigo.

	=09
_______________________________________________________
Yahoo! Acesso Gr=E1tis - Internet r=E1pida e gr=E1tis. Instale o discador a=
gora!
http://br.acesso.yahoo.com


