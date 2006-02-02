From: Rodrigo Rosenfeld Rosas <lbocseg@domain.hid>
Subject: Re: [Xenomai-help] RTDM timing problems
Date: Thu, 2 Feb 2006 13:23:04 -0200
References: <200601301611.53089.lbocseg@domain.hid>
	<200602021046.00546.lbocseg@domain.hid> <43E1FFAC.3040409@domain.hid>
In-Reply-To: <43E1FFAC.3040409@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
Message-Id: <200602021323.04666.lbocseg@domain.hid>
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Jan Kiszka <jan.kiszka@domain.hid>
Cc: xenomai@xenomai.org

Em Quinta 02 Fevereiro 2006 10:48, voc=3DEA escreveu:

>Rodrigo Rosenfeld Rosas wrote:
>> Em Segunda 30 Janeiro 2006 16:42, Jan Kiszka escreveu:
>>> The point is that rtdm_clock_read() relies on the nucleus timer being
>>> started. Otherwise, it just returns plain wrong numbers.
>>>
>>> This makes me scream again for that damn timer being started
>>> AUTOMATICALLY! I guess Philippe knows what I'm talking about... ;)
>>> Meanwhile, we should state this in the docs. At least for 2.0.x, this
>>> will remain true anyway.
>>
>> What can I do for now? What is the relation between the system time and
>> the timer?
>
>Just start the timer before using rtdm_clock_read().

Sorry, It is not clear to me how can I do that.

Regards,

Rodrigo.

=09

=09
	=09
_______________________________________________________=20
Yahoo! doce lar. Fa=E7a do Yahoo! sua homepage.=20
http://br.yahoo.com/homepageset.html=20



