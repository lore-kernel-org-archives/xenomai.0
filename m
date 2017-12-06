From: Vincent Berenz <vberenz@tuebingen.mpg.de>
Message-ID: <48bfcc92-3224-c7ce-10d9-9f4621e10331@tuebingen.mpg.de>
Date: Wed, 6 Dec 2017 10:55:29 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Subject: [Xenomai] Xenomai 3.0.5 : RTIPC/XDDP protocol not supported by
	kernel
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

Hi,

We are currently moving from xenomai 2 to xenomai 3.
I installed xenomai 3.0.5, and all seems to be working, with low latency.

I am now trying to get our legacy code to work on xenomai 3 using the transition kit.

Our program compiles, but at runtime, on call to rt_pipe_create :
     
     0"000.000| WARNING: [main] RTIPC/XDDP protocol not supported by kernel

Some info:

     cat .config | grep RPIPC

returns:

     CONFIG_XENO_DRIVERS_RTIPC=y
     CONFIG_XENO_DRIVERS_RTIPC_XDDP=y
     CONFIG_XENO_DRIVERS_RTIPC_IDDP=y
     CONFIG_XENO_DRIVERS_RTIPC_BUFP=y

Following call to xeno-config + adding some definition via add_definitions in cmake, we are using these flags:

     flags.make:CXX_FLAGS = -fPIC   -Wl,--no-as-needed -ltrank -Wl,@/usr/xenomai/lib/modechk.wrappers -lalchemy -lcopperplate /usr/xenomai/lib/xenomai/bootstrap.o -Wl,--wrap=main -Wl,--dynamic-list=/usr/xenomai/lib/dynlist.ld -L/usr/xenomai/lib -lcobalt -lmodechk -lpthread -lrt -I/usr/xenomai/include/trank -D__XENO_COMPAT__ -I/usr/xenomai/include/cobalt -I/usr/xenomai/include -D_GNU_SOURCE -D_REENTRANT -D__COBALT__ -I/usr/xenomai/include/alchemy -pipe

and xeno-test starts with:

     arith OK
     bufp OK
     cpu_affinity skipped (no kernel support)
     iddp OK
     leaks OK
     net_packet_dgram skipped (no kernel support)
     net_packet_raw skipped (no kernel support)
     net_udp skipped (no kernel support)
     posix_clock OK
     posix_cond OK
     posix_fork OK
     mutex_trylock not supported
     posix_mutex OK
     posix_select OK
     rtdm skipped (no kernel support)
     sched_quota skipped (no kernel support)
     sched_tp skipped (no kernel support)
     setsched OK
     sigdebug skipped (no kernel support)
     timerfd OK
     tsc OK
     vdso_access OK
     xddp OK

Anything we are doing wrong ?

Many thanks

Vincent


