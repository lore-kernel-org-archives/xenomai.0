Message-ID: <555BA2F4.4030106@techfak.uni-bielefeld.de>
Date: Tue, 19 May 2015 22:54:12 +0200
From: Robert Haschke <rhaschke@techfak.uni-bielefeld.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Transfer-Encoding: 8bit
Subject: [Xenomai] rtdm_driver.h fails to build: implicit declaration of
	smp_mb__before_atomic_dec()
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

I'm trying to build Xenomai 2.6.4 on linux 3.18.13 with i-pipe patch for 
3.18.12.
When enabling RTDM support, the compiler throws the following error:

In file included from ../kernel/xenomai/skins/posix/syscall.c:40:0:
../include/xenomai/rtdm/rtdm_driver.h: In function ‘rtdm_context_unlock’:
../include/xenomai/rtdm/rtdm_driver.h:587:2: error: implicit declaration 
of function ‘smp_mb__before_atomic_dec’ 
[-Werror=implicit-function-declaration]
   smp_mb__before_atomic_dec();
   ^
cc1: some warnings being treated as errors

This function became deprecated in kernel 3.16 and was removed in 3.18.

Best, Robert

