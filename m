MIME-Version: 1.0
In-Reply-To: <2a01ec5b-11ae-ced0-bc34-e53435926e7e@web.de>
References: <CALTC7XLtQUJ9xqwAbURTDeCHzJouAUjz1Lj0nhMovsEeL0q0EQ@mail.gmail.com>
 <f2b6ba72-043d-135a-b86f-c9ee25419343@web.de>
 <2db36c82-bc3a-7968-77fd-4d338999851e@xenomai.org>
 <2a01ec5b-11ae-ced0-bc34-e53435926e7e@web.de>
From: Cris Almaraz <cristina.almaraz@gmail.com>
Date: Thu, 11 Jul 2019 13:19:30 +0200
Message-ID: <CALTC7XLa3OGs=ygtHoXV3WsJ4Z7X6aqp7hC++aB9aYvRpuo2yQ@mail.gmail.com>
Subject: Re: [PATCH] boilerplate: Fix bogus "typeof(type)" in macros
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Jan Kiszka <jan.kiszka@web.de>
Cc: Philippe Gerum <rpm@xenomai.org>, xenomai <xenomai@xenomai.org>

Thank you for the fast answers!

Enabling the extensions (=C2=A0-=C2=A0-std=3Dgnu++11) has fixed the issue f=
or me.

Anyhow, I noticed that I still cannot use the set_config_tunable() to
set the mem_pool_size. I configure it as described below, but I still
get the warning

WARNING: [APP] heapobj_init() failed for xxx bytes, raise --mem-pool-size?

If I use the command line option  --mem-pool-size it works without any
issues, but I=C2=B4d like to include it in the code.

Also, as secondary issue, I cannot use the syntax of 1G to define the
size, as G is not defined (error below). That=C2=B4s why I have the "GBYTE"
definition.

error: unable to find numeric literal operator =E2=80=98operator"" G=E2=80=
=99

#define GBYTE (1024*1024*1024)
static int my_tune(void){
    set_config_tunable(mem_pool_size, 1*GBYTE);
    printf("mem pool size=3D%ld\n",get_config_tunable(mem_pool_size));
    return 0;
}

static struct setup_descriptor my_setup =3D {
    .name =3D "mySetup",
    .tune =3D my_tune,=09
};

user_setup_call(my_setup);

Any ideas on these points?

Thank you in advance and regards,
Cristina.


El mi=C3=A9., 10 jul. 2019 23:43, Jan Kiszka <jan.kiszka@web.de> escribi=C3=
=B3:
>
> On 10.07.19 22:50, Philippe Gerum wrote:
> > On 7/10/19 9:39 PM, Jan Kiszka via Xenomai wrote:
> >> From: Jan Kiszka <jan.kiszka@siemens.com>
> >>
> >> This was ignored by most compilers so far, but it breaks at least unde=
r
> >> c++11.
> >
> > This was hardly ignored since this evaluates to a required type
> > information, the issue is rather with typeof() belonging to the GNU
> > extension set. Building with -std=3Dgnu++11 solves that issue with the
> > current implementation which generally assumes those extensions are ena=
bled.
>
> If these two cases are the only ones that prevent standard-conforming bui=
lds ouf
> our external headers, I would be in favor of overcoming that limitation. =
But if
> it should be just the tip of the iceberg, it's likely not worth it.
>
> >
> >>
> >> Reported-by: St=C3=A9phane Ancelot <sancelot@numalliance.com>
> >> Reported-by: Cris Almaraz <cristina.almaraz@gmail.com>
> >> Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
> >> ---
> >>
> >> Thanks for reporting (and sorry for the long patch delay). This should
> >> fix it.
> >>
> >>=C2=A0 include/boilerplate/tunables.h | 4 ++--
> >>=C2=A0 1 file changed, 2 insertions(+), 2 deletions(-)
> >>
> >> diff --git a/include/boilerplate/tunables.h b/include/boilerplate/tuna=
bles.h
> >> index db8523be67..38f414e455 100644
> >> --- a/include/boilerplate/tunables.h
> >> +++ b/include/boilerplate/tunables.h
> >> @@ -37,10 +37,10 @@ static inline int __may_change_config_tunable(void=
)
> >>=C2=A0 =C2=A0 =C2=A0 __read_ ## __name ## _ ## __scope
> >>
> >>=C2=A0 #define __define_tunable(__name, __type, __val, __scope)=C2=A0 =
=C2=A0 \
> >> -=C2=A0 =C2=A0 void __tunable_set_call(__name, __scope)(typeof(__type)=
 __val)
> >> +=C2=A0 =C2=A0 void __tunable_set_call(__name, __scope)(__type __val)
> >>
> >>=C2=A0 #define __read_tunable(__name, __type, __scope)=C2=A0 =C2=A0 =C2=
=A0\
> >> -=C2=A0 =C2=A0 typeof(__type) __tunable_get_call(__name, __scope)(void=
)
> >> +=C2=A0 =C2=A0 __type __tunable_get_call(__name, __scope)(void)
> >>
> >>=C2=A0 #define define_config_tunable(__name, __type, __val)=C2=A0 =C2=
=A0 =C2=A0 =C2=A0 \
> >>=C2=A0 =C2=A0 =C2=A0 __define_tunable(__name, __type, __val, config)
> >> --
> >
> >
> > That won't work with non-trivial type expr like this one:
> >
> > int (*foo_handler)(void);
> >
> > define_config_tunable(foobar, int (*)(void), handler)
> > {
> >=C2=A0 =C2=A0 =C2=A0 =C2=A0foo_handler =3D handler;
> > }
> >
> > And we have those in the field already.
> >
>
> Out of tree? I didn't find any in-tree build issues.
>
> Jan

