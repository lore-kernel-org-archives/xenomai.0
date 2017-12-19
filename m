Content-Type: text/plain; charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
From: Steve Pavao <stevep@korgrd.com>
In-Reply-To: <44y3lywp2s.fsf@lowell-desk.lan>
Date: Tue, 19 Dec 2017 13:49:28 -0500
Content-Transfer-Encoding: quoted-printable
Message-Id: <0DC99152-08CA-4152-BE75-CA0CE39D654F@korgrd.com>
References: <0CF46CB0-D92C-4DCE-B93F-4291374D8328@korgrd.com>
 <44y3lywp2s.fsf@lowell-desk.lan>
Subject: Re: [Xenomai] Cobalt core and Yocto
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Lowell Gilbert <kludge@be-well.ilk.org>
Cc: xenomai@xenomai.org

Hi Lowell,

Thanks for that tip.  That=E2=80=99s what I was thinking I might need to =
do.

I guess the solution in Yocto terms is to rework my I-PIPE patch recipe =
to not directly apply the I-PIPE patch, but rather to call =
prepare-kernel.sh and allow it to apply the patch, plus do the other =
things it needs to do.  I guess that should happen in a do_configure() =
{} block.

- Steve

> On Dec 19, 2017, at 1:27 PM, Lowell Gilbert <kludge@be-well.ilk.org> =
wrote:
>=20
> Steve Pavao <stevep@korgrd.com> writes:
>=20
>> Here are my recipes, which work fine, but Cobalt core does not boot.  =
I must need something else in my recipe(s).
>>=20
>> For I-PIPE Patch, my recipe file is linux-intel_4.9.bbappend:
>>=20
>> FILESEXTRAPATHS_prepend :=3D "${THISDIR}/files:"
>> SRC_URI +=3D "file://ipipe-core-4.9.51-x86-4.patch"
>=20
> This gets you the interrupt pipeline, but not Xenomai itself.
> That's the prepare-kernel.sh script, typically.
>=20
> Be well.


