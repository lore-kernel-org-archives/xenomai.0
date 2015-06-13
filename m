Mime-Version: 1.0 (Mac OS X Mail 8.2 \(2098\))
Content-Type: text/plain; charset=us-ascii
From: Michael Haberler <haberlerm@gmail.com>
In-Reply-To: <4019d695cc8c27a13bd17adc951e3ade.squirrel@sourcetrek.com>
Date: Sat, 13 Jun 2015 06:48:19 +0200
Content-Transfer-Encoding: quoted-printable
Message-Id: <05AD097B-C2A0-4279-A170-79385AC005B1@gmail.com>
References: <F89CBA55-43A8-4AE5-A859-BFE111D40561@gmail.com>
 <4019d695cc8c27a13bd17adc951e3ade.squirrel@sourcetrek.com>
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

Gilles -

> Am 13.06.2015 um 01:02 schrieb Gilles Chanteperdrix =
<gilles.chanteperdrix@xenomai.org>:
>=20
>=20
> Michael Haberler wrote:
>> Q - can I assume "RTDM-native" will be part of RT-PREEMPT if/when =
that
>> goes mainline?
>>=20
>> or must I assume this will remain a Xenomai-specific way of doing =
things
>> which will not be available via a torvalds kernel?
>=20
> Yes, you can assume that. I do not see any way merging RTDM-native =
would
> make sense for mainline. I mean, from their point of view, it would be
> just redundant. For instance, from what I could gather, drivers based =
on
> "OS abstraction layers" have been refused, and the people who wanted =
to
> get them merged, asked to rewrite them using Linux driver API without =
the
> abstraction layer.

thanks for the clarification

>=20
>>=20
>>=20
>> - Michael
>>=20
>> background - since we have a portable RT application, investing into =
RTDM
>> drivers makes a lot more sense if both RT kernel flavors can make use =
of
>> them (in fact three if a vanilla kernel is used - which is good =
enough for
>> certain applications)
>=20
> Well, if RTDM-native is made an out-of-tree Linux kernel module, you =
will
> be able to compile it without applying patches, I think that would be =
good
> enough for the usages you envision.

that is in fact good enough, and I had not thought this being possible - =
since RT-PREEMPT-hardened threads are just fine for most scenarios we =
face, RT-hardened drivers are much more of a portability concern than =
threads.

While I do not feel qualified to aid development significantly, I would =
be very interested in exploring this route and provide feedback if it =
became an option.

For instance, with the external clocking driver I recently mentioned, =
together with hardware-triggered position sampling, latency requirements =
change significantly: Jitter of the thread release point is not a source =
of control loop noise anymore - the requirement changes from "thread =
must start at exactly this point in time and complete within window" to =
"thread must run and complete within a certain time window", which is a =
significant relaxation while at the same time improving results.

To cons up an example - if it were possible to reliably schedule say a =
Posix thread within say 200uS on a vanilla kernel that would suggest we =
could get away with stock kernels and still get better results than we =
have now.=20

I hope I do not overlook some boundary condition - but assuming that =
building out-of-tree RTDM support is significantly less invasive and =
version-dependent than patching a kernel, that scheme could enormously =
widen the range of platforms we could deploy with good results, and at =
the same time lower maintenance requirements.

I guess you see the big lever this could have for us and hence our =
motivation - so I am all ears if there is anything going on in that =
direction!

Summary: "Jump!" "How high?" ;)

- Michael

>=20
>=20
> --=20
>                    Gilles.


