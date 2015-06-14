Mime-Version: 1.0 (Mac OS X Mail 8.2 \(2098\))
Content-Type: text/plain; charset=us-ascii
From: Michael Haberler <haberlerm@gmail.com>
In-Reply-To: <438716acfb1172076225e9266fa98c04.squirrel@sourcetrek.com>
Date: Sun, 14 Jun 2015 13:37:37 +0200
Content-Transfer-Encoding: quoted-printable
Message-Id: <4BBC4FAD-F087-44E2-BE3F-B35A0AD0A8EA@gmail.com>
References: <F89CBA55-43A8-4AE5-A859-BFE111D40561@gmail.com>
 <4019d695cc8c27a13bd17adc951e3ade.squirrel@sourcetrek.com>
 <05AD097B-C2A0-4279-A170-79385AC005B1@gmail.com>
 <9c648f9ec1a5abf4d783d8f3a9ada651.squirrel@sourcetrek.com>
 <7296329D-54C3-446C-A206-956BCBAEE441@gmail.com>
 <438716acfb1172076225e9266fa98c04.squirrel@sourcetrek.com>
Subject: Re: [Xenomai] RTDM-native mainlining - status?
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: xenomai <xenomai@xenomai.org>


> Am 14.06.2015 um 10:46 schrieb Gilles Chanteperdrix =
<gilles.chanteperdrix@xenomai.org>:
>=20
>=20
> Michael Haberler wrote:
>>=20
>>> Am 13.06.2015 um 09:19 schrieb Gilles Chanteperdrix
>>> <gilles.chanteperdrix@xenomai.org>:
>>>=20
>>>=20
>>> Michael Haberler wrote:
>>>> I hope I do not overlook some boundary condition - but assuming =
that
>>>> building out-of-tree RTDM support is significantly less invasive =
and
>>>> version-dependent than patching a kernel, that scheme could =
enormously
>>>> widen the range of platforms we could deploy with good results, and =
at
>>>> the
>>>> same time lower maintenance requirements.
>>>=20
>>> No, alas a Linux driver is always version-dependent, so, the driver
>>> would
>>> contain some wrappers to handle differences between version. But =
this is
>>> not something new, everybody maintaining out-of-tree Linux kernel =
code
>>> has
>>> been doing it for a very long time. We do it for Xenomai, even Linux
>>> developers are doing it for the driver backport project.
>>=20
>> certainly, but if the problem scope changes from "patch a specific =
kernel
>> version for full Xenomai support" to "maintain the API and support =
library
>> for a set of out-of-tree drivers on top of a stock kernel from =
elsewhere"
>> we're in a different (my guess: easier and more widely applicable)
>> ballgame
>=20
> There should not be a need for a support library, since RTDM uses the
> usual driver API open, read, write, ioctl, I would expect an RTDM =
native
> driver to work with the plain Linux version of these calls.
>=20
>>=20
>> I would really be interested in exploring this route with a simple
>> example, like this GPIO RTDM driver, and try to make this work with =
say a
>> vanilla or RT-PREEMPT kernel - if only to gauge feasibility, effort =
and
>> results
>>=20
>> what would you recommend as a starting point?
>=20
> Well, RTDM native is not part of Xenomai (yet), so, the first step =
would
> be to to try and compile it. The last commits in the git date back =
from
> 2007, so, some adaptation will be needed to get it running with the =
latest
> kernels.
>=20
> https://git.xenomai.org/rtdm-native.git/

sounds reasonable, I will give it a try an report.

Any early advice on brushing up this tree would be particularly welcome!

- Michael


>=20
> --=20
>                                            Gilles.
> https://click-hack.org


