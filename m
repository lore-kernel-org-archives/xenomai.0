MIME-Version: 1.0
In-Reply-To: <55DF43C6.2080209@xenomai.org>
References: <CAJqUr7ybpmgOev-iPaQ-iMEAF8SBocn54vyYSbLcm9spMY=FBg@mail.gmail.com>
 <55DF43C6.2080209@xenomai.org>
Date: Thu, 27 Aug 2015 14:56:43 -0700
Message-ID: <CAJqUr7zcjxbd7XrkK=ky9TJ_e2Ho5BEQNDA4EnJxB6f1WDu-og@mail.gmail.com>
From: Don Mahurin <don@mperpetuo.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Xenomai] xenomai/ipipe arm64 port
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Jorge Ramirez Ortiz <jro@xenomai.org>
Cc: xenomai@xenomai.org

On Thu, Aug 27, 2015 at 10:07 AM, Jorge Ramirez Ortiz <jro@xenomai.org>
wrote:

> On 08/24/2015 08:13 PM, Don Mahurin wrote:
> > Hi all,
> >
> > We would like to submit our current work on the arm64 port of
> > ipipe/xenomai. We hope that this contribution will encourage further
> > development of arm64 support in ipipe/xenomai.
> >
> > This port was largely developed on ipipe-3.10 as a base, so it is likely
> to
> > be the most well tested there. Though recently, we have also ported these
> > changes to ipipe-3.14.44. ( We noticed that 3.10 is missing from rc7. Is
> > this intended, or will 3.10 support return? )
> >
> > At the end of this message are the relevant git repos and branches for
> the
> > arm64 port. Also included is a build script to build a minimal busybox
> > linux system which may be ran using qemu (arm64 virt).
> >
> >
> > Development status:
> >
> > The 3.14 port is missing the fast-syscall changes (in entry.S) from
> armv7,
> > and instead contains the 3.10 entry.S changes forward ported to 3.14.
>
>
> is the IPIPE tracing supported?
>
>
IPIPE tracing is not complete in that set of changes.

We have additional changes that enable ipipe tracing, which we will submit
once the initial changes are in a branch.

-Don
