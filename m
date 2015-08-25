From: Philippe Gerum <rpm@xenomai.org>
References: <CAJqUr7ybpmgOev-iPaQ-iMEAF8SBocn54vyYSbLcm9spMY=FBg@mail.gmail.com>
Message-ID: <55DC76C7.5040606@xenomai.org>
Date: Tue, 25 Aug 2015 16:08:07 +0200
MIME-Version: 1.0
In-Reply-To: <CAJqUr7ybpmgOev-iPaQ-iMEAF8SBocn54vyYSbLcm9spMY=FBg@mail.gmail.com>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] xenomai/ipipe arm64 port
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Don Mahurin <don@mperpetuo.com>, xenomai@xenomai.org

On 08/25/2015 02:13 AM, Don Mahurin wrote:
> Hi all,
> 
> We would like to submit our current work on the arm64 port of
> ipipe/xenomai. We hope that this contribution will encourage further
> development of arm64 support in ipipe/xenomai.
>

arm64 support is definitely a high priority item. Thanks for tackling this.

> This port was largely developed on ipipe-3.10 as a base, so it is likely to
> be the most well tested there. Though recently, we have also ported these
> changes to ipipe-3.14.44. ( We noticed that 3.10 is missing from rc7. Is
> this intended, or will 3.10 support return? )

ipipe-core-3.10.32-arm-10.patch is still part of the distribution in
-rc7. This said, the absence of a patch targeting a particular kernel
release in a given Xenomai version does not mean the latter can't run
over the former. This rather means that we did not check for it. Xenomai
3 over Cobalt requires a kernel release >= 3.10 though.

> 
> At the end of this message are the relevant git repos and branches for the
> arm64 port. Also included is a build script to build a minimal busybox
> linux system which may be ran using qemu (arm64 virt).
> 
> 
> Development status:
> 
> The 3.14 port is missing the fast-syscall changes (in entry.S) from armv7,
> and instead contains the 3.10 entry.S changes forward ported to 3.14.
> 
> FPU support is incomplete.
> 
> Smokey tests:
> 
> 3.10/rc6 smokey tests all pass
> 3.14/rc6 smokey tests all pass
> 3.14/rc7 smokey tests sched-quota and sched-tp fail
> 

This is likely because -rc7 has added checks to sched-* tests which have
time-dependent results, so they may not match the expected value in a
qemu-based execution.

> 
> git repos:
> 
> https://gitlab.mperpetuo.com/it/xenomai-3.git
> https://gitlab.mperpetuo.com/it/ipipe.git
> https://gitlab.mperpetuo.com/it/build-scripts.git
>

It looks like curl does not like the cypher used by this server. http is
fine though.

> ipipe/xenomai arm64 branches:
> 
> ipipe-core-3.10.32-arm-10-arm64-2c, v3.0-rc6-arm64-1c
> ipipe-core-3.14.44-arm-11-arm64-2, v3.0-rc6-arm64-1c
> ipipe-core-3.14.44-arm-12-arm64-2, v3.0-rc7-arm64-1c
> 
> 
> The system is built with the following commands.
> git clone https://gitlab.mperpetuo.com/it/build-scripts.git
> mkdir -p build
> cd build
> ../build-scripts/build_linux_emulator-arm64.sh
> or
> ../build-scripts/build_linux_emulator-arm64.sh --314-rc6
> or
> ../build-scripts/build_linux_emulator-arm64.sh --314-rc7
> 

This went almost fine except the rsync step which assumes a native arm64
host for populating the rootfs, I have no such beast. But that's not a
major issue, I can take another path for building it.

> To run the resulting build:
> sudo apt-get install qemu-system-arm
> ( cd out/target/product/xenomai_arm64; ./run.sh )
> 
> 
> We look forward to any feedback or questions. Please let us know how we may
> continue to contribute to move this arm64 port forward.
> 

I only had a quick look to the code so far, but as a preliminary step,
you may want to split cobalt/arch/arm (and the related include areas)
from cobalt/arch/arm64 in the Xenomai tree, following the convention
used in the mainline kernel. Having a moderate amount of duplicate code
between arm and arm64 is acceptable, compared to dealing with
cross-architecture headers sprinkled with #ifdefery. arm and arm64 are
distinct enough.

I believe we should target 3.14 for the first implementation, since the
I-pipe bits in 3.10 are lagging slightly behind already, 3.14 contains
the latest changes to the interrupt pipeline though.

-- 
Philippe.

