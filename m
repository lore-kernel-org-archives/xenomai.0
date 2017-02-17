MIME-Version: 1.0
In-Reply-To: <58a6e2ca5ab7e5.39693661@wp.pl>
References: <58a6e2ca5ab7e5.39693661@wp.pl>
From: Norbert Lange <nolange79@gmail.com>
Date: Fri, 17 Feb 2017 13:04:17 +0100
Message-ID: <CADYdroNGNbQ5nhOFZXrs9POUY+sw0RtBNwkki_G--dKHhRF5zg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Xenomai] RtNet and Interrupts
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Mariusz Janiak <mariuszjaniak@wp.pl>
Cc: Xenomai <xenomai@xenomai.org>

2017-02-17 12:47 GMT+01:00 Mariusz Janiak <mariuszjaniak@wp.pl>:
> Dnia Pi=C4=85tek, 17 Lutego 2017 12:19 Norbert Lange <nolange79@gmail.com=
> napisa=C5=82(a)
> *snip*
>
> Maybe author of the RTnet stack can give better answer, but in my opinion=
, in the case of the hard RT communication, we have to know in advance what=
 is the maximum packet delivery time. The RTnet guarantee fixed time packet=
 delivery. There is always a trad off between bandwidth and latency, you ca=
n't have both.

Sure, but there is also "low latency" and "guaranteed latency", the
later is affected and hard to prove if you can`t bound eg. the IRQs to
a specific maximum.
Hmm, probably an issue though, as the RtNet Protocol wants to
synchronize clocks as well. We have synchronized clocks via a
dedicated PPS wire, so we wouldn`t need that.
Using PTP Hardware could probably fix that.

>
>> No efforts in using something similar to "New API"? (who comes up with
>> such names...)
>
> I remember a discussion about NAPI in context of  RTnet stack, but I don'=
t know if any attempts have been made.

Ok, any way to search the mailing list, havent found any?

> *snip*
>
> Unfortunately I can't help.

No prob.

Kind regards, Norbert

