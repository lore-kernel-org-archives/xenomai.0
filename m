MIME-Version: 1.0
Sender: patrickdepinguin@domain.hid
In-Reply-To: <4E80F2A0.9030500@domain.hid>
References: <CAAXf6LVErpVae0HVcqv4Rc6p2wnJLje7He2NJC7S1aCSVnD9NQ@mail.gmail.com>
	<1316360236.2169.40.camel@domain.hid>
	<8236197CA3DA864F9EF20609D9887263B4D0@domain.hid>
	<CAMJ=MEeOS2K09fm0hnvSmxn6CBbMjHaC-uhDr03qNoZTaEbWVA@mail.gmail.com>
	<CAAXf6LX4gfVncvRo5UTyMrqWHhJ6K0ioksyTqvovAjpJyZWS3w@domain.hid>
	<4E80F2A0.9030500@domain.hid>
Date: Wed, 12 Oct 2011 16:03:42 +0200
Message-ID: <CAAXf6LXQ=Jq5E_JV_JSbqE1wgheaVLLLZQDyRn5TSmrET-PKVA@mail.gmail.com>
From: Thomas De Schampheleire <patrickdepinguin+xenomai@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Xenomai-help] PSOS skin: mismatch in function signatures cause
 buffer overflow
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
Cc: Xenomai-help@domain.hid, dietmar.schindler@domain.hid

Hi,

On Mon, Sep 26, 2011 at 11:46 PM, Gilles Chanteperdrix
<gilles.chanteperdrix@xenomai.org> wrote:
> On 09/19/2011 10:45 AM, Thomas De Schampheleire wrote:
>> Hi,
>>
>> On Mon, Sep 19, 2011 at 9:42 AM, Ronny Meeus <ronny.meeus@domain.hid> wro=
te:
>>> On Mon, Sep 19, 2011 at 9:25 AM, =A0<dietmar.schindler@domain.hid> w=
rote:
>>>>> From: xenomai-help-bounces@domain.hid [mailto:xenomai-help-bounces@domain.hid=
rg]
>>>>> On Behalf Of Philippe Gerum
>>>>> Sent: Sunday, September 18, 2011 5:37 PM
>>>>> ...
>>>>> Actually, we used to follow strictly the pSOS convention for this unt=
il
>>>>> 2.4.x, at which point we moved to name strings precisely because
>>>>> non-null terminated char[4] arrays would break the registry, the way =
you
>>>>> described. This is one of the rare situations where mimicking a usele=
ss
>>>>> limitation of the original API may be challenged by usability concern=
s
>>>>> in the new environment, and usability won in that case. The problem
>>>>> mostly comes from the fact that char[4] is automatically convertible =
to
>>>>> const char *, so we have no warning/error leading us to check the
>>>>> potentially problematic call sites.
>>>>>
>>>>> The concern about moving back to char[4] arrays - null-terminated if
>>>>> shorter - is for people who currently assign strings longer than 4
>>>>> characters to name their objects. What could be done, is providing a
>>>>> build switch to select the accepted input, like
>>>>> --disable-psos-long-names to turn on char[4] interpretation.
>>>>
>>>> While I would prefer the switch --enable-psos-long-names, this sounds =
okay to me, the more so as it is more than people who use the pSOS skin wit=
hout obeying pSOS rules deserve.
>>>> --
>> [..]
>>>>
>>>
>>> Another option would be to introduce a run-time switch.
>>> The default behavior could be that long names are supported and if the
>>> "enable_short_names()" function is called, all names will the cut at 4
>>> characters.
>>> The advantage of this dynamic switch is that different applications
>>> using the same library can use the mode they prefer.
>>
>> I would also be in favor of a runtime setting, rather than a
>> compile-time one. One cannot assume that all PSOS applications on a
>> system follow the same rules, or that there cannot be a mix of
>> 'legacy' PSOS applications and 'xenomai-style' ones. According to me,
>> a library should support all these uses.
>
> Hi,
>
> here is a patch which truncates identifiers to four characters and
> terminates them by a '\0' character, in order to avoid the issues at
> the origin of this thread. The patch also adds a variable
> "psos_long_names", 0 by default, which may be set to a non-zero value
> to enable the old behaviour (assume the identifier strings may be
> longer than 4 characters and are already null terminated).
>
> Could someone with the issue test it?

It seems this slipped through the cracks, my apologies. We already
implemented this ourselves similarly, we didn't actually test your
patch so far.

Now that we're trying out xenomai-forge, I ported this patch and tested it.
There are a few problems with it (also relevant to cobalt xenomai)

* a bug in __psos_maybe_short_name so that only 3 characters are
retained (see below)
* the call to __psos_maybe_short_name also needs to be done in the
_ident functions
* although we don't use it, I think the pt_create and pt_ident
functions also need to be adapted

Moreover, I wonder why you have made psos_long_names an exported
global variable. Sharing variables between two different pieces of
software is not very clean. I think it would be nicer with a get/set
function.


