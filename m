MIME-Version: 1.0
In-Reply-To: <4EF34E86.2020606@domain.hid>
References: <4EF27CD5.4060603@domain.hid>
	<4EF2FCD9.5010105@domain.hid>
	<CAKvQZ_323WScmgq748=rfnVwq534Ln56VMgb9hDt=R4O19=TLQ@mail.gmail.com>
	<4EF34E86.2020606@domain.hid>
Date: Thu, 22 Dec 2011 16:47:14 +0100
Message-ID: <CAKvQZ_3LHPV-Y67MU19atHAwB1kdMCt=9faGsOGDAWrwzJ8ZBw@domain.hid>
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
> On 12/22/2011 02:33 PM, Willy Lambert wrote:
>> 2011/12/22 Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>:
>>> On 12/22/2011 01:41 AM, Andrew Tannenbaum wrote:
>>>> If I just run rtcansend with no args (so it prints a help message), it
>>>> exits ok on 2.6.0 with no hang. =A0But if I run rtcansend or rtcanrecv
>>>> with any CAN i/o, they hang in the cleanup function, though they do
>>>> their processing before then correctly.
>>>>
>>>> Any idea why rtcansend/recv would hang for me here on 2.6.0?
>>>
>>> Is this behaviour reproducible with the virtual rtcan driver?
>>>
>>>
>>
>> For your information, I have a similar behavior with the same Linux
>> 2.5.38.8 and Xenomai 2.6.0 config. As I did not used the CAN before I
>> didn't reported it.
>
> Have you tried attaching gdb when rtcansend is locked to see where the
> bug happens?
>

No, it was just a test to see if xenomai was a possible part of my
design. As something is not supporting xenomai in my framework, I
decided to stay with gnulinux for the present time. So I can't test it
for now. I'm sorry, it was just to say that the problem was not
localized to Andrew's one.


> --
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0Gilles.

