From: Sagi Maimon <SMaimon@advaoptical.com>
Date: Tue, 31 Mar 2015 07:16:53 +0000
Message-ID: <2bbcae7df9a843738649c4564de924a3@MUC-S-EX13B.advaoptical.com>
References: <7615c5d3d380485499b229435e14ee65@MUC-S-EX13B.advaoptical.com>
 <55195485.9070302@xenomai.org>
 <2b2ffe256e0547af996997c833660a44@MUC-S-EX13B.advaoptical.com>
 <551A470C.5060909@xenomai.org>
In-Reply-To: <551A470C.5060909@xenomai.org>
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: Re: [Xenomai] Using xenomai posix routines instead of Linux POSIX
 routines
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Philippe Gerum <rpm@xenomai.org>, "xenomai@xenomai.org" <xenomai@xenomai.org>

Thanks again.

-----Original Message-----
From: Philippe Gerum [mailto:rpm@xenomai.org]=20
Sent: Tuesday, March 31, 2015 10:05
To: Sagi Maimon; xenomai@xenomai.org
Subject: Re: [Xenomai] Using xenomai posix routines instead of Linux POSIX =
routines

On 03/31/2015 08:23 AM, Sagi Maimon wrote:
> Hi,
> thanks for the help.
> I have read the document, and the use of wrapper makes good sense.=20
> According to the document, when calling "pthread_create" (by using the XE=
NO_POSIX_LIBS flags),  it will call  "__wrap_pthread_create" routine.
> But I am using Xenomai 2.6.4 , and there is no implementation of=20
> "__wrap_pthread_create" routine, instead there is implementation of=20
> "pthread_create" under  kernel/xenomai/skins/posix/thread.c
>=20
> Can you please explain it?

Wrappers are implemented in user-space (see src/skins/posix).

--
Philippe.

