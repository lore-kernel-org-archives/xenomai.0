MIME-Version: 1.0
From: Sam Daniel <daniel.jacob.samuel@gmail.com>
Date: Tue, 12 Jan 2021 23:52:37 -0800
Message-ID: <CAPMj8MvB2JmUPcLO8EX5o7RfLxUFb9d-NWGyz5XpCTxuD6QTug@mail.gmail.com>
Subject: mmap64 causes secondary mode switch
Content-Type: text/plain; charset="UTF-8"
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

Should a call to mmap64 cause a switch to secondary mode?

I am using Cobalt v3.1 on an aarch64 platform. I am cross-compiling Xenomai
via buildroot. Then I am cross-compiling a C++ application with CMake
against the Xenomai sysroot and wrapping it with the POSIX skin. I set up
debugging as recommended in the Finding Spurious Relaxes page. When run in
gdb, I get the following stack trace:

#0  0x0000007fbf26978c in mmap64 () from /lib/libc.so.6
#1  0x0000007fbf213094 in ?? () from /lib/libc.so.6
#2  0x0000007fbf213998 in ?? () from /lib/libc.so.6
#3  0x0000007fbf216504 in ?? () from /lib/libc.so.6
#4  0x0000007fbf2173e8 in malloc () from /lib/libc.so.6
#5  0x0000007fbf47f834 in operator new(unsigned long) () from
/lib/libstdc++.so.6
#6  0x0000000000408744 in zcm::ZCM::publish<fcm_dm::fcm_dm_telemetry_t>
(this=0x46c0f0, channel=..., msg=0x7fbe7f34a8)
    at /data/sam/mocha-death/tonkatime/src/zcm/zcm-cpp-impl.hpp:171
#7  0x000000000040819c in FcmDm::task (this=0x46aee0) at
/data/sam/mocha-death/tonkatime/apps/zcm_demo/fcm_dm.cpp:57
#8  0x0000000000415c28 in PeriodicTask::task_caller (_task=0x46aee0) at
/data/sam/mocha-death/tonkatime/src/common/periodic_task.cpp:27
#9  0x0000007fbf5c8e68 in ?? () from /usr/xenomai/lib/libcobalt.so.2
#10 0x0000007fbf57b6cc in start_thread () from /lib/libpthread.so.0
#11 0x0000007fbf26cf7c in ?? () from /lib/libc.so.6

This seems like the mode switch happens on the mmap64 call. From everything
I can tell, mmap64 should be a wrapped and supported system call, thus not
causing mode switches.

Is there something wrong with how I've compiled/wrapped my application?

(venv-ppc) # readelf -d fcm_dm_demo

Dynamic section at offset 0x38cb0 contains 33 entries:
  Tag        Type                         Name/Value
 0x0000000000000001 (NEEDED)             Shared library: [libsystemd.so.0]
 0x0000000000000001 (NEEDED)             Shared library: [librt.so.1]
 0x0000000000000001 (NEEDED)             Shared library: [libcobalt.so.2]
 0x0000000000000001 (NEEDED)             Shared library: [libmodechk.so.0]
 0x0000000000000001 (NEEDED)             Shared library: [libpthread.so.0]
 0x0000000000000001 (NEEDED)             Shared library: [libstdc++.so.6]
 0x0000000000000001 (NEEDED)             Shared library: [libm.so.6]
 0x0000000000000001 (NEEDED)             Shared library: [libgcc_s.so.1]
 0x0000000000000001 (NEEDED)             Shared library: [libc.so.6]

Thanks!
