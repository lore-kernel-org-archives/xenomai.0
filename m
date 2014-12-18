Date: Thu, 18 Dec 2014 15:12:48 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Message-ID: <20141218141248.GN2012@hermes.click-hack.org>
References: <CAMJ=MEdh-vBm1S9cHL7Hj0Ky-RaeGCSw_xauMZoEsuegbArM1w@mail.gmail.com>
 <CAMJ=MEfDQm_ymyL8FULhqMvpwzet4aHMbQFoEjL-sVDsCTg2Hg@mail.gmail.com>
 <549072DC.1030901@xenomai.org>
 <CAMJ=MEfzrJQGYKT41F2hSirn8q0MGt-kWuT2GYQE7YTbSCNG5A@mail.gmail.com>
 <549090FA.7000901@xenomai.org>
 <CAMJ=MEc9UXa4P18kNmPeKH-SziXMj9Grbxagj7Wm_MckHcOC7Q@mail.gmail.com>
 <5492989C.9070106@siemens.com>
 <CAMJ=MEeWPyBFBbjj7_JLENZQ+xBkxbaKGiZBehKCatVa-1owqA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMJ=MEeWPyBFBbjj7_JLENZQ+xBkxbaKGiZBehKCatVa-1owqA@mail.gmail.com>
Subject: Re: [Xenomai] [xenomai-forge] timer-internal consume a lot of cpu
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Ronny Meeus <ronny.meeus@gmail.com>
Cc: Jan Kiszka <jan.kiszka@siemens.com>, xenomai@xenomai.org

On Thu, Dec 18, 2014 at 01:28:42PM +0100, Ronny Meeus wrote:
> On Thu, Dec 18, 2014 at 10:04 AM, Jan Kiszka <jan.kiszka@siemens.com> wrote:
> > On 2014-12-18 09:00, Ronny Meeus wrote:
> >>>
> >>> A release of the glibc that fixes this issue. I must admit that I did
> >>> not track this problem lately. Jan likely knows better here.
> >>>
> >>
> >> Jan,
> >>
> >> what version glibc solves the priority inversion issue on conditional variables?
> >> I already tried the glibc 2.18 but the issue is still there.
> >
> > The bug is still not fixed, and discussion stalled again, see
> > https://sourceware.org/bugzilla/show_bug.cgi?id=11588
> >
> > Jan
> >
> > --
> > Siemens AG, Corporate Technology, CT RTC ITP SES-DE
> > Corporate Competence Center Embedded Linux
> 
> Philippe, Jan
> 
> as long as this issue is not fixed in glibc, it is not OK to use
> conditional variables

I believe xenomai cobalt does not suffer from the same issue,
condition variables should work fine with priority inheritance.

Otherwise, have you tried some alternate libc, such as musl:
http://www.musl-libc.org/

The following blog:
http://ewontfix.com/

Seems to show that the musl maintainers try and report glibc bugs
and avoid them in their implementation.

I have not tried xenomai with musl at all, so, maybe it does not
even compile. But maybe just compiling a testcase for the condvar
issue with that libc would help know if it has the same issue or
not.

-- 
					    Gilles.

