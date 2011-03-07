MIME-Version: 1.0
In-Reply-To: <1299408619.2116.0.camel@domain.hid>
References: <AANLkTikq49CMPG=-nFDOhc+Qc1iuK3kHyMpsJ+NCzFUX@mail.gmail.com>
	<1299408619.2116.0.camel@domain.hid>
Date: Mon, 7 Mar 2011 11:23:04 +0800
Message-ID: <AANLkTim9r1WbQ3B4C_qpiH413YoXQVc6WL_=GjJa7v-H@mail.gmail.com>
From: arethe rtai <arethe.rtai@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Xenomai-core] Whether can Xenomai bypass the cache?
List-Id: Xenomai life and development <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Philippe Gerum <rpm@xenomai.org>
Cc: Xenomai-core@domain.hid

3x for your response, I am a software developer in field of industrial
control system. These systems require hard real-time support, even
exact temporal behavior. The cache is a major source of uncertainty,
is it necessary to disable cache for some critical hard real-time
tasks? I am looking forward to your professional adivce.
3x
regards arethe

2011/3/6 Philippe Gerum <rpm@xenomai.org>:
> On Sun, 2011-03-06 at 14:05 +0800, arethe rtai wrote:
>> Hello:
>> =A0 =A0 As known, cache can accelerate the memory access, but
>> unfortunately, it would decrease the predictability of real-time tasks'
>> temporal behaviour. Many tasks of our application prefer
>> predictability to the speed of execution. Intel's processors after P6
>> include MTRR and PAT, both the two units can be used to bypass the
>> cache.
>> =A0 =A0 I wonder whether Xenomai can bypass the cache, and whether Xenom=
ai
>> can manage the MTRR or PAT?
>
>
> No.
>
>> If the answers are true, how to use the
>> function?
>> 3x
>> arethe
>>
>> _______________________________________________
>> Xenomai-core mailing list
>> Xenomai-core@domain.hid
>> https://mail.gna.org/listinfo/xenomai-core
>
> --
> Philippe.
>
>
>

