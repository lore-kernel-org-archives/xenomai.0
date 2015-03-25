Message-Id: <5512E8440200005500018F50@iwesmail-ks.iwes.fraunhofer.de>
Date: Wed, 25 Mar 2015 16:54:28 +0100
From: <jonas.platte@iwes.fraunhofer.de>
References: <CAOgYGPq2882YFEd+r97TTO41u-KD1GTfVzUtoH3jjVz9NUM42Q@mail.gmail.com>
 <55117766.4090003@web.de> <5512D662.2030504@gmail.com>
In-Reply-To: <5512D662.2030504@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
Subject: [Xenomai] Antw: Re:  xenomia on virtual box
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

Debian already provieds pre-built linux-rt images (while Ubuntu
surprisingly doesn't). See e.g. for wheezy:
https://packages.debian.org/wheezy/linux-image-rt-amd64

There are other distributions which make it easy to get an image
with the PREEMPT_RT patch too, without providing a prebuilt
package. I want to mention arch linux, as it has the most up-to-date
kernels. For arch, you can find the rt kernel package in the AUR:
https://aur.archlinux.org/packages/linux-rt/

You'd have to build it yourself, but that's rather easy with arch's
makepkg / PKGBUILD system (just search for a makepkg tutorial).
That said, arch linux is probably not the best system for production
environments. But if you want to try things out with an up-to-date
kernel, I'd say arch is the way to go.

>>> Roland <rolandtollenaar@gmail.com> 25.03.2015 16:38 >>>
Thanks Jan.
   Will try KVM on top of PREEMPT-RT.
   Is there a distribution particulalry suited to patch with PREEMPT-RT?
   Kind regards,
   Roland.
   Jan Kiszka wrote:

On 2015-03-24 12:54, r t wrote:


Hi,

perhaps a silly question but we are trying to get our pre- xenomai patched
kernel to run on VirtualBox. Playing about a bit. Well we already have it
running that is not the problem.

The question is whether there is any chance that we will get good (or any)
latency/ realtime performance if the kernel was compiled on another =
machine
other than the host environment currently hosting the VirtualBox?

Instructions to achieve what we are playing with explicitly state that the
kernel must be compiled on the host then installed on the guest which =
leads
to believe (as I would intuitively expect) that it is not possible to
abstract a xenomai environement from the hardware. However to my surprize
the xenomai patched kernel does noet seeem to have to run on the host.  =
How
does xenomai on the guest machine achieve good realtime performance if the
host is still free to act as it wishes in terms of accessing hardware?


Can anyone perhaps shed some light on this?


Virtualization, specifically if VirtualBox-based, destroys real-time for
a Xenomai guest system. You can use such setups very well for functional
tests provided they do not fail due to longer delays or high jitters.

VirtualBox has a fairly poor interface for Linux guests /wrt virtual
clocks and their calibration. Therefore, we frequently run into issues
when setting up Xenomai tests on Windows hosts.

The best real-time environment you can get right now out of a common
hypervisor is stacking KVM on top of PREEMPT-RT. But that alone will not
suffice, you will also have to tune the guest to avoid priority
inversions in the hypervisor's machine emulation.

Jan



_______________________________________________
Xenomai mailing list
Xenomai@xenomai.org=20
http://www.xenomai.org/mailman/listinfo/xenomai


