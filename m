Message-ID: <435A6DA3.1030506@domain.hid>
Date: Sat, 22 Oct 2005 18:49:39 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-core] [Fwd: Re: [Xenomai-help] timeout in native API
	calls (cond, sem, mutex, etc).]
References: <435926CE.1090201@domain.hid>
	<200510221551.25114.dmitry.adamushko@domain.hid>
	<435A594D.2060608@domain.hid>
In-Reply-To: <435A594D.2060608@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enigD31A60E830E97C39910B8BF5"
Sender: jan.kiszka@domain.hid
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Philippe Gerum <rpm@xenomai.org>
Cc: xenomai@xenomai.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigD31A60E830E97C39910B8BF5
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit

Philippe Gerum wrote:
> Dmitry Adamushko wrote:
> 
>> On Friday 21 October 2005 19:35, Philippe Gerum wrote:
>>
>>> Actually, there is a more general problem with the current coding style
>>> used throughout the code base: it's mine, it's not that standard,
>>
>>
>>
>> then what's standard in this case?
>>
> 
> By standard, I mean the one which is the most widely used in the context
> of kernel development, which is relevant to the larger and most active
> part of the Xenomai codebase.
> 
>>
>>> and now thatmore people are contributing to it, I'm pondering whether
>>> we should
>>> just adoptthe conventional kernel coding style, without the ludicrous
>>> 8-space tabs, that is.
>>
>>
>>
>> The "kernel coding style" is just yet another codding style. If more
>> people are contributing to the project, then it should be a standard
>> that satisfies the most part of them. Is it necessarily the linux way?
>> As I told you once, the important thing is how easily the code may be
>> read, hence, understood. IMHO, how/where the braces, etc. are placed
>> is not the matter of the first instance.
>> The use of any codding style doesn't result in neat and well-readable
>> code automagically.
>>
>> Nevertheless, if the ideas are as follows:
>>
>> 1) linux codding style as a part of the seamless integration with the
>> linux kernel. err.., what about a possibility to be merged with the
>> mainline kernel? ok, sounds almost impossible :) ;
>>
> 
> Maybe on April 1st.
> 
>> 2) linux people are reading/will read the code, there are a lot of
>> style-adherents amongst them, so let's keep them satisfied and our
>> mail boxes free of the messages like "first change your codding style
>> before submitting anything" (btw, I remember one of the answers after
>> publishing of first i-pipe patch was of that kind). btw, there are
>> some parts of the kernel (e.g. some filesystems, if I'm not wrong)
>> that use another style;
>>
> 
> Allowing people to agree on a common coding style, which is basically
> K&R for the presentation part, and a few recommendations which belong to
> common sense, is usually the best way to avoid further ludicrous
> flamewars and unsmart assaults from smart asses about the cosmological
> importance of brace placement in the dynamic balance of things in the
> universe...
> 
> 
>> 3) ok, I may assume, that if a person is familiar with some codding
>> style, he/she gets a few percent speed-up when reading the code that
>> is of the same style. At least, for the first few minutes :) But here
>> we must assume that the most part of the potential
>> readers/contributors like the linux codding way.
>>
> 
> As you pointed out, this is also about allowing people used to K&R style
> to read this code as they would do with any contributed kernel code
> without any useless stylistic barrier on entry, would they be interested
> in doing so, that is. Reading some comments on the LKML about real-time
> extensions (by opposition to native real-time support a la PREEMPT_RT),
> it seems that there is a fair amount of confusion, misinformation and
> urban legends still going there. Part of the reasons for this is very
> likely that very few actually ever tried to look at the code. There must
> be some reason for that, aside of "they don't care", that is.
> 
>> err.. to sum it up, I like the current codding style, but if 1-3) +
>> smth else are worthy things, then why not. I'll get used to another
>> style, if the code will remain err. well-readable :)
>>
> 
> The basic idea I had for RTAI/fusion has not changed with Xenomai
> "reloaded": we are working hard to have the highest possible level of
> integration with the Linux kernel while keeping the advantages the
> co-scheduling approach still has over any purely native implementation.
> In order to achieve this, it would make sense to share as many
> (reasonable) conventions as possible with the kernel people.
> 

I don't see an urgent need to go and change the whole code to kernel
coding style, I only see the need to keep one consistent style across
the code. This just may require a bit more iterations for "third-party"
contributed patches.

Ok, the ipipe patch as the part being integrated in the kernel, that one
should conform to kernel style to make it easier readable for inflexible
kernel hackers. But for the rest (which will very likely never made it
into the kernel), we should decide based on a broader basis than just
"follow the kernel herd".

Personally, I don't like hard-tabs (think they are too often misused to
format text alignment instead of just indenting code blocks), but I can
live with any style - as long as it is consistent and comprehensible.
Now as we already have such a style, why to change it right now? I would
say: just enforce it.

Jan

--------------enigD31A60E830E97C39910B8BF5
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (MingW32)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFDWm2jniDOoMHTA+kRAkC2AJ9+qZlk8eMi5XeadBOb5ZQlYWwlggCfbZuG
ffuKIHcRf26U0Csc+vYstSA=
=jOab
-----END PGP SIGNATURE-----

--------------enigD31A60E830E97C39910B8BF5--

