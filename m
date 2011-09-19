MIME-Version: 1.0
Sender: patrickdepinguin@domain.hid
In-Reply-To: <CAMJ=MEeOS2K09fm0hnvSmxn6CBbMjHaC-uhDr03qNoZTaEbWVA@mail.gmail.com>
References: <CAAXf6LVErpVae0HVcqv4Rc6p2wnJLje7He2NJC7S1aCSVnD9NQ@mail.gmail.com>
	<1316360236.2169.40.camel@domain.hid>
	<8236197CA3DA864F9EF20609D9887263B4D0@domain.hid>
	<CAMJ=MEeOS2K09fm0hnvSmxn6CBbMjHaC-uhDr03qNoZTaEbWVA@mail.gmail.com>
Date: Mon, 19 Sep 2011 10:45:44 +0200
Message-ID: <CAAXf6LX4gfVncvRo5UTyMrqWHhJ6K0ioksyTqvovAjpJyZWS3w@domain.hid>
From: Thomas De Schampheleire <patrickdepinguin+xenomai@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Xenomai-help] PSOS skin: mismatch in function signatures cause
 buffer overflow
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Ronny Meeus <ronny.meeus@domain.hid>
Cc: Xenomai-help@domain.hid, dietmar.schindler@domain.hid

Hi,

On Mon, Sep 19, 2011 at 9:42 AM, Ronny Meeus <ronny.meeus@domain.hid> wrote:
> On Mon, Sep 19, 2011 at 9:25 AM, =A0<dietmar.schindler@domain.hid> wro=
te:
>>> From: xenomai-help-bounces@domain.hid [mailto:xenomai-help-bounces@domain.hid=
]
>>> On Behalf Of Philippe Gerum
>>> Sent: Sunday, September 18, 2011 5:37 PM
>>> ...
>>> Actually, we used to follow strictly the pSOS convention for this until
>>> 2.4.x, at which point we moved to name strings precisely because
>>> non-null terminated char[4] arrays would break the registry, the way yo=
u
>>> described. This is one of the rare situations where mimicking a useless
>>> limitation of the original API may be challenged by usability concerns
>>> in the new environment, and usability won in that case. The problem
>>> mostly comes from the fact that char[4] is automatically convertible to
>>> const char *, so we have no warning/error leading us to check the
>>> potentially problematic call sites.
>>>
>>> The concern about moving back to char[4] arrays - null-terminated if
>>> shorter - is for people who currently assign strings longer than 4
>>> characters to name their objects. What could be done, is providing a
>>> build switch to select the accepted input, like
>>> --disable-psos-long-names to turn on char[4] interpretation.
>>
>> While I would prefer the switch --enable-psos-long-names, this sounds ok=
ay to me, the more so as it is more than people who use the pSOS skin witho=
ut obeying pSOS rules deserve.
>> --
[..]
>>
>
> Another option would be to introduce a run-time switch.
> The default behavior could be that long names are supported and if the
> "enable_short_names()" function is called, all names will the cut at 4
> characters.
> The advantage of this dynamic switch is that different applications
> using the same library can use the mode they prefer.

I would also be in favor of a runtime setting, rather than a
compile-time one. One cannot assume that all PSOS applications on a
system follow the same rules, or that there cannot be a mix of
'legacy' PSOS applications and 'xenomai-style' ones. According to me,
a library should support all these uses.

Best regards,
Thomas

