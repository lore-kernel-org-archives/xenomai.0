References: <PH1P110MB10501E47843444D61312A452E2AB9@PH1P110MB1050.NAMP110.PROD.OUTLOOK.COM>
 <e6438951abfa01c114c58b9ab27ff033c4006308.camel@sprinte.eu>
From: Philippe Gerum <rpm@xenomai.org>
Subject: Re: <evl/heap.h> compile conflict with Boost
Date: Tue, 14 Jun 2022 08:54:12 +0200
In-reply-to: <e6438951abfa01c114c58b9ab27ff033c4006308.camel@sprinte.eu>
Message-ID: <87bkuvsph4.fsf@xenomai.org>
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
Cc: "russell.johnson@kratosdefense.com" <russell.johnson@kratosdefense.com>, xenomai@xenomai.org


Julien Blanc via Xenomai <xenomai@xenomai.org> writes:

> Le lundi 13 juin 2022 =C3=A0 14:39 +0000, Russell Johnson via Xenomai a
> =C3=A9crit :
>>  I use boost throughout my entire app, so I need
>> to figure how to get both of these libraries to play nice with each
>> other. Any ideas? ( I am using gcc 8.3 and boost 1.70.0)
>>=20
>> /opt/evl/include/evl/compiler.h:64:36: error: '__fallthrough__' was
>> not
>> declared in this scope
>>=20
>> #define fallthrough __attribute__((__fallthrough__))
>>=20
>>                                     ^~~~~~~~~~~~~~~
>
> This line looks wrong. The correct way to use the fallthrough attribute
> (at least with gcc) is __attribute__((fallthrough)) , so that will
> conflict with any usage (not only boost's).
>
> It should probably be fixed by:
>
> #define __fallthrough	__attribute__((fallthrough))
>
> Regards,
>
> Julien

6.39. attribute syntax
https://gcc.gnu.org/onlinedocs/gcc/Attribute-Syntax.html#Attribute-Syntax

PS: fixes go with patches.

--=20
Philippe.

