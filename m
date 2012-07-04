MIME-Version: 1.0
In-Reply-To: <4FF369E5.5040007@xenomai.org>
References: <CAL7_A_WEXhEBQr+LFb_mfaqLxBh=hsHJg6WiY08cmkgb=Y2TNA@mail.gmail.com>
	<4FF369E5.5040007@xenomai.org>
Date: Wed, 4 Jul 2012 10:36:37 +0200
Message-ID: <CAL7_A_WYVjFhh9RuxAm1jtVp7HqakB5gEzkSt8i7XsWJNJrh=Q@mail.gmail.com>
From: =?ISO-8859-1?Q?Jens_K=F6hler?= <jenskxxx@googlemail.com>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Xenomai] Xenomai and normal linux application - Wait time with
 select() not reliable
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: xenomai@xenomai.org

Thank you for your response Gilles. I set thread to SCHED_FIFO policy
with chrt command, Prio 99. But there is no improvement. Also
nanosleep do not help. The kernel is 2.6.26. What could be reason that
kernel is not restart thread when time is over?

Jens

2012/7/3, Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>:
> On 07/03/2012 03:30 PM, Jens K=F6hler wrote:
>> Hello all,
>>
>> I have a normal linux application running. Application waits in
>> following loop normally about 8 ms. Delay time of 8ms is reliable.
>>
>> do
>>    {
>>       remain(&remainTime);
>>
>>       if ((remainTime.tv_sec !=3D 0L) || (remainTime.tv_usec !=3D 0L))
>>          result =3D select(0, NULL, NULL, NULL, &remainTime);
>>       else
>>          break;
>>    }
>>    while ((result =3D=3D -1) && (errno =3D=3D EINTR));
>>
>> If there is running in parallel a Xenomai application the wait time
>> could be up to 40 ms accidentally. What could be the reason?
>
> Are you sure the "select" service guarantees delays with the version of
> the linux kernel you use? Is the thread running with SCHED_FIFO policy?
> If yes, what happens if you replace with nanosleep?
>
> --
>                                                                 Gilles.
>
>

