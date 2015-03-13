Date: Fri, 13 Mar 2015 15:04:03 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Message-ID: <20150313140403.GD1497@hermes.click-hack.org>
References: <54F97594.2060605@xenomai.org>
 <CAKk99t1AGHj8sOf7Vgy_UZ_+rECP5Vx22cyup--FHsh=RuK2zA@mail.gmail.com>
 <54F97E05.8010107@xenomai.org>
 <CAKk99t3FfAff0X0nGzKD+YcVFQWm5aeSRFB4U6No1YSPuS_qpA@mail.gmail.com>
 <CAKk99t03p_Pc41meo_zzZ0V6X_vjHZRWBeO1aNb+DM2c38pNTg@mail.gmail.com>
 <54FF64AF.5000300@xenomai.org>
 <CAKk99t2159Do6Rj0GSRPkPFcbN-qT9JpWBD1ojmFOHYv7ZKkGg@mail.gmail.com>
 <5500A3DD.2070306@xenomai.org>
 <8dc6116b7b5868d884c9f8c3e3de3c84.squirrel@xenomai.org>
 <CAKk99t0iDYiscgc0w8XthshRbB=BuQvX0t6a31_2Uw+LOayNsQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKk99t0iDYiscgc0w8XthshRbB=BuQvX0t6a31_2Uw+LOayNsQ@mail.gmail.com>
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
To: Helder Daniel <hdaniel@ualg.pt>
Cc: "Xenomai@xenomai.org" <xenomai@xenomai.org>

On Fri, Mar 13, 2015 at 01:50:07PM +0000, Helder Daniel wrote:
> Just for a sanity check I installed Xenomai 2.6.4
> and created kernel-headers-3.14.17 patched with ipipe-core

Well, once again: if the kernel-headers package contains symbolic
link to xenomai sources, then you have to keep xenomai sources (or
the reduced xenomai-kernel-sources package) around. How did you
generate the kernel, with prepare-kernel.sh ?

Does the kernel-header package contain the .config?

> 
> them make /lib/modules/3.14.17-ipipe/build points to the kernel-headers and
> not the full kernel source.

Well, it is silly to touch that build symbolic link:
1- the debian packages are supposed to handle that
2- when building a kernel module you are supposed to pass the path
to kernel source as a parameter to the make -C command. So, simply
passing the path to the kernel headers location should avoid having
to touch the symbolic link.

as documented in Documentation/kbuild/modules.txt in the kernel sources.

-- 
					    Gilles.

