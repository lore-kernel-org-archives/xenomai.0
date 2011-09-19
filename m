From: <dietmar.schindler@domain.hid>
Date: Mon, 19 Sep 2011 06:59:00 +0000
Message-ID: <8236197CA3DA864F9EF20609D9887263B4AF@rrxchngmbx01.mro.roland-man.biz>
References: <CAAXf6LVErpVae0HVcqv4Rc6p2wnJLje7He2NJC7S1aCSVnD9NQ@mail.gmail.com>
In-Reply-To: <CAAXf6LVErpVae0HVcqv4Rc6p2wnJLje7He2NJC7S1aCSVnD9NQ@mail.gmail.com>
Content-Language: de-DE
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: Re: [Xenomai-help] PSOS skin: mismatch in function signatures
	cause	buffer overflow
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Xenomai-help@domain.hid

> From: xenomai-help-bounces@domain.hid [mailto:xenomai-help-bounces@domain.hid]
> On Behalf Of Thomas De Schampheleire
> Sent: Friday, September 16, 2011 3:00 PM
> ...
> The original PSOS interfaces that take a name (like t_create,
> sm_create etc), expect a character array with length 4:
> ...
> while the corresponding PSOS skin in Xenomai expects a null-terminated
> character array (a real string):
> ...
>
> In certain situations, this difference gives rise to a buffer overflow
> on the name variable.
> For example:
>
>         unsigned long smid, err;
>         {
>                 char id[4] =3D {'S','E','M','0'};
>                 err =3D sm_create(id,0,SM_PRIOR,&smid);
>         }
>         {
>                 char id[4] =3D "SEM";
>                 id[3] =3D '1';
>                 err =3D sm_create(id,0,SM_PRIOR,&smid);
>         }
>         {
>                 char id[4] =3D "SEM2";
>                 err =3D sm_create(id,0,SM_PRIOR,&smid);
>         }
> ...
>
> ... The third one (SEM2)
> is dubious because the end-of-string character will overflow the
> array, ...

This is not true, according to ISO/IEC 9899:TC3 Programming languages - C, =
=A76.7.8 Initialization:
...
14 An array of character type may be initialized by a character string lite=
ral, optionally enclosed in braces. Successive characters of the character =
string literal (including the terminating null character if there is room o=
r if the array is of unknown size) initialize the elements of the array.
...
32 EXAMPLE 8 The declaration
      char s[] =3D "abc", t[3] =3D "abc";
defines ''plain'' char array objects s and t whose elements are initialized=
 with character string literals.
This declaration is identical to
      char s[] =3D { 'a', 'b', 'c', '\0' },
           t[] =3D { 'a', 'b', 'c' };

> On target, this creates the following semaphores (taken from the
> registry):
>
> # ls /proc/xenomai/registry/psos/semaphores/SEM*
> ...
> /proc/xenomai/registry/psos/semaphores/SEM0????p????_S22753
> /proc/xenomai/registry/psos/semaphores/SEM1p????_S22753
> /proc/xenomai/registry/psos/semaphores/SEM2?_S22753
>
> As you can see, in all cases there was an array overflow (the question
> marks correspond to non-ASCII characters), caused by the missing
> null-termination (in itself caused by a mismatch between the original
> PSOS interface and the Xenomai PSOS skin implementation of it).

I would prefer to call this an array overrun (to distinguish the reading pa=
st the end of the array here from writing past the end), even though that i=
s not a generally accepted distinction.

> If you do not explicitly create a character array of length 4, e.g.
> (char id[] =3D "SEM1") then the Xenomai code obviously works fine: it
> receives a null-terminated string, as it expects.
>
>
> To fix this problem, the PSOS skin should treat incoming names as
> non-null-terminated character arrays of length 4, and explicitly add
> null-termination before passing it to the nucleus.
>
> What is your view on this?

I agree.
--
Regards,
Dietmar
________________________________________ manroland AG Vorsitzender des Aufs=
ichtsrates: Hanno C. Fiedler Vorstand: Gerd Finkbeiner (Vorsitzender), Dr. =
Ingo Koch, Dr. Markus Rall, Paul Steidle Sitz der Gesellschaft: Offenbach a=
m Main, Registergericht: Amtsgericht Offenbach HRB-Nr. 42592 USt-Ident-Nr. =
DE 250200933


