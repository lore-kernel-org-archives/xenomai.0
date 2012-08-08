MIME-Version: 1.0
Date: Wed, 8 Aug 2012 16:43:53 +0200
Message-ID: <CAHue_TVRdTsre3E7NxHtb=6XfxkL7_36nsLLxSkiF3kUJAJ5Vw@mail.gmail.com>
From: =?ISO-8859-2?Q?Marcin_Ku=B6ka?= <marckuska@gmail.com>
Content-Type: text/plain; charset=ISO-8859-2
Content-Transfer-Encoding: quoted-printable
Subject: [Xenomai]  Cortex-a9 - please fix xenomai-fix-lfs-issue.patch
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

Hi

I'm compiling ipipe-linux (v 3.2.21) with xenomai 2.6.1 for versatile
express cortex-a9 using buildroot and the following message appears:

>>> xenomai 2.6.1 Extracting
bzcat /home/marcin/buildroot-2012.08-rc1/dl/xenomai-2.6.1.tar.bz2 | tar
--strip-components=3D1 -C
/home/marcin/buildroot-2012.08-rc1/output/build/xenomai-2.6.1  -xf -
>>> xenomai 2.6.1 Patching package//xenomai

Applying xenomai-do-not-install-devices.patch using patch:
patching file Makefile.in
Hunk #1 succeeded at 796 (offset 77 lines).

Applying xenomai-fix-lfs-issue.patch using patch:
patching file include/posix/sys/mman.h
Hunk #1 FAILED at 63.
Hunk #2 succeeded at 84 with fuzz 1 (offset 2 lines).
1 out of 2 hunks FAILED -- saving rejects to file
include/posix/sys/mman.h.rej
patching file include/posix/unistd.h
Hunk #1 FAILED at 54.
1 out of 1 hunk FAILED -- saving rejects to file include/posix/unistd.h.rej
Patch failed!  Please fix xenomai-fix-lfs-issue.patch!
make: ***
[/home/marcin/buildroot-2012.08-rc1/output/build/xenomai-2.6.1/.stamp_patch=
ed]
Error 1

What is that problem with lfs?

many thanks in advantage.

--=20
Marcin Ku=B6ka
