From: Giulio Moro <g.moro@qmul.ac.uk>
Subject: Re: include/boilerplate/compiler.h breaks clang 3.9's arm_acle.h
Date: Tue, 20 Nov 2018 18:05:58 +0000
Message-ID: <VI1PR0701MB21268BCFFFA044A65791E3ACB5D90@VI1PR0701MB2126.eurprd07.prod.outlook.com>
References: <VI1PR0701MB21264AF72FDA99A8694C2E6AB5DE0@VI1PR0701MB2126.eurprd07.prod.outlook.com>
 <d0e4aced-93eb-1e3c-ed39-7b406df3ee53@siemens.com>
 <VI1PR0701MB2126E2FCB190BCE61C77329CB5D80@VI1PR0701MB2126.eurprd07.prod.outlook.com>,
 <4e92ca74-5fb1-ecc0-a679-103410b1727d@xenomai.org>
In-Reply-To: <4e92ca74-5fb1-ecc0-a679-103410b1727d@xenomai.org>
Content-Language: en-GB
Content-Type: text/plain; charset="iso-8859-1"
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
To: Philippe Gerum <rpm@xenomai.org>, Jan Kiszka <jan.kiszka@siemens.com>, "xenomai@xenomai.org" <xenomai@xenomai.org>

> Why not solving the namespace clash the simplest way by renaming the
> offending stuff in boilerplate/compiler.h? __clz and friends are
> definitely not part of the public interface, so you only have to care
> about in-tree users. __clz could be renamed as count_leading_zeroes()
> without affecting the API.

If you want to go down this path, I'd go for xenomai_count_leading_zeros(),=
 to give some sort of protection against further namespace conflicts.
However, I don't see why this header, and its defines, should be included w=
ith `stdlib.h` (or any other system include, fwiw) at all. Granted, I don't=
 know much about the ins and outs of libcobalt, but, at first sight, there =
doesn't seem to be anything in copperplate/compiler.h that should be made a=
vailable to the user.

Best,
Giulio=

