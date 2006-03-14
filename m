From: Rodrigo Rosenfeld Rosas <lbocseg@domain.hid>
Subject: Re: [Xenomai-core] RTDM and Timer functions
Date: Tue, 14 Mar 2006 11:27:02 -0300
References: <200603091443.25714.lbocseg@domain.hid>
	<200603132236.12791.lbocseg@domain.hid> <4416666B.5040201@domain.hid>
In-Reply-To: <4416666B.5040201@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
Message-Id: <200603141127.02738.lbocseg@domain.hid>
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

Em Ter=3DE7a 14 Mar=3DE7o 2006 03:44, Jan Kiszka escreveu:

>Rodrigo Rosenfeld Rosas wrote:
>> Em Segunda 13 Mar=3DE7o 2006 20:05, Jan Kiszka escreveu:
>>> ...
>>>
>>>>> We would definitely need a good name for it,
>>>>> rtdm_clock_read_ex(<clock-id>), rtdm_clock_read_tsc(),
>>>>> rtdm_clock_read_monotonic()? I'm not going to break rtdm_clock_read()
>>>>> by adding an argument (otherwise, I would have to fix too many drivers
>>>>> on my own... :-/).
>>>>
>>>> That is the idea, I think. I agree that rtdm_clock_read() should be ke=
=3D
pt
>>>> as it is (the API/definition). No body is asking you to change it.
>>>> Adding rtdm_clock_read_tsc() would be sufficient in my opinion whilst =
=3D
it
>>>> maintain coherency with other skins.
>>>
>>> Thinking about this more thoroughly, a few questions popped up for me:
>>>
>>> o When we call it rtdm_clock_read_tsc(), we should actually return the
>>>  raw TSC values, shouln't we? But then we also need conversion
>>>  functions (rtdm_clock_tsc2ns, rtdm_clock_ns2tsc). Or should we always
>>>  convert to nanoseconds on return? POSIX and Native are different in
>>>  this regard.
>>
>> I would prefer returning always ns, but both solutions would fit my need=
=3D
s,
>> so I'm not really worried about this topic.
>>
>>> o What would be the core rationale behind it, having a high-resolution
>>>  time stamp? What are the primary use cases? I'm asking for this so
>>>  that I can clearly differentiate between this new service and the
>>>  existing one in the docs. Also, giving an abstract description would
>>>  leave more options to the actual implementation on other archs or
>>>  platforms.
>>
>> As I've said, I think that it is good to give some independency to the
>> driver, at least to the time related functions, for not depending on the
>> user chosen timer behaviour for some delay routines. Eg, I would like to
>> wait a specified amount of us before testing some register. That is a
>> quite normal task when
>
>This is what rtdm_task_busy_sleep() already provides - independent of
>the system timer.

I didn't know it was independent from the timer. Good to know. I think it=
=3D20
would worth enforce this statement on its documentation.

>> developing drivers. Another one is for timeouts on short delays. In those
>> cases, we want a good resolution, but this should be independent of the
>> user's timer choice IMO.
>
>And this is something rtdm_clock_read_tsc() will obviously not be for.

Please, take a look in my case. The specification recommends wait at least =
=3D
Xus=3D20
before testing a bit. But the time to wait is not constant, it can vary a f=
=3D
ew=3D20
microseconds. So, I busy wait Xus and then do some code like:

rtdm_task_busy_sleep(X*1000);
start_time =3D3D rtdm_clock_read[_tsc]();
do {
condition=3D3Dtestbit();
} while (! condition && (time_passed(start_time) < TIMEOUT));

But if the user specifies a periodic timer, with tickval=3D3D1ms, then my d=
ri=3D
ver=3D20
will be too slow. I could busy wait TIMEOUT before testing, and it would be=
=3D
=3D20
faster then the above code in this case. But I would like to go away as soo=
=3D
n=3D20
as possible, ie, just after the bit has been set...

>
>Again, when the user / system administrator decided to lower the timer
>resolution in favour of performance, it is not possible (and doesn't
>make sense) to circumvent this decision at driver level (except for busy
>waiting).

But my situation is still a busy wait but written in another form.

>So, I wonder what you plan to do with the return value of the=3D20
>new function?

I think I've already explained myself.

Best regards,

Rodrigo.

	=09
_______________________________________________________
Yahoo! Acesso Gr=E1tis - Internet r=E1pida e gr=E1tis. Instale o discador a=
gora!
http://br.acesso.yahoo.com


