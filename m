From: "Pham, Phong" <phamp@ddc-web.com>
Subject: RE: [PATCH 0/4] net/tcp: Fix several bugs and allow rttcp to be built
Date: Mon, 5 Nov 2018 17:20:22 +0000
Message-ID: <C2EC5BA46D13CD44B5915A8FEEB4C44EE546DFAD@DDCEXCH.ddc-ny.com>
References: <1539775907-5124-1-git-send-email-sebastian.smolorz@gmx.de>
 <C2EC5BA46D13CD44B5915A8FEEB4C44EE545BC96@DDCEXCH.ddc-ny.com>
 <62f6ce84-8672-c6d4-a1a2-d9bc996c9ef0@siemens.com> <4717946.93qni4ym1a@lenni>
In-Reply-To: <4717946.93qni4ym1a@lenni>
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Sebastian Smolorz <Sebastian.Smolorz@gmx.de>, Jan Kiszka <jan.kiszka@siemens.com>
Cc: "Hillman, Robert" <hillman@ddc-web.com>, "xenomai@xenomai.org" <xenomai@xenomai.org>


Hi Sebastian,

" Phong, can you test this on your machine?"
No the fix does not work.  It overwrites the window field.

Phong.


-----Original Message-----
From: Sebastian Smolorz [mailto:Sebastian.Smolorz@gmx.de]
Sent: Friday, November 02, 2018 7:42 AM
To: Jan Kiszka
Cc: Pham, Phong; Hillman, Robert; xenomai@xenomai.org
Subject: Re: [PATCH 0/4] net/tcp: Fix several bugs and allow rttcp to be bu=
ilt

On 31.10.18 19:18, Jan Kiszka wrote:
> On 31.10.18 17:55, Pham, Phong wrote:
> > Hi Sebastian,
> >
> > The issue has to do with endianness.  We are running PowerPC (big
> > endian).  So in rt_tcp_set_flags(), flags is 32-bit wide and *tf is
> > 16-bit wide.  I modified the line from:
> >
> > *tf =3D flags;
> >
> > to
> >
> > *tf =3D *(__be16 *)&flags;
>
> Something is fishy with rt_tcp_set_flags. Shouldn't we rather ensure
> that only a __be16 flag value is passed to it?

I think the reason why flags are passed as __be32 is that they are defined
with the help of __constant_cpu_to_be32().

After reading some TCP related code in the kernel I think that this
issue is properly fixed by

tcp_flag_word(th) =3D flags;

I will test this for little endian. Phong, can you test this on your
machine?

--
Sebastian



Notice: This e-mail and any files transmitted with it may contain Data Devi=
ce Corporation's and its subsidiaries privileged and proprietary informatio=
n. It is intended solely for the use of the individual or entity to whom it=
 is addressed. If you are not the named recipient of this transmission, any=
 disclosure, copying, distribution or reliance on the contents of this mess=
age is prohibited. If you received this e-mail in error, please destroy it =
and any attached files and notify me immediately.

Click Here<http://www.ddc-web.com/Profile/EmailPrivacy.aspx> to view our pr=
ivacy statement.

