References: <PH1P110MB10501E47843444D61312A452E2AB9@PH1P110MB1050.NAMP110.PROD.OUTLOOK.COM>
 <e6438951abfa01c114c58b9ab27ff033c4006308.camel@sprinte.eu>
 <87bkuvsph4.fsf@xenomai.org>
 <fed181147dbf1ece306f055e435dd0355d352f8e.camel@sprinte.eu>
 <877d5jsm1j.fsf@xenomai.org>
 <7ed5f664d9a0df0a14ce88d684dc0f4f7b389a05.camel@sprinte.eu>
From: Philippe Gerum <rpm@xenomai.org>
Subject: Re: <evl/heap.h> compile conflict with Boost
Date: Tue, 14 Jun 2022 11:01:22 +0200
In-reply-to: <7ed5f664d9a0df0a14ce88d684dc0f4f7b389a05.camel@sprinte.eu>
Message-ID: <87y1xzr4il.fsf@xenomai.org>
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
Cc: "rpm@xenomai.org" <rpm@xenomai.org>, "Xenomai@xenomai.org" <Xenomai@xenomai.org>


Julien Blanc <julien.blanc@sprinte.eu> writes:

> Le mardi 14 juin 2022 =C3=A0 10:04 +0200, Philippe Gerum a =C3=A9crit :
>> Julien Blanc <
>> julien.blanc@sprinte.eu
>> > writes:
>>=20
>> > Le mardi 14 juin 2022 =C3=A0 08:54 +0200, Philippe Gerum a =C3=A9crit :
>> > > Julien Blanc via Xenomai=20
>> > > > #define __fallthrough	__attribute__((fallthrough))
>> > > >=20
>> > >=20
>> > > 6.39. attribute syntax
>> > > https://gcc.gnu.org/onlinedocs/gcc/Attribute-Syntax.html#Attribute-S=
yntax
>> > >=20
>> > >=20
>> >=20
>> > Not sure what you mean with this link. The relevant attribute is
>> > documented here:=20
>> > https://gcc.gnu.org/onlinedocs/gcc/Statement-Attributes.html
>> >=20
>> >=20
>> > > PS: fixes go with patches.
>> >=20
>> > Indeed, but i'll let Russel do this one as i don't have the
>> > opportunity
>> > to test it right now.
>> >=20
>>=20
>> The documentation (paragraph 6.39) states that "You may optionally
>> specify attribute names with =E2=80=98__=E2=80=99 preceding and followin=
g the name.
>> This allows you to use them in header files without being concerned
>> about a possible macro of the same name. For example, you may use the
>> attribute name __noreturn__ instead of noreturn.".
>>=20
>> This is generally used with C attributes as a precaution against
>> namespace conflicts in the C language space. IOW, making a C++ parser
>> happy is ok with me as long as this does not introduce potential
>> issues down the road with regular C code.
>
> Missed that part, thanks. The issue here is thus not within the
> attribute part, which can be either fallthrough or __fallthrough__, but
> only in the macro name, which should be __fallthrough instead of just
> fallthrough.

Fine by me now, two remarks though: as Florian noted, this patch breaks
all current users in libevl, plus a meaningful commit log explaining why
such change is needed would helpful for reviewers.
(e.g. fixing conflict with C++ [[fallthough]], and maybe at some point
in the future with the C2X standard).

--=20
Philippe.

