MIME-Version: 1.0
Sender: had2006@gmail.com
In-Reply-To: <8dc6116b7b5868d884c9f8c3e3de3c84.squirrel@xenomai.org>
References: <CAKk99t3_phHv3kUfCZcwr2bqTys3JPL3iaWACLjP+f1yoD_Nag@mail.gmail.com>
 <54F97594.2060605@xenomai.org>
 <CAKk99t1AGHj8sOf7Vgy_UZ_+rECP5Vx22cyup--FHsh=RuK2zA@mail.gmail.com>
 <54F97E05.8010107@xenomai.org>
 <CAKk99t3FfAff0X0nGzKD+YcVFQWm5aeSRFB4U6No1YSPuS_qpA@mail.gmail.com>
 <CAKk99t03p_Pc41meo_zzZ0V6X_vjHZRWBeO1aNb+DM2c38pNTg@mail.gmail.com>
 <54FF64AF.5000300@xenomai.org>
 <CAKk99t2159Do6Rj0GSRPkPFcbN-qT9JpWBD1ojmFOHYv7ZKkGg@mail.gmail.com>
 <5500A3DD.2070306@xenomai.org>
 <8dc6116b7b5868d884c9f8c3e3de3c84.squirrel@xenomai.org>
Date: Fri, 13 Mar 2015 13:50:07 +0000
Message-ID: <CAKk99t0iDYiscgc0w8XthshRbB=BuQvX0t6a31_2Uw+LOayNsQ@mail.gmail.com>
From: Helder Daniel <hdaniel@ualg.pt>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Xenomai] Fwd: Error boilerplate/wrappers.h no found trying to
 compile RTDM module on 3.x-rc3 cobalt
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: "Xenomai@xenomai.org" <xenomai@xenomai.org>

I upgraded from kernel-package v 12.036+nmu3 of wheezy to the newer
version 13.014+nmu1
included in jessie (and also in sid).

I get the same errors when compiling a kernel module.

Then I created a kernel_source debian package.
Install it at /usr/src and make /lib/modules/3.16.0-ipipe/build points to
it rather than to the full source tree.

I didn't work either.
It give me an error saying that it can not find configuration of kernel.

The only way I can move the required headers to compile RTDM modules to
another computer without copying all the 6.2 GBytes of the full kernel
source tree after compiled was cleaning the compilation with. make clean
and then pack the much smaller, around 660 MBytes, clean source tree

This way installing a kernel_image package (with ipipe patch) unpacking the
previously packed source tree, making /lib/modules/3.16.0-ipipe/build
points to it and installing Xenomai 3.x-rc3 it is possible to compile
kernel modules for the RTDM API without needing to compile the kernel in
every computer you want to install Xenomai.

PS:
Just for a sanity check I installed Xenomai 2.6.4
and created kernel-headers-3.14.17 patched with ipipe-core

them make /lib/modules/3.14.17-ipipe/build points to the kernel-headers and
not the full kernel source.

This allows to compiled a kernel module successfully for linux 3.14.17
without needing of the full kernel tree (xeno 2.6.4 of course).



On 11 March 2015 at 21:01, Gilles Chanteperdrix <
gilles.chanteperdrix@xenomai.org> wrote:

>
> Philippe Gerum wrote:
> > On 03/11/2015 06:30 PM, Helder Daniel wrote:
> >>     You need /lib/modules/$(shell uname -r)/build to refer to a kernel
> >> tree
> >>     prepared with the Xenomai kernel sources, i.e.
> >> scripts/prepare-kernel.sh
> >>     should have run in this source tree at some point. The errors you
> >> get
> >>     indicate that no Xenomai code can be found there.
> >>
> >>
> >> I had
> >>
> >> /lib/modules/$(shell uname -r)/build
> >>
> >> pointing to the kernel headers installed from a .deb package.
> >> This package was created when compiling the Cobalt kernel with:
> >>
> >> make-kpkg --initrd kernel_image kernel_headers
> >>
> >> so I assumed that all Xenomai code is included in that package.
> >>
> >> Now I pointed to the kernel source tree and I can compile the module.
> >>
> >> This is strange. I was expecting that the kernel headers package created
> >> with debian build to store all Xenomai info, so that I can install a
> >> cobalt kernel image + headers in another computer, from 2 debian
> >> packages (I did this before successfully with Xenomai 2.5.x) without
> >> having to copy all the kernel source tree.
> >>
> >
> > Following the current kernel standards, Xenomai 3 introduces a strict
> > split between kernel headers and user-space ones, with a uapi/ section
> > for the shared portion which exposes the ABI. Maybe debian/rules does
> > not reflect that change.
> >
>
> make-kpkg does not use the debian rules. It uses its own rules, and yes,
> you may have issues if you use an old version of make-pkkg (like for
> instance the one in debian stable) with a newer kernel. The solution is to
> install make-kpkg from debian unstable. Or maybe use a backport if it
> exists. Now, I do not know if make-kpkg will resolve the symbolic links
> in the kernel sources, or if it keeps them. If it keeps them, you need
> to keep the xenomai headers at the place they were when running
> prepare-kernel.sh.
>
> --
>                     Gilles.
>
>


-- 
Helder Daniel
UALG - FCT
DEEI

http://w3.ualg.pt/~hdaniel
