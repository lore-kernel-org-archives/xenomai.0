Message-ID: <1434966877.74785.YahooMailBasic@web173202.mail.ir2.yahoo.com>
Date: Mon, 22 Jun 2015 10:54:37 +0100
From: Frederik Bayart <frederik_bayart@yahoo.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Xenomai] include guard trank/posix/pthread.h
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org




On Friday, 19 June 2015, 15:07, Philippe Gerum <rpm@xenomai.org> wrote:
>On 06/19/2015 03:02 PM, Frederik Bayart wrote:
>
>
>
>
>> Hallo,
>> I noticed that both /usr/xenomai/include/trank/trank.h and=A0 /usr/xenom=
ai/include/trank/posix/pthread.h share the same include guard (_XENOMAI_TRA=
NK_TRANK_H).Can this be an error ? I use compile flags 'xeno-config --skin=
=3Dnative --cflags' and get compile errors. If I change the include guard o=
f pthread.h to _XENOMAI_TRANK_POSIX_PTHREAD_H, the problem seems to be solv=
ed.In attachment a diff with my changes.
>> Frederik
>>=20
>
>Yes, the guard is definitely wrong, will fix. Thanks for pointing this out=
.
>
>--=20
>Philippe.

In the same context : to make it compile, I had to add
/usr/xenomai/include/trank/posix to
 $(shell xeno-config --skin=3Dnative --cflags).
At the moment -I/usr/xenomai/include/trank -D__XENO_COMPAT__
 -I/usr/xenomai/include/cobalt -I/usr/xenomai/include -D_GNU_SOURCE
 -D_REENTRANT -D__COBALT__ -I/usr/xenomai/include/alchemy
is returned.

If this is the correct solution, I can prepare a patch for
 xeno-config if desired.

Frederik

