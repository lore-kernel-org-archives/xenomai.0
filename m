From: Wolfgang Netbal <wolfgang.netbal@sigmatek.at>
Message-ID: <5770DA09.5010707@sigmatek.at>
Date: Mon, 27 Jun 2016 09:47:21 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Subject: [Xenomai] Installing Xenomai 2.6.2.1 on kernel 3.10.53
Reply-To: wolfgang.netbal@sigmatek.at
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Xenomai Mailing List <xenomai@xenomai.org>

Dear All,

I have a ipipe patched Kernel 3.10.53 that runs normally with Xenomai 
2.6.4 on an ARM imx6.
Now I have to patch Xenomai 2.6.2.1 into this Kernel ipipe combination 
for testing purpose.
When I run
# ./scripts/prepare-kernel.sh 
--linux=~/kernelDev/ipipe-3.10.53_clean/ipipe --arch=arm --default
  everything works fine, but when I start compilation with
# make LOADADDR=0x10008000 LOCALVERSION= uImage
I get the following error

In file included from 
/home/netwol/Develop/kernelDev/ipipe-3.10.53_clean/ipipe/arch/arm/include/asm/xenomai/syscall.h:29:0,
                  from include/xenomai/nucleus/shadow.h:27,
                  from include/asm-generic/xenomai/system.h:42,
                  from 
/home/netwol/Develop/kernelDev/ipipe-3.10.53_clean/ipipe/arch/arm/include/asm/xenomai/system.h:29,
                  from include/xenomai/nucleus/types.h:36,
                  from include/xenomai/nucleus/queue.h:24,
                  from include/xenomai/nucleus/heap.h:25,
                  from kernel/xenomai/nucleus/bufd.c:144:
include/asm-generic/xenomai/syscall.h: In function 
'__xn_safe_strncpy_from_user':
include/asm-generic/xenomai/syscall.h:148:2: error: implicit declaration 
of function '__strncpy_from_user' [-Werror=implicit-function-declaration]
In file included from include/xenomai/nucleus/timebase.h:33:0,
                  from include/xenomai/nucleus/timer.h:26,
                  from include/xenomai/nucleus/thread.h:159,
                  from include/xenomai/nucleus/sched.h:31,
                  from include/xenomai/nucleus/pod.h:34,
                  from kernel/xenomai/nucleus/bufd.c:145:
include/xenomai/nucleus/vfile.h: In function 'xnvfile_reg_p':
include/xenomai/nucleus/vfile.h:579:9: error: dereferencing pointer to 
incomplete type
include/xenomai/nucleus/vfile.h: In function 'xnvfile_dir_p':
include/xenomai/nucleus/vfile.h:584:9: error: dereferencing pointer to 
incomplete type
include/xenomai/nucleus/vfile.h: In function 'xnvfile_link_p':
include/xenomai/nucleus/vfile.h:589:9: error: dereferencing pointer to 
incomplete type
cc1: some warnings being treated as errors
make[3]: *** [kernel/xenomai/nucleus/bufd.o] Fehler 1
make[2]: *** [kernel/xenomai/nucleus] Fehler 2
make[1]: *** [kernel/xenomai] Fehler 2
make: *** [kernel] Fehler 2

If I fix this I get another error and so on and so forth.

Is it possible to run Xenomai 2.6.2.1 with Kernel 3.10.53 and ipipe ?

If yes can you please tell me where I choose the wrong way.

Kind regards
-- 
Wolfgang Netbal
Softwareentwicklung



