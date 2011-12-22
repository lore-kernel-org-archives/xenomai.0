MIME-Version: 1.0
In-Reply-To: <4EF2FCD9.5010105@domain.hid>
References: <4EF27CD5.4060603@domain.hid>
	<4EF2FCD9.5010105@domain.hid>
Date: Thu, 22 Dec 2011 14:33:06 +0100
Message-ID: <CAKvQZ_323WScmgq748=rfnVwq534Ln56VMgb9hDt=R4O19=TLQ@mail.gmail.com>
From: Willy Lambert <lambert.willy@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Xenomai-help] hang in rtcansend
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
Cc: Andrew Tannenbaum <trb@domain.hid>, xenomai@xenomai.org

2011/12/22 Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>:
> On 12/22/2011 01:41 AM, Andrew Tannenbaum wrote:
>> If I just run rtcansend with no args (so it prints a help message), it
>> exits ok on 2.6.0 with no hang. =A0But if I run rtcansend or rtcanrecv
>> with any CAN i/o, they hang in the cleanup function, though they do
>> their processing before then correctly.
>>
>> Any idea why rtcansend/recv would hang for me here on 2.6.0?
>
> Is this behaviour reproducible with the virtual rtcan driver?
>
>

For your information, I have a similar behavior with the same Linux
2.5.38.8 and Xenomai 2.6.0 config. As I did not used the CAN before I
didn't reported it.

> --
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0Gilles.
>
> _______________________________________________
> Xenomai-help mailing list
> Xenomai-help@domain.hid
> https://mail.gna.org/listinfo/xenomai-help

