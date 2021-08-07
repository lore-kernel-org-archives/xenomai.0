References: <79e94bdb-b97c-6f65-c3e7-1a62793855e9@siemens.com>
From: Philippe Gerum <rpm@xenomai.org>
Subject: Re: Arm userland not building with gcc-9 and later
In-reply-to: <79e94bdb-b97c-6f65-c3e7-1a62793855e9@siemens.com>
Date: Sat, 07 Aug 2021 19:00:45 +0200
Message-ID: <87y29d42bm.fsf@xenomai.org>
MIME-Version: 1.0
Content-Type: text/plain
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Jan Kiszka <jan.kiszka@siemens.com>
Cc: Xenomai <xenomai@xenomai.org>, Greg Gallagher <greg@embeddedgreg.com>


Jan Kiszka <jan.kiszka@siemens.com> writes:

> Hi all,
>
> just wanted to debug the RTnet issues we now see in CI on arm and arm64.
> I picked arm as first target, but that apparently starts to break with
> gcc-9 or newer (tried 9.2 and 10.2):
>
> make[5]: Entering directory '/xenomai/lib/cobalt/arch/arm'
>   CC       libarch_la-features.lo
> features.c: In function 'cobalt_arch_check_features':
> features.c:82:1: error: r7 cannot be used in 'asm' here
>    82 | }
>       | ^
>
> That seems to be related to passing the syscall number via r7 on ARM. Is
> our ABI soon no longer compilable, or can we fix this?
>

Just tried to reproduce this issue with the latest stable (10.3-2021.07)
from ARM [1], and a fairly recent linaro snapshot (11.0.1-2021.03) [2],
to no avail. I tried with --enable-debug=symbols, --disable-debug,
--enable-debug=full, no issue so far.

Can you please share you configure settings?

[1]
https://developer.arm.com/-/media/Files/downloads/gnu-a/10.3-2021.07/binrel/gcc-arm-10.3-2021.07-x86_64-arm-none-linux-gnueabihf.tar.xz

[2]
https://snapshots.linaro.org/gnu-toolchain/11.0-2021.03-1/arm-linux-gnueabihf/gcc-linaro-11.0.1-2021.03-aarch64_arm-linux-gnueabihf.tar.xz

-- 
Philippe.

