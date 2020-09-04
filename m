From: chensong <chensong@tj.kylinos.cn>
Subject: y2038 breakdown
Message-ID: <5F520B21.7050401@tj.kylinos.cn>+15DD063043906F91
Date: Fri, 4 Sep 2020 17:38:41 +0800
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Henning Schild <henning.schild@siemens.com>, "Xenomai@xenomai.org" <xenomai@xenomai.org>

hi Henning,

I collected some discussions about y2038 from upstream and made a
rough list for xenomai:

1, 64bit-xenomai y2038-safe
2, 32bit-xenomai y2038-safe
3, 64bit-ipipe y2038-safe (arm64, x86_64)
4, 32bit-ipipe y2038-safe (arm, x86)
5, syscall (posix and all other skins)
6, libc
7, 32 bit app y2038-safe
8, 64 bit app y2038-sage

For #1 ~ #4 above , we take care of In-kernel correctness, all the
data structures time is relevant to are going to be changed to long
long.or any old time data structures used in either xenomai or 
ipipe(probably timespec to timespec64).

For #5, we need to keep the old syscalls for compatibility and
introduce new 64 bit syscalls.More specificlly, to create new 64bit
time_t/timespec/timeval/etc variants for syscalls, while
preserving existing interfaces(posix and all other skins).

#6, do we need to care about it or we can benefit from upstream?

#7, we need to cooperate with app developers and #8 seems to be safe
already.


other communities info :
NetBSD preserved compatibility with 2038 unsafe applications
OpenBSD did not (seeing the certainty of excluding unsafe
applications as a feature over compatibility)


http://lkml.iu.edu/hypermail/linux/kernel/1408.1/02587.html

I will continue to work on the test case and start figuring out 32bit
time data structures in xenomai, how does it sound to you.

BR

chensong



