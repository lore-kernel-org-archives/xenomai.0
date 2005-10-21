Message-ID: <4358FDEF.5020800@domain.hid>
Date: Fri, 21 Oct 2005 16:40:47 +0200
From: =?ISO-8859-15?Q?Ignacio_Garc=EDa_P=E9rez?= <iggarpe@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-help] timeout in native API calls          (cond, sem,
	mutex, etc).
References: <4357C3E1.1040701@domain.hid>
	<4357C9F7.2060808@domain.hid>	<4357CF67.8080601@domain.hid>
	<4357DF0F.3060806@domain.hid> <435896AA.1060103@domain.hid>
	<4358C885.8010808@domain.hid> <4358DC25.9010307@domain.hid>
In-Reply-To: <4358DC25.9010307@domain.hid>
Content-Type: text/plain; charset="iso-8859-15"
Content-Transfer-Encoding: quoted-printable
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Jan Kiszka <kiszka@domain.hid>
Cc: xenomai@xenomai.org

Jan Kiszka wrote:

>Ignacio Garc=EDa P=E9rez wrote:
> =20
>
>>In my previous (long) message I forgot something. I think that without
>>support for abolute timeouts in the nucleus, the RTAI skin cannot be
>>accurately implemented (*_until and *_timed calls).
>>
>>   =20
>>
>
>Then something must be wrong, e.g. here: ;)
>
>http://www.rts.uni-hannover.de/xenomai/lxr/source/skins/rtdm/drvlib.c?v=3D=
SVN#L280
>(other skins do it similar but have to deal with more complexity)
>
>I does work as you can see, it just takes some locking. :)
> =20
>
Um. I meant it cannot be properly done in a user application.

One of the best things of xenomai is the neat layered design. In theory
(again, correct this newbie if he's wrong),* the application developer
should use only the API provided by the skin he chooses. The nucleus
services should be used only by skin developers.*

So, it's perfectly ok that the RTDM developer uses the locking mechanism
provided by the nucleus.

But I think that I, as an application developer using the native skin,
should not need to resort to the nucleus to implement a certain basic RT
functionality (and yes, I agree it is a quite rare design pattern, but
it's there).

As I discuss in another message, I think the best (and easy!) solution
from the design standpoint would be to modify all nucleus calls that
take a timeout argument and add a boolean argument to specify whether
the timeout is realtive or absolute. Would be almost trivial to
implement, however:

- Would break the nucleus API, THOUGH the required updates in the skins
would be TRIVIAL (just add a zero/one after the timeout). Later, some
calls like the RTDM one you mention could be further optimized by using
the absolute timeout nucleus call instead of the locking.

- Would require modifications of the documentation. Since it's generated
with doxygen, and the code changes are trivial, this would be probably
the largest job.

The nucleus API would suffer a minimal change (no new calls, just a new
parameter in ones) and would provide quite a large amount of
flexibility. Extending the native skip API would be the next step, and
if the project leader decides not to do it, that would be OK because I
could do it only for myself via a tiny patch.

>Well, it's not that accurate as it could be at best, that's true, but
>the short time you "loose" between the conversions in the skin and the
>nucleus is not significant compared to the overall jitter you always
>face on an OS.
>
>Jan
>
> =20
>


