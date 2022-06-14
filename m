References: <PH1P110MB10501E47843444D61312A452E2AB9@PH1P110MB1050.NAMP110.PROD.OUTLOOK.COM>
 <e6438951abfa01c114c58b9ab27ff033c4006308.camel@sprinte.eu>
 <87bkuvsph4.fsf@xenomai.org>
 <fed181147dbf1ece306f055e435dd0355d352f8e.camel@sprinte.eu>
 <877d5jsm1j.fsf@xenomai.org>
 <7ed5f664d9a0df0a14ce88d684dc0f4f7b389a05.camel@sprinte.eu>
 <87y1xzr4il.fsf@xenomai.org>
 <a48d190418eb74605afdaa9e46303ff489a49fbe.camel@siemens.com>
 <5602727079218fbbc7d1aeb488c6c3e399f34de2.camel@sprinte.eu>
From: Philippe Gerum <rpm@xenomai.org>
Subject: Re: <evl/heap.h> compile conflict with Boost
Date: Tue, 14 Jun 2022 12:43:00 +0200
In-reply-to: <5602727079218fbbc7d1aeb488c6c3e399f34de2.camel@sprinte.eu>
Message-ID: <87tu8nqzj7.fsf@xenomai.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Julien Blanc <julien.blanc@sprinte.eu>
Cc: "rpm@xenomai.org" <rpm@xenomai.org>, "florian.bezdeka@siemens.com" <florian.bezdeka@siemens.com>, "Xenomai@xenomai.org" <Xenomai@xenomai.org>


Julien Blanc <julien.blanc@sprinte.eu> writes:

> Le mardi 14 juin 2022 =C3=A0 09:44 +0000, Bezdeka, Florian a =C3=A9crit :
>>=20
>> Based on the kernel's fallthrough, introducing evl_fallthrough would
>> avoid all kinds of conflicts (IMHO):
>>=20
>> #ifndev evl_fallthrough
>> #if __has_attribute(__fallthrough__)
>> # define evl_fallthrough	__attribute__((__fallthrough__))
>> #else
>> # define evl_fallthrough	do {} while (0)  /* fallthrough */
>> #endif
>> #endif
>>=20
>> All evl internal users would have to be migrated.
>
> In that case, wouldn't it make sense to migrate *all* macros in
> compiler.h to an evl-prefix (nonwithstanding the fact that it's gonna
> break a lot of code)? Or are they supposed to be already defined and
> compiler.h is here just as a fallback (in which case, it makes sense to
> stick with the __ prefix) ?
>

I'd favor the fallthrough -> __fallthrough option to align on other
macros from compiler.h. Using the evl_ prefix for generic,
compiler-level code looks odd.

--=20
Philippe.

