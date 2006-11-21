From: Paul <paul_c@domain.hid>
Subject: Re: [Xenomai-core] Buildbot: Errors building rtnet since at least
	r1834
Date: Tue, 21 Nov 2006 10:36:47 +0000
References: <200611181818.17629.niklaus.giger@domain.hid>
	<200611202002.13102.paul_c@domain.hid>
	<200611210825.20046.niklaus.giger@domain.hid>
In-Reply-To: <200611210825.20046.niklaus.giger@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
Message-Id: <200611211036.47083.paul_c@domain.hid>
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: niklaus.giger@domain.hid
Cc: xenomai@xenomai.org


Hi Niklaus

On Tuesday 21 November 2006 07:25, Niklaus Giger wrote:
> I however use the DESTDIR quite often to install the output of my differe=
nt
> build (cross-compiling) slaves into different directories to be able to
> switch between them easily. Also I use the DESTDIR to specify the nfs root
> directory which the test boards will use to boot from. I know of nothing
> more appropriate for this purpose or did I miss something?

Using DESTDIR to install to an NFS root partition is just the sort of thing=
 it=20
was intended for.

> To be able to test more easily regressions between different version I
> wanted now to make my install directories to include the revision.

I suspect you would be better off appending the revision number to the pref=
ix=20
variable - This would allow you to install and run without hitting any=20
missing path problems.

> A part of my confusion stemmed from the fact that something which is very
> easy in a script proved to be quite complicated in my buildbot. My idea w=
as
> that after the first build step (the svn checkout) I wanted to evaluats
> `svnversion` to help me point DESTDIR to something
> like "/home/hcu/rootfs/revision-1986". Unfortunately I did not yet found
> out how =A0buildbot step can propagate this property easily to all of it
> successors. I have to dig further there.

If you wanted to post the scripts (or email them over), perhaps I could tak=
e a=20
look and maybe suggest a solution.


Regards, Paul.


