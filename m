From: "Leopold Palomo-Avellaneda" <leo@alaxarxa.net>
Date: Wed, 26 Jun 2013 09:06:22 +0200
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <201306260906.22955.leo@alaxarxa.net>
Subject: [Xenomai] Xenomai warn_upon_switch
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: "xenomai@xenomai.org" <xenomai@xenomai.org>

Hi,

since 2.6.x the Orocos users have difficulties (or simple cannot) use Xenomai. 
Despite of some bug in the Orocos code, xenomai emits a warn_upon_switch that 
makes the user to use a console program - deployer - (basically for the orocos 
philosofy) to launch rt programs.

I think that this signal must be treated in some way by the Orocos code, but 
it's not developed yet. Since then, there's a way to silent this signal, or 
simple that doesn't overflow the console but thousand of messages like this:

/opt/orocos-toolchain-xenomai/install/lib/liborocos-rtt-
xenomai.so.2.6(warn_upon_switch+0x15)[0x7f662af09295]
/lib/x86_64-linux-gnu/libpthread.so.0(+0xf030)[0x7f66297eb030]
/usr/lib/libnative.so.3(rt_mutex_release+0xbb)[0x7f6629c0231b]
/opt/orocos-toolchain-xenomai/install/lib/liborocos-rtt-
xenomai.so.2.6(_ZN3RTT2os6ThreadD1Ev+0x11d)[0x7f662af0530d]
/opt/orocos-toolchain-xenomai/install/lib/liborocos-rtt-
xenomai.so.2.6(_ZN3RTT8ActivityD2Ev+0x37)[0x7f662aebbd27]
/opt/orocos-toolchain-xenomai/install/lib/liborocos-rtt-
xenomai.so.2.6(_ZN3RTT8ActivityD0Ev+0x9)[0x7f662aebbd79]
/opt/orocos-toolchain-xenomai/install/lib/liborocos-rtt-
xenomai.so.2.6(_ZN3RTT11TaskContextD1Ev+0x16c)[0x7f662aebd0ac]
/opt/orocos-toolchain-xenomai/install/lib/liborocos-ocl-taskbrowser-
xenomai.so.2.6.0(_ZN3OCL11TaskBrowserD1Ev+0xed)[0x7f662a9193fd]
deployer-xenomai(main+0x70a)[0x40f67a]
/lib/x86_64-linux-gnu/libc.so.6(__libc_start_main+0xfd)[0x7f6627e5fead]
deployer-xenomai[0x40fa5d]
/opt/orocos-toolchain-xenomai/install/lib/liborocos-rtt-
xenomai.so.2.6(warn_upon_switch+0x15)[0x7f662af09295]
/lib/x86_64-linux-gnu/libpthread.so.0(+0xf030)[0x7f66297eb030]
/usr/lib/libnative.so.3(rt_mutex_release+0xbb)[0x7f6629c0231b]
/opt/orocos-toolchain-xenomai/install/lib/liborocos-rtt-
xenomai.so.2.6(_ZN3RTT2os5MutexD1Ev+0x3d)[0x7f662aeb91fd]
/opt/orocos-toolchain-xenomai/install/lib/liborocos-rtt-
xenomai.so.2.6(_ZN3RTT11TaskContextD1Ev+0xfc)[0x7f662aebd03c]
/opt/orocos-toolchain-xenomai/install/lib/liborocos-ocl-taskbrowser-
xenomai.so.2.6.0(_ZN3OCL11TaskBrowserD1Ev+0xed)[0x7f662a9193fd]
deployer-xenomai(main+0x70a)[0x40f67a]
/lib/x86_64-linux-gnu/libc.so.6(__libc_start_main+0xfd)[0x7f6627e5fead]
deployer-xenomai[0x40fa5d]
/opt/orocos-toolchain-xenomai/install/lib/liborocos-rtt-
xenomai.so.2.6(warn_upon_switch+0x15)[0x7f662af09295]
/lib/x86_64-linux-gnu/libpthread.so.0(+0xf030)[0x7f66297eb030]
/usr/lib/libnative.so.3(rt_mutex_release+0xbb)[0x7f6629c0231b]
/opt/orocos-toolchain-xenomai/install/lib/liborocos-rtt-
xenomai.so.2.6(_ZN3RTT15ExecutionEngineD2Ev+0x2d2)[0x7f662aef71d2]
/opt/orocos-toolchain-xenomai/install/lib/liborocos-rtt-
xenomai.so.2.6(_ZN3RTT15ExecutionEngineD0Ev+0x9)[0x7f662aef7319]
/opt/orocos-toolchain-xenomai/install/lib/liborocos-ocl-taskbrowser-
xenomai.so.2.6.0(_ZN3OCL11TaskBrowserD1Ev+0xed)[0x7f662a9193fd]
deployer-xenomai(main+0x70a)[0x40f67a]
/lib/x86_64-linux-gnu/libc.so.6(__libc_start_main+0xfd)[0x7f6627e5fead]
deployer-xenomai[0x40fa5d]
/opt/orocos-toolchain-xenomai/install/lib/liborocos-rtt-
xenomai.so.2.6(warn_upon_switch+0x15)[0x7f662af09295]
/lib/x86_64-linux-gnu/libpthread.so.0(+0xf030)[0x7f66297eb030]
/usr/lib/libnative.so.3(rt_mutex_release+0xbb)[0x7f6629c0231b]
/opt/orocos-toolchain-xenomai/install/lib/liborocos-rtt-
xenomai.so.2.6(_ZN3RTT2os6ThreadD1Ev+0x11d)[0x7f662af0530d]
/opt/orocos-toolchain-xenomai/install/lib/liborocos-rtt-
xenomai.so.2.6(_ZN3RTT8ActivityD2Ev+0x37)[0x7f662aebbd27]
/opt/orocos-toolchain-xenomai/install/lib/liborocos-rtt-
xenomai.so.2.6(_ZN3RTT8ActivityD0Ev+0x9)[0x7f662aebbd79]
/opt/orocos-toolchain-xenomai/install/lib/liborocos-rtt-
xenomai.so.2.6(_ZN3RTT11TaskContextD1Ev+0x16c)[0x7f662aebd0ac]
/opt/orocos-toolchain-xenomai/install/lib/liborocos-ocl-deployment-
xenomai.so.2.6.0(_ZN3OCL19DeploymentComponentD2Ev+0x1bf)[0x7f662a60c9af]
deployer-xenomai(main+0x3c0)[0x40f330]
/lib/x86_64-linux-gnu/libc.so.6(__libc_start_main+0xfd)[0x7f6627e5fead]
deployer-xenomai[0x40fa5d]
/opt/orocos-toolchain-xenomai/install/lib/liborocos-rtt-
xenomai.so.2.6(warn_upon_switch+0x15)[0x7f662af09295]
/lib/x86_64-linux-gnu/libpthread.so.0(+0xf030)[0x7f66297eb030]
/usr/lib/libnative.so.3(rt_mutex_release+0xbb)[0x7f6629c0231b]
/opt/orocos-toolchain-xenomai/install/lib/liborocos-rtt-
xenomai.so.2.6(_ZN3RTT2os5MutexD1Ev+0x3d)[0x7f662aeb91fd]
/opt/orocos-toolchain-xenomai/install/lib/liborocos-rtt-
xenomai.so.2.6(_ZN3RTT11TaskContextD1Ev+0xfc)[0x7f662aebd03c]
/opt/orocos-toolchain-xenomai/install/lib/liborocos-ocl-deployment-
xenomai.so.2.6.0(_ZN3OCL19DeploymentComponentD2Ev+0x1bf)[0x7f662a60c9af]
deployer-xenomai(main+0x3c0)[0x40f330]
/lib/x86_64-linux-gnu/libc.so.6(__libc_start_main+0xfd)[0x7f6627e5fead]
deployer-xenomai[0x40fa5d]
/opt/orocos-toolchain-xenomai/install/lib/liborocos-rtt-
xenomai.so.2.6(warn_upon_switch+0x15)[0x7f662af09295]
/lib/x86_64-linux-gnu/libpthread.so.0(+0xf030)[0x7f66297eb030]
/usr/lib/libnative.so.3(rt_mutex_release+0xbb)[0x7f6629c0231b]
/opt/orocos-toolchain-xenomai/install/lib/liborocos-rtt-
xenomai.so.2.6(_ZN3RTT15ExecutionEngineD2Ev+0x2d2)[0x7f662aef71d2]
/opt/orocos-toolchain-xenomai/install/lib/liborocos-rtt-
xenomai.so.2.6(_ZN3RTT15ExecutionEngineD0Ev+0x9)[0x7f662aef7319]
/opt/orocos-toolchain-xenomai/install/lib/liborocos-ocl-deployment-
xenomai.so.2.6.0(_ZN3OCL19DeploymentComponentD2Ev+0x1bf)[0x7f662a60c9af]
deployer-xenomai(main+0x3c0)[0x40f330]
/lib/x86_64-linux-gnu/libc.so.6(__libc_start_main+0xfd)[0x7f6627e5fead]
deployer-xenomai[0x40fa5d]
/opt/orocos-toolchain-xenomai/install/lib/liborocos-rtt-
xenomai.so.2.6(warn_upon_switch+0x15)[0x7f662af09295]
/lib/x86_64-linux-gnu/libpthread.so.0(+0xf030)[0x7f66297eb030]
/usr/lib/libnative.so.3(rt_mutex_release+0xbb)[0x7f6629c0231b]
/opt/orocos-toolchain-xenomai/install/lib/liborocos-rtt-
xenomai.so.2.6(_ZN3RTT2os6ThreadD1Ev+0x11d)[0x7f662af0530d]
/opt/orocos-toolchain-xenomai/install/lib/liborocos-rtt-
xenomai.so.2.6(_ZN3RTT8ActivityD2Ev+0x37)[0x7f662aebbd27]
/opt/orocos-toolchain-xenomai/install/lib/liborocos-rtt-
xenomai.so.2.6(_ZN3RTT8ActivityD0Ev+0x9)[0x7f662aebbd79]
/opt/orocos-toolchain-xenomai/install/lib/liborocos-rtt-
xenomai.so.2.6(_ZN3RTT8internal12GlobalEngineD1Ev+0x8a)[0x7f662af2657a]
/opt/orocos-toolchain-xenomai/install/lib/liborocos-rtt-
xenomai.so.2.6(_ZN3RTT8internal12GlobalEngineD0Ev+0x9)[0x7f662af265f9]
/opt/orocos-toolchain-xenomai/install/lib/liborocos-rtt-
xenomai.so.2.6(_ZN3RTT8internal12GlobalEngine7ReleaseEv+0x16)[0x7f662af267f6]
/opt/orocos-toolchain-xenomai/install/lib/liborocos-rtt-
xenomai.so.2.6(_Z9__os_exitv+0x6)[0x7f662af07976]
deployer-xenomai(main+0x49b)[0x40f40b]
/lib/x86_64-linux-gnu/libc.so.6(__libc_start_main+0xfd)[0x7f6627e5fead]
deployer-xenomai[0x40fa5d]
/opt/orocos-toolchain-xenomai/install/lib/liborocos-rtt-
xenomai.so.2.6(warn_upon_switch+0x15)[0x7f662af09295]
/lib/x86_64-linux-gnu/libpthread.so.0(+0xf030)[0x7f66297eb030]
/usr/lib/libnative.so.3(rt_mutex_release+0xbb)[0x7f6629c0231b]
/opt/orocos-toolchain-xenomai/install/lib/liborocos-rtt-
xenomai.so.2.6(_ZN3RTT15ExecutionEngineD2Ev+0x2d2)[0x7f662aef71d2]
/opt/orocos-toolchain-xenomai/install/lib/liborocos-rtt-
xenomai.so.2.6(_ZN3RTT8internal12GlobalEngineD0Ev+0x9)[0x7f662af265f9]
/opt/orocos-toolchain-xenomai/install/lib/liborocos-rtt-
xenomai.so.2.6(_ZN3RTT8internal12GlobalEngine7ReleaseEv+0x16)[0x7f662af267f6]
/opt/orocos-toolchain-xenomai/install/lib/liborocos-rtt-
xenomai.so.2.6(_Z9__os_exitv+0x6)[0x7f662af07976]
deployer-xenomai(main+0x49b)[0x40f40b]
/lib/x86_64-linux-gnu/libc.so.6(__libc_start_main+0xfd)[0x7f6627e5fead]
deployer-xenomai[0x40fa5d]
/opt/orocos-toolchain-xenomai/install/lib/liborocos-rtt-
xenomai.so.2.6(warn_upon_switch+0x15)[0x7f662af09295]
/lib/x86_64-linux-gnu/libpthread.so.0(+0xf030)[0x7f66297eb030]
/usr/lib/libnative.so.3(rt_mutex_release+0xbb)[0x7f6629c0231b]
/opt/orocos-toolchain-xenomai/install/lib/liborocos-rtt-
xenomai.so.2.6(_ZN3RTT6plugin12PluginLoaderD1Ev+0x72)[0x7f662af37af2]
/opt/orocos-toolchain-xenomai/install/lib/liborocos-rtt-
xenomai.so.2.6(_ZN5boost6detail17sp_counted_impl_pIN3RTT6plugin12PluginLoaderEE7disposeEv+0x12)
[0x7f662af3eeb2]
/opt/orocos-toolchain-xenomai/install/lib/liborocos-rtt-
xenomai.so.2.6(_ZN3RTT6plugin12PluginLoader7ReleaseEv+0x59)[0x7f662af37089]
/opt/orocos-toolchain-xenomai/install/lib/liborocos-rtt-
xenomai.so.2.6(_ZN3RTT2os16StartStopManager6callerEN5boost8functionIFvvEEE+0x18)
[0x7f662af02858]
/opt/orocos-toolchain-xenomai/install/lib/liborocos-rtt-
xenomai.so.2.6(_ZN5boost6detail8function22void_function_invoker1IPFvNS_8functionIFvvEEEEvS5_E6invokeERNS1_15function_bufferES5_+0x44)
[0x7f662af026a4]
/opt/orocos-toolchain-xenomai/install/lib/liborocos-rtt-
xenomai.so.2.6(_ZSt8for_eachISt16reverse_iteratorIN9__gnu_cxx17__normal_iteratorIPN5boost8functionIFvvEEESt6vectorIS6_SaIS6_EEEEENS4_IFvS6_EEEET0_T_SG_SF_+0xb9)
[0x7f662af02c09]
/opt/orocos-toolchain-xenomai/install/lib/liborocos-rtt-
xenomai.so.2.6(_ZN3RTT2os16StartStopManager4stopEv+0x6a)[0x7f662af0215a]
/opt/orocos-toolchain-xenomai/install/lib/liborocos-rtt-
xenomai.so.2.6(_Z9__os_exitv+0x4f)[0x7f662af079bf]
deployer-xenomai(main+0x49b)[0x40f40b]
/lib/x86_64-linux-gnu/libc.so.6(__libc_start_main+0xfd)[0x7f6627e5fead]
deployer-xenomai[0x40fa5d]
/opt/orocos-toolchain-xenomai/install/lib/liborocos-rtt-
xenomai.so.2.6(warn_upon_switch+0x15)[0x7f662af09295]
/lib/x86_64-linux-gnu/libpthread.so.0(+0xf030)[0x7f66297eb030]
/usr/lib/libnative.so.3(rt_mutex_release+0xbb)[0x7f6629c0231b]
/opt/orocos-toolchain-xenomai/install/lib/liborocos-rtt-
xenomai.so.2.6(_ZN3RTT6LoggerD2Ev+0x57)[0x7f662aeb69f7]
/opt/orocos-toolchain-xenomai/install/lib/liborocos-rtt-
xenomai.so.2.6(_ZN3RTT6Logger7ReleaseEv+0x32)[0x7f662aeb7902]
/opt/orocos-toolchain-xenomai/install/lib/liborocos-rtt-
xenomai.so.2.6(_Z9__os_exitv+0x85)[0x7f662af079f5]
deployer-xenomai(main+0x49b)[0x40f40b]
/lib/x86_64-linux-gnu/libc.so.6(__libc_start_main+0xfd)[0x7f6627e5fead]
deployer-xenomai[0x40fa5d]
TLSF bytes allocated=524288 overhead=6368 max-used=6368 currently-used=6368 
still-allocated=0
/opt/orocos-toolchain-xenomai/install/lib/liborocos-rtt-
xenomai.so.2.6(warn_upon_switch+0x15)[0x7f662af09295]
/lib/x86_64-linux-gnu/libpthread.so.0(+0xf030)[0x7f66297eb030]
/usr/lib/libnative.so.3(rt_mutex_release+0xbb)[0x7f6629c0231b]
/opt/orocos-toolchain-xenomai/install/lib/liborocos-rtt-
xenomai.so.2.6(_ZN3RTT5types18TypeInfoRepositoryD1Ev+0x165)[0x7f662af2d515]
/opt/orocos-toolchain-xenomai/install/lib/liborocos-rtt-
xenomai.so.2.6(_ZN5boost6detail17sp_counted_impl_pIN3RTT5types18TypeInfoRepositoryEE7disposeEv+0x12)
[0x7f662af2e912]
/opt/orocos-toolchain-xenomai/install/lib/liborocos-rtt-
xenomai.so.2.6(_ZN5boost10shared_ptrIN3RTT5types18TypeInfoRepositoryEED2Ev+0x29)
[0x7f662aed52c9]
/lib/x86_64-linux-gnu/libc.so.6(__cxa_finalize+0xa5)[0x7f6627e78175]
/opt/orocos-toolchain-xenomai/install/lib/liborocos-rtt-
xenomai.so.2.6(+0xf83d3)[0x7f662aeb03d3]


Thanks in advance,

Leopold
-- 
--
Linux User 152692
Catalonia

