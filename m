From: Philippe Gerum <rpm@xenomai.org>
In-Reply-To: <4BD5C8C4.3040207@domain.hid>
References: <cover.1271600150.git.jan.kiszka@domain.hid>
	<4BD54515.9010101@domain.hid>  <4BD5C8C4.3040207@domain.hid>
Content-Type: text/plain; charset="UTF-8"
Date: Thu, 29 Apr 2010 23:39:18 +0200
Message-ID: <1272577158.24705.16.camel@domain.hid>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-core] [PATCH 00/23] [git pull] procfs overflow fixes
 and seq_file conversions
List-Id: Xenomai life and development <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: Jan Kiszka <jan.kiszka@domain.hid>, xenomai-core <xenomai@xenomai.org>

On Mon, 2010-04-26 at 19:09 +0200, Gilles Chanteperdrix wrote: 
> Jan Kiszka wrote:
> > Jan Kiszka wrote:
> >> The following changes since commit 113ea4d56e8b215cb56ae7673013163ea5a5987d:
> >>   Gilles Chanteperdrix (1):
> >>         switchtest: increase stack sizes
> >>
> >> are available in the git repository at:
> >>
> >>   git://git.xenomai.org/xenomai-jki.git queues/proc
> >>
> >> This series fixes some of the potential (but when they happen fatal)
> >> overflows in our procfs outputs. Specifically, it fixes all issues in
> >> RTDM (one of them hit us in the field) and the recently reported
> >> overflow in /proc/xenomai/heap. Moreover, Wolfgang started the lengthy
> >> conversion of the registry by introducing a new seq_file-based interface
> >> and already moving the native skin over.
> >>
> >> The future belongs to seq_file, so some of the patches are strictly
> >> spoken not yet required. But we better start this effort before the last
> >> legacy interface user was converted and the old interface is suddenly
> >> dropped from the kernel. This may not be that far away. A patch of mine
> >> to improve error reporting of the old interface was rejected with
> >> "->read_proc is going to be removed, so there is no point."
> > 
> > Did you already have a chance to look into this series?
> 
> Not yet, that is a big series. With a high potential for kernel crashes,
> memory leaks and other things like that. I am trying to find a way to
> test it. Maybe we can try and run it with kmemcheck?
> 

Looking at this series, I eventually made my mind about the kind of
support I'd wish in this area. It boils down to:

- getting rid of the PAGE_SIZE limitation on read as this series does,
- reducing the impact on latency of large outputs,
- hiding discrepancies between linux kernel
releases, regarding the proper way to export kernel object states
to userland (like the planned deprecation of read procs).
- providing a common encapsulation to do that, which brings all the
previous properties in a normalized way, and helps removing direct
dependencies of other core code on PROC_FS
- rebasing the registry support on top of this feature, so that skins
are automatically feature-enabled when going through the registry to
export stuff to userland (as they should).

To this end, I came up with the so-called "virtual file" (aka vfile)
support for the nucleus, and have toyed with those ideas here: 
git://git.xenomai.org/xenomai-rpm.git	queue/vfile

This is still early work in progress, not all the codebase was converted
to use the vfiles (registry and native API were), and I tested the
result only in a very limited manner; so this is not for inclusion into
2.5.x given the amount of code that touches anyway. But I will likely
submit this for inclusion at some point into any upcoming 2.6.x, if
vfiles turn out to fit the job.

-- 
Philippe.




