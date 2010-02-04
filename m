From: Sinisa Denic <sinisa.denic@domain.hid>
Date: Thu, 4 Feb 2010 14:04:32 +0100
References: <fd55ced7db48fe30f8139df895fb9d4c.squirrel@domain.hid>
	<201002011532.31310.sinisa.denic@domain.hid>
	<4B69C0A8.6040402@domain.hid>
In-Reply-To: <4B69C0A8.6040402@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
Message-Id: <201002041404.32949.sinisa.denic@domain.hid>
Subject: Re: [Xenomai-help] xenomai 2.5.0 uclibc 0.30 compatibility?
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: xenomai@xenomai.org.

On Wednesday 03 February 2010 19:30:00 you wrote:
> Sinisa Denic wrote:
> > On Monday 01 February 2010 14:07:15 Gilles Chanteperdrix wrote:
> >> Sinisa Denic wrote:
> >>> On Sunday 31 January 2010 11:31:28 Gilles Chanteperdrix wrote:
> >>>> This is bad news, the problem is that uclibc's stdio.h needs
> >>>> pthread.h, which because of the -I flags we pass is xenomai's
> >>>> pthread.h, which includes asm/syscall.h, which needs stdio.h.
> >>>
> >>> Same thing,
> >>> I can't figure out which file to include in pthread.h
> >>> posix/init.c - same error
> >>> include/asm-arm/xenomai/syscall.h - produce error from start building
> >>> rtdm ...
> >>
> >> In every .c file where you get the error, you should try and include
> >> pthread.h before anything else.
> >
> > Ok, now I've got it built. In attach there is a patch, maybe usefull to
> > someone.
>
> Xenomai v2.5.1 should include a cleaner fix (along with the I-pipe for
> Linux 2.6.30 fixed for the arm926ejs issue, as well as some improvements
> on at91). So, it would be nice if you could test this release and report.
Ok , previos problems didn't appear, but now I'm getting this:

latency.c:12:22: error: execinfo.h: No such file or directory
latency.c: In function =E2=80=98mode_sw=E2=80=99:
latency.c:460: warning: implicit declaration of function =E2=80=98backtrace=
=E2=80=99
latency.c:461: warning: implicit declaration of=20
function =E2=80=98backtrace_symbols_fd=E2=80=99
make[3]: *** [latency-latency.o] Error 1
make[3]: Leaving directory=20
`/opt/pct210_build/xenomai-2.5.1-eabi/src/testsuite/latency'
make[2]: *** [all-recursive] Error 1
make[2]: Leaving directory=20
`/opt/pct210_build/xenomai-2.5.1-eabi/src/testsuite'
make[1]: *** [all-recursive] Error 1
make[1]: Leaving directory `/opt/pct210_build/xenomai-2.5.1-eabi/src'
make: *** [all-recursive] Error 1

In order to compile xeno2.5.1 I skipped testsuite building and it passed

Sinisa.

