Message-ID: <4EEB3614.4080805@domain.hid>
Date: Fri, 16 Dec 2011 13:14:12 +0100
From: Anders Blomdell <anders.blomdell@domain.hid>
MIME-Version: 1.0
References: <4EE9FD4A.1090202@domain.hid>
	<CAMwkeZw4X15HU7ABUhvLpXuu1Sbspen6FK7XvjHiQLXg0AcazQ@mail.gmail.com>
	<4EEB304B.2010108@domain.hid>
	<CAMwkeZyxGbvYRzDGJucFd-1n4iALRQed5x+fMCVMTFzWYPvfnw@domain.hid>
In-Reply-To: <CAMwkeZyxGbvYRzDGJucFd-1n4iALRQed5x+fMCVMTFzWYPvfnw@domain.hid>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Xenomai-help] Big differences in analogy interrupt handling
 time
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: =?UTF-8?B?RmVybmFuZG8gSGVycmVybyBDYXJyw7Nu?= <elferdo@domain.hid>
Cc: "xenomai@xenomai.org" <xenomai@xenomai.org>

On 12/16/2011 12:57 PM, Fernando Herrero Carr=C3=B3n wrote:
>   [...]
>
>> Nice that somebody has already tested this.
>>
>
>
>> Nobody that has any insight on what might slow down execution with 20%
>> (curious mind wants to know)?
>>
>
> Dear Anders,
>
> I am afraid I don't understand your question. 20% with respect to what?
> Indeed, the "sync_dma" function performs some copy between kernel/user
> space. The old code performs exactly the same copy ten times, which
> multiplies the time spent in the interrupt handler tenfold, and adds 10=
us
> in idle wait. Besides that, I believe that the most time spent in an
> interrupt handler is in the i-pipe dispatching mechanism itself.
20% difference in execution time in identical code paths (attachment 'A'=20
and 'B'), where executing the same codepath in 'B' takes 20% longer time=20
than in 'A'

>
> There are for sure other people in the list more knowledgeable than me =
on
> this subject.
And me, obviously.


--=20
Anders Blomdell                  Email: anders.blomdell@domain.hid
Department of Automatic Control
Lund University                  Phone:    +46 46 222 4625
P.O. Box 118                     Fax:      +46 46 138118
SE-221 00 Lund, Sweden


