Mime-Version: 1.0 (Apple Message framework v1076)
Content-Type: text/plain; charset=us-ascii; format=flowed; delsp=yes
From: Stefan Schaal <sschaal@domain.hid>
In-Reply-To: <195F4A80-1B62-4673-804B-71CC6F6DD60C@usc.edu>
Date: Sun, 1 Nov 2009 23:02:13 -0800
Content-Transfer-Encoding: 7bit
Message-Id: <84E78C77-1DC1-44EE-8703-62C89A204B81@domain.hid>
References: <E65E9416-A152-4EFE-93C8-31A123514B6E@usc.edu>
	<195F4A80-1B62-4673-804B-71CC6F6DD60C@usc.edu>
Subject: [Xenomai-core] lots of mode switches in xenomai-head tree?
List-Id: Xenomai life and development <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Stefan Schaal <sschaal@domain.hid>
Cc: Jonas Buchli <jonas@domain.hid>, Peter Pastor Sampedro <pastorsa@domain.hid>, xenomai@xenomai.org

Hi,

   I am working with the latest xenomai-head tree (we need analogy for  
our NI board ...). Under Xenomai 2.4.8 our code did not have any mode  
switches. Using the xenomai-head, we get a lot of mode switches. Using  
he backtrace_symbols_fd, we get print-outs like:


xsimulation[0x808553b]
[0xffffe400]
/usr/xenomai/lib/librtdk.so.0(assert_nrt+0x85)[0xb7fa2ea5]
/usr/xenomai/lib/librtdk.so.0(__wrap_clock_gettime+0x17)[0xb7fa2ef7]
xsimulation[0x807cd16]
xsimulation[0x807d7fb]
/usr/xenomai/lib/libnative.so.3[0xb7fab689]
/lib/tls/i686/cmov/libpthread.so.0[0xb7f824ff]
/lib/tls/i686/cmov/libc.so.6(clone+0x5e)[0xb7e8f49e]

Which indicates that the wrapper for clock_gettime causes this  
trouble, which is also confirmed by commenting clock_gettime out, and  
the  mode switches disappear.

  Maybe something that needs fixing?

Best wishes,

-Stefan




