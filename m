From: Robert Berger <xenomai.list@gmail.com>
Subject: xenomai 3.1/ipipe-core-4.19.128-cip28-arm-10.patch
Message-ID: <3617ad4d-730b-189b-8dd5-02c768cab1c3@gmail.com>
Date: Sat, 4 Jul 2020 21:59:16 +0300
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: "Xenomai@xenomai.org" <xenomai@xenomai.org>

Hi,

I just took the latest and greatest stuff and built it with some Yocto 
dunfell/3.1.1 SDK for some 32 bit ARM i.mx6.

Xenomai/cobalt v3.1 -- #5714ceede (2020-02-04 16:06:11 +0100)

When I run xeno-test I get this:

./xeno-test
++ echo 0
++ testdir=/usr/local/xenomai/bin
++ /usr/local/xenomai/bin/smokey --run random_alloc_rounds=64 
pattern_check_rounds=64
arith OK
...
posix_clock OK
posix_cond OK
posix_fork OK
[  466.998532] [Xenomai] bad syscall <0x197>
posix_mutex OK
posix_select OK
...

0x197 (407) is not avail in 4.19[1], but in 5.4[2]

[1] 
https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/tree/arch/arm/tools/syscall.tbl?h=v4.19.131#n416

[2] 
https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/tree/arch/arm/tools/syscall.tbl?h=v5.4.50#n424 


The SDK was built against 5.4 kernel headers (which is the default for 
Yocto dunfell/3.1.1).

If I run a small C app (without xenomai) which calls this:

static void xeno_sleep_ms(unsigned int ms)
{                               /* < 1000 */
         struct timespec ts;

         ts.tv_sec = 0;
         ts.tv_nsec = ms * 1000000;
         clock_nanosleep(CLOCK_MONOTONIC, 0, &ts, NULL);
}

all is good both with 4.19.x and 4.5.kernel.

Can someone tell me tell me please where the bad syscall comes from?

It looks like someone calls clock_nanosleep_time64, but xenomai is 
developed against 4.19.x where this sycall does not exist, so my first 
idea would be that it comes from the glibc which was built against 5.4 
kernel headers. But the xenomai test case triggers it! I suspect some 
sleep_ms(1) in some weird combination with something but I am not sure 
about it.

[  251.080655] [Xenomai] bad syscall <0x197>

407     common  clock_nanosleep_time64          sys_clock_nanosleep

Please point me towards where to search further.

Regards,

Robert

