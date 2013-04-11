Mime-Version: 1.0 (Apple Message framework v1283)
Content-Type: text/plain; charset=us-ascii
From: Michael Haberler <mail17@mah.priv.at>
In-Reply-To: <516660A2.3020307@xenomai.org>
Date: Thu, 11 Apr 2013 10:35:28 +0200
Content-Transfer-Encoding: quoted-printable
Message-Id: <913FB5D5-4051-40BC-A81D-5832DDD4D69D@mah.priv.at>
References: <FD5EBA50-E222-4012-A755-A20FF5D5971D@mah.priv.at>
	<5165E85B.2040609@xenomai.org>
	<E9BAB42D-B8E9-4E23-8A15-934A72AC7823@mah.priv.at>
	<51660709.3010809@xenomai.org>
	<6C6B8C75-5498-4645-AA10-5651431A1E90@mah.priv.at>
	<516660A2.3020307@xenomai.org>
Subject: Re: [Xenomai] shared memory compatibility - advice sought
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: xenomai@xenomai.org


Am 11.04.2013 um 09:05 schrieb Gilles Chanteperdrix:

> On 04/11/2013 09:00 AM, Michael Haberler wrote:
>=20
>> Gilles,
>>=20
>> I think I see the light although I'm not totally clear on all details =
yet:
>=20
>=20
> There is a very simple solution, see my other mail:
> http://www.xenomai.org/pipermail/xenomai/2013-April/028169.html

Well, 'simple' is just my kind of keyword, that one I'd manage=20

I understand there are no dumb questions but rather inquisitive idiots, =
so let me rattle off my remaining topics in advance:

- I read this to mean: forget about rt_heap* and rtai_(k)malloc =
altogether: if that is the case - any downsides in the crystal ball?
- if it is that simple, why isnt everybody using this scheme over =
rt_heap_* and rtai_(k)malloc and friends which has the sequencing =
restriction?


The overall approach looks a bit like this project: =
http://sourceforge.net/projects/mbuff/ and the author mentions an =
interesting point in the FAQ file:

> WARNING
>=20
> All versions od mbuff have a known bug occuring when a program having =
mapped
> areas forks. Do not do it for now. Attach to shared memory areas after=20=

> the fork in parent and child if neccesary.

I do for now take that as a restriction which can be dealt with if it is =
known to exist even if I dont fully understand where it comes from; some =
old code remark in the RTAI userland code workaround in LinuxCNC hints =
that RTAI rtai_malloc()'d memory suffers, or suffered from a similar =
issue


- Michael


>=20
> --=20
>                                                                Gilles.