> diff --git a/include/psos+/psos.h b/include/psos+/psos.h
> index 32281bc..4a3921a 100644
> --- a/include/psos+/psos.h
> +++ b/include/psos+/psos.h
> @@ -197,6 +197,8 @@ u_long t_restart(u_long tid,
>
> =A0#include <psos+/syscall.h>
>
> +extern unsigned psos_long_names;
> +
> =A0#endif /* __KERNEL__ || __XENO_SIM__ */
>
> =A0/*
> diff --git a/src/skins/psos+/init.c b/src/skins/psos+/init.c
> index 978a4f1..e53967b 100644
> --- a/src/skins/psos+/init.c
> +++ b/src/skins/psos+/init.c
> @@ -26,6 +26,8 @@ int __psos_muxid =3D -1;
>
> =A0xnsysinfo_t __psos_sysinfo;
>
> +unsigned psos_long_names;
> +
> =A0static __attribute__ ((constructor))
> =A0void __init_xeno_interface(void)
> =A0{
> @@ -68,3 +70,14 @@ void k_fatal(u_long err_code, u_long flags)
> =A0{
> =A0 =A0 =A0 =A0exit(1);
> =A0}
> +
> +const char *__psos_maybe_short_name(char shrt[5], const char *lng)
> +{
> + =A0 =A0 =A0 if (psos_long_names)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return lng;
> +
> + =A0 =A0 =A0 strncpy(shrt, lng, sizeof(shrt) - 1);

Because shrt is passed as parameter, it is passed as pointer and not
as array. This means there is no size information, and thus
sizeof(shrt) equals the size of a pointer (4 on our 32-bit platform).
As a result, only ABC of a name ABCD are copied.

You'll need to explicitly do:

strncpy(shrt, lng, 5 - 1);

> + =A0 =A0 =A0 shrt[4] =3D '\0';
> +
> + =A0 =A0 =A0 return (const char *)shrt;
> +}
> diff --git a/src/skins/psos+/queue.c b/src/skins/psos+/queue.c
> index c54f966..c8c1933 100644
> --- a/src/skins/psos+/queue.c
> +++ b/src/skins/psos+/queue.c
> @@ -17,11 +17,14 @@
> =A0*/
>
> =A0#include <psos+/psos.h>
> +#include <psos+/long_names.h>
>
> =A0extern int __psos_muxid;
>
> =A0u_long q_create(const char *name, u_long maxnum, u_long flags, u_long =
*qid_r)
> =A0{
> + =A0 =A0 =A0 char short_name[5];
> + =A0 =A0 =A0 name =3D __psos_maybe_short_name(short_name, name);
> =A0 =A0 =A0 =A0return XENOMAI_SKINCALL4(__psos_muxid, __psos_q_create,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 name, max=
num, flags, qid_r);
> =A0}
> diff --git a/src/skins/psos+/rn.c b/src/skins/psos+/rn.c
> index f254e37..2219f36 100644
> --- a/src/skins/psos+/rn.c
> +++ b/src/skins/psos+/rn.c
> @@ -24,6 +24,7 @@
> =A0#include <stdio.h>
> =A0#include <nucleus/heap.h>
> =A0#include <psos+/psos.h>
> +#include <psos+/long_names.h>
>
> =A0extern int __psos_muxid;
>
> @@ -59,6 +60,7 @@ u_long rn_create(const char name[4],
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 u_long usize, u_long flags, u_long *rnid,=
 u_long *allocsz)
> =A0{
> =A0 =A0 =A0 =A0struct rninfo rninfo;
> + =A0 =A0 =A0 char short_name[5];
> =A0 =A0 =A0 =A0struct {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0u_long rnsize;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0u_long usize;
> @@ -66,6 +68,8 @@ u_long rn_create(const char name[4],
> =A0 =A0 =A0 =A0} sizeopt;
> =A0 =A0 =A0 =A0u_long err;
>
> + =A0 =A0 =A0 name =3D __psos_maybe_short_name(short_name, name);
> +
> =A0 =A0 =A0 =A0if (rnaddr)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0fprintf(stderr,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0"rn_create() - rnaddr para=
meter ignored from user-space context\n");
> diff --git a/src/skins/psos+/sem.c b/src/skins/psos+/sem.c
> index 5020274..2bea943 100644
> --- a/src/skins/psos+/sem.c
> +++ b/src/skins/psos+/sem.c
> @@ -17,11 +17,14 @@
> =A0*/
>
> =A0#include <psos+/psos.h>
> +#include <psos+/long_names.h>
>
> =A0extern int __psos_muxid;
>
> =A0u_long sm_create(const char name[4], u_long icount, u_long flags, u_lo=
ng *smid_r)
> =A0{
> + =A0 =A0 =A0 char short_name[5];
> + =A0 =A0 =A0 name =3D __psos_maybe_short_name(short_name, name);
> =A0 =A0 =A0 =A0return XENOMAI_SKINCALL4(__psos_muxid, __psos_sm_create,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 name, ico=
unt, flags, smid_r);
> =A0}
> diff --git a/src/skins/psos+/task.c b/src/skins/psos+/task.c
> index a43f7fb..ab04ed8 100644
> --- a/src/skins/psos+/task.c
> +++ b/src/skins/psos+/task.c
> @@ -26,6 +26,7 @@
> =A0#include <memory.h>
> =A0#include <string.h>
> =A0#include <psos+/psos.h>
> +#include <psos+/long_names.h>
> =A0#include <asm-generic/bits/sigshadow.h>
> =A0#include <asm-generic/bits/current.h>
> =A0#include <asm-generic/stack.h>
> @@ -128,6 +129,9 @@ u_long t_create(const char *name,
> =A0 =A0 =A0 =A0int policy;
> =A0 =A0 =A0 =A0long err;
>
> + =A0 =A0 =A0 char short_name[5];
> + =A0 =A0 =A0 name =3D __psos_maybe_short_name(short_name, name);
> +
> =A0 =A0 =A0 =A0/* Migrate this thread to the Linux domain since we are ab=
out
> =A0 =A0 =A0 =A0 =A0 to issue a series of regular kernel syscalls in order=
 to
> =A0 =A0 =A0 =A0 =A0 create the new Linux thread, which in turn will be ma=
pped
>

I'll send the updated patch for xenomai-forge later.

Best regards,
Thomas

