Content-Type: text/plain; charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
From: Steve Pavao <stevep@korgrd.com>
In-Reply-To: <44r2sfzw87.fsf@lowell-desk.lan>
Date: Thu, 30 Nov 2017 16:02:30 -0500
Content-Transfer-Encoding: quoted-printable
Message-Id: <B3C2A01B-0349-4D10-A5A8-EE69B25F37B2@korgrd.com>
References: <E6D54D1B-1536-4F5F-9E7B-C8F856F5E3EC@korgrd.com>
 <44r2sfzw87.fsf@lowell-desk.lan>
Subject: Re: [Xenomai] matching patch version to kernel version
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

Hi, Lowell !

> On Nov 30, 2017, at 9:18 AM, Lowell Gilbert <kludge@be-well.ilk.org> =
wrote:
>=20
> Hi, Steve.
>=20
> Steve Pavao <stevep@korgrd.com> writes:
>=20
>> I am building Yocto poky linux for an Intel board at head in Master
>> branch in Yocto poky, which currently results in a kernel version
>> 4.9.61.
>=20
> I stick to release branches for Poky for my own releases.
> Probably not a big deal, as my experience using HEAD on research
> projects hasn't been notably painful.

I have been using poky pyro branch for all my previous releases, but the =
BSP layer for this particular board caused some unusual output warnings =
in an all-pyro build, so I opted for Poky Master branch at HEAD for this =
build, and did not experience the warnings.  (I=E2=80=99m still trying =
trying to understand those warnings, so I can go back to using pyro =
branch.)

I just noticed that a build done in pyro today resulted in a kernel =
version of 4.9.50.  This is much closer to 4.9.51, so maybe applying =
that patch to the pyro branch would be less problematic.

>> I see that the latest patch file in the xenomai download area is =
ipipe-core-4.9.51-x86-4.patch.
>>=20
>> Will this patch work OK with the 4.9.61 kernel version, or should I =
use a different approach to ensure a better match?
>=20
> You will need to edit the patch (I know from experience that
> there are definitely conflicting changes in between those
> points), but that's still -- probably -- your best bet. Since
> you don't care about ARM-specific files, I don't think you'll
> have too hard a time.

I may need to do the patch for ARM-based targets as well, at some point.

- Steve


