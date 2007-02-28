From: Paul <paul_c@domain.hid>
Subject: Re: [Xenomai-core] prepare-kernel options
Date: Wed, 28 Feb 2007 13:51:46 +0000
References: <200702281217.36362.paul_c@domain.hid> <45E57D55.10402@domain.hid>
In-Reply-To: <45E57D55.10402@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200702281351.46807.paul_c@domain.hid>
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Jan Kiszka <jan.kiszka@domain.hid>
Cc: xenomai-core <xenomai@xenomai.org>

On Wednesday 28 February 2007 13:02, Jan Kiszka wrote:
<snip>
> [Related question from my side:]
>
> Would you be willing to provide debian package generation rules for
> Xenomai? Something that would spit out .deb files when calling, say,
> "make deb KERNEL=linux-2.6.x.tar.bz2 CONFIG=my-kernel-config" in a
> configured userland build directory? That way we could automatise binary
> package generation for kernel, user libs, development headers, and
> documentation. And that would allow us to finally distribute them for
> generic targets like x86 and x86_64 along with the usual tar files.

To have a Debian rule set is indeed my ultimate goal (but I wouldn't want t 
tread on anyone's toes if it is already in hand). - I suspect a number of 
potential users would like to try Xenomai but are put off by kernel 
compilation... But rather than a `make deb` rule, a small script would be 
better - Debian's packaging system generates (amongst other things) a source 
tarball, and to include auto-generated files doesn't feel right.. Calling the 
`make dist` rule may solve that issue.

> I think such a feature (maybe later enhanceable by RPM) would both be
> interesting for replicable custom installations as well as for a
> reference kernel distribution to provide a Xenomai quick-start.

Indeed - Point a potential user to a repository, let them experiment with a 
(hopefully) working kernel, and when they need/want specific vmlinuz options, 
they have a reference point to work from. The "Debian way" also greatly 
simplifies the task of building packages.

<snip>
> Would this build procedure already help you?
> http://www.rts.uni-hannover.de/xenomai/lxr/source/README.INSTALL?a=i386#203

Ah, yes.. It's the same doc in the top level Xenomai tree ;)

As Gilles has pointed out, there are already a couple of options in 
prepare-kernel.sh to aid package generation - If nobody else is working on 
that area, I'll put a patch together over the next few days and submit it for 
review.


Regards, Paul.

