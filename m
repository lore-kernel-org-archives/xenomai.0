Date: Mon, 31 Dec 2012 18:32:31 +0100
From: "Mariusz Janiak" <mariuszjaniak@wp.pl>
Message-ID: <50e1cc2fb40c67.12589971@wp.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Subject: [Xenomai] SIGXCPU with rt_mutex_release
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Xenomai <xenomai@xenomai.org>

Hi,

I have met problem when I run OROCOS helloWord example. Xenomai generate SIGXCPU signal when rt_mutex_release(...) is called. I have installed signal handler for each realtime thread created by OROCOS and I get following result 

SIGDEBUG received, reason 4: affected by priority inversion
/worek/install/orocos-toolchain-xeno/install/lib/liborocos-rtt-xenomai.so.2.6(my_warn_upon_switch+0x44)[0x7f687ad75024]
/lib/x86_64-linux-gnu/libpthread.so.0(+0xfcb0)[0x7f687a5dbcb0]
/usr/xenomai/lib/libnative.so.3(rt_mutex_release+0xbb)[0x7f687a7ecf5b]
/worek/install/orocos-toolchain-xeno/install/lib/liborocos-rtt-xenomai.so.2.6(_ZN3RTT2os6ThreadD1Ev+0x129)[0x7f687ad73d89]
/worek/install/orocos-toolchain-xeno/install/lib/liborocos-rtt-xenomai.so.2.6(_ZN3RTT8ActivityD2Ev+0x37)[0x7f687ad272e7]
/worek/install/orocos-toolchain-xeno/install/lib/liborocos-rtt-xenomai.so.2.6(_ZN3RTT8ActivityD0Ev+0x9)[0x7f687ad27339]
/worek/install/orocos-toolchain-xeno/install/lib/liborocos-rtt-xenomai.so.2.6(_ZN5boost10shared_ptrIN3RTT4base17ActivityInterfaceEEaSERKS4_+0x4e)[0x7f687ad3fb6e]
/worek/install/orocos-toolchain-xeno/install/lib/liborocos-rtt-xenomai.so.2.6(_ZN3RTT11TaskContext11setActivityEPNS_4base17ActivityInterfaceE+0x72)[0x7f687ad34d32]
./helloworld(_ZN3OCL10HelloWorldC2ESs+0x19f)[0x4505ff]
./helloworld(_Z13ORO_main_impliPPc+0xe3)[0x445393]
./helloworld(main+0x83)[0x444d63]
/lib/x86_64-linux-gnu/libc.so.6(__libc_start_main+0xed)[0x7f6879a1976d]
./helloworld[0x444f01]

There is much bigger mess during exiting from application. I am not pretty sure this is a Xenomai problem, if not sorry for bothering. I haven check it with previous Xenomai release yet.

Best regards and happy new year,
Mariusz





