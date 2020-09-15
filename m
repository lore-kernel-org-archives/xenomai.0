Subject: Re: y2038 breakdown
References: <5F520B21.7050401@tj.kylinos.cn>
From: song <chensong@tj.kylinos.cn>
Message-ID: <f4c5a830-7d80-aecb-f844-4de8a1aa9f29@tj.kylinos.cn>+7F36A6C301177032
Date: Tue, 15 Sep 2020 15:05:16 +0800
MIME-Version: 1.0
In-Reply-To: <5F520B21.7050401@tj.kylinos.cn>
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: "Xenomai@xenomai.org" <xenomai@xenomai.org>

Hi guys,

After going through Arnd Bergmann's patch 
list(https://git.kernel.org/pub/scm/linux/kernel/git/arnd/playground.git/log/?h=y2038-syscalls), 
i'm going to get started at 64bit-xenomai y2038-safe(#1 in below list).

1, timespec to __kernel_timespec in syscalls
    timespec to timespec64
2, timex to __kernel_timex
3, syscalls, probably make a new one for 64bits and keep the old one for 
compatibility (like clock_gettime, nanosleep...)
4, 2038-unsafe points in scheduler if there is (like sched time 
interval..., i found xntimer is 64bit, which means it's 2038-safe)
5, get_timespec to get_timespec64
    timespec_valid to timespec64_valid
6, ktime_get_real to ktime_get_real_ts64

There would be more, i haven't figured out the whole pictures yet, and i 
even haven't figured out how to make 32bit app 2038-safe either in 64bit 
kernel or 32bit kernel, as far as my test, time goes back to 1901 when 
sec is wrapped around in GPOS(5.4.40).

1) root@kylin-Lenovo:/home/kylin/workspace/test-2038# ./test2038-gcc-32bit
1, Local time is: Tue Jan 19 11:13:40 2038
2, Local time is: Tue Jan 19 11:13:50 2038
diff 10, sec 0x7fffffee

1, Local time is: Tue Jan 19 11:13:50 2038
2, Local time is: Tue Jan 19 11:14:00 2038
diff 10, sec 0x7ffffff8

1, Local time is: Tue Jan 19 11:14:00 2038
2, Local time is: Sat Dec 14 04:45:54 1901
diff 10, sec 0x80000002


But things are getting clearer, if you have no problem with that, i will 
start some small patches for review.

Let me know your thought about it, many thanks.

BR

chensong



On 2020/9/4 下午5:38, chensong via Xenomai wrote:
> hi Henning,
> 
> I collected some discussions about y2038 from upstream and made a
> rough list for xenomai:
> 
> 1, 64bit-xenomai y2038-safe
> 2, 32bit-xenomai y2038-safe
> 3, 64bit-ipipe y2038-safe (arm64, x86_64)
> 4, 32bit-ipipe y2038-safe (arm, x86)
> 5, syscall (posix and all other skins)
> 6, libc
> 7, 32 bit app y2038-safe
> 8, 64 bit app y2038-sage
> 
> For #1 ~ #4 above , we take care of In-kernel correctness, all the
> data structures time is relevant to are going to be changed to long
> long.or any old time data structures used in either xenomai or 
> ipipe(probably timespec to timespec64).
> 
> For #5, we need to keep the old syscalls for compatibility and
> introduce new 64 bit syscalls.More specificlly, to create new 64bit
> time_t/timespec/timeval/etc variants for syscalls, while
> preserving existing interfaces(posix and all other skins).
> 
> #6, do we need to care about it or we can benefit from upstream?
> 
> #7, we need to cooperate with app developers and #8 seems to be safe
> already.
> 
> 
> other communities info :
> NetBSD preserved compatibility with 2038 unsafe applications
> OpenBSD did not (seeing the certainty of excluding unsafe
> applications as a feature over compatibility)
> 
> 
> http://lkml.iu.edu/hypermail/linux/kernel/1408.1/02587.html
> 
> I will continue to work on the test case and start figuring out 32bit
> time data structures in xenomai, how does it sound to you.
> 
> BR
> 
> chensong
> 
> 
> 
> 



