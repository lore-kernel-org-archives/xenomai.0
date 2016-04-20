References: <57155DFC.9000606@sigmatek.at>
 <20160419191052.GE29711@hermes.click-hack.org>
 <20160419193006.GG29711@hermes.click-hack.org>
From: Johann Obermayr <johann.obermayr@sigmatek.at>
Message-ID: <5717554B.1090905@sigmatek.at>
Date: Wed, 20 Apr 2016 12:09:15 +0200
MIME-Version: 1.0
In-Reply-To: <20160419193006.GG29711@hermes.click-hack.org>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] rt task & stack overflow
Reply-To: johann.obermayr@sigmatek.at
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
Cc: xenomai@xenomai.org

Am 19.04.2016 um 21:30 schrieb Gilles Chanteperdrix:
> On Tue, Apr 19, 2016 at 09:10:52PM +0200, Gilles Chanteperdrix wrote:
>> On Tue, Apr 19, 2016 at 12:21:48AM +0200, Johann Obermayr wrote:
>>> Hello,
>>>
>>> is there a way to handle a stack overflow with a xenomai  rt_task ?
>>>
>>> this example work for a standard linux
>> This example does not handle stack overflows. It handles the SIGSEGV
>> signal, which may happen in case of stack overflow or for many other
>> reasons. In order to handle properly a stack overflow, you would
>> have to:
>> - use the SA_SIGINFO flag and setup an sa_sigaction handler instead
>> of sa_handler with additional arguments
>> - in the handler, use the additional arguments to extract the fault
>> address and architecture specific stack pointer and check that the
>> fault address is "near" the stack pointer (and in fact it may not be
>> at all)
>> - or walk /proc/self/maps to find the mapping where the fault
>> address is and check if it is "near" a thread stack.
>> - or check that the fault program counter is an operation involving
>> a store or read relative to the stack pointer.
>>
>> But I do not think there is a reliable way to detect stack
>> overflows. It is even possible to overflow the stack so much that
>> the code appears to work by writing to another thread stack (if the
>> overflow length is larger than the glibc guard size).
>>
>>> #define _XOPEN_SOURCE 700
>>> #include <stdio.h>
>>> #include <signal.h>
>>> #include <unistd.h>
>>> void handler(int sig)
>>> {
>>>       printf("stack overflow: %d\n", sig);
>>>       _exit(1);
>>> }
>> Also, using printf in a signal handler is bad. printf is not async
>> signal safe.
> And on my platform at least, SIGSTKSZ is something like 8192 or
> 16384 which may be too small for a printf, so printf could cause a
> stack overflow (depending on the length of the printed string).
>
Hello,

Thanks you for answer.

i have refactoring the example.
Here is the source
-------------------------------------------------- begin source
#define __USE_BSD

#include <stdio.h>
#include <malloc.h>
#include <memory.h>
#include <signal.h>
#include <unistd.h>
#include <sys/types.h>
#include <sys/mman.h> //mloockall

#ifdef USE_XENOMAI
#include <native/task.h>
#endif

#define SIGSTACKSIZE    32*1024

void dohandler(const char *name, int sig, siginfo_t *info, void *ptr)
{
     char buf[256];

     int len = sprintf(buf, "%s: signal_handler: %d\n", name, sig);
     write(STDOUT_FILENO, buf, len) ;
     _exit(1);
}

void signal_handler_linux(int sig, siginfo_t *info, void *ptr)
{
     dohandler("linux", sig, info, ptr);
}

void signal_handler_xeno(int sig, siginfo_t *info, void *ptr)
{
     dohandler("xeno", sig, info, ptr);
}


unsigned infinite_recursion(unsigned x) {
     char buf[4*128*1024];

     memset(buf, 0, sizeof(buf));
     return infinite_recursion(x)+1;
}

void help()
{
     printf("program <options>\n");
     printf("  --help              this help\n");
     printf("  --sigstack          use the sigalstack function to set a 
own signal stack\n");
     _exit(1);
}

int main(int argc, char *argv[])
{
#ifdef USE_XENOMAI
     RT_TASK mainTask;
     int rval;
#endif

     static char stack[SIGSTACKSIZE];
     stack_t ss = {
         .ss_size = SIGSTACKSIZE,
         .ss_sp = stack,
     .ss_flags = SS_ONSTACK,
     };
     struct sigaction sa = {
         .sa_sigaction = signal_handler_linux,
         .sa_flags = SA_SIGINFO,
     };
     int i;
     int use_sigstack = 0;

     mlockall(MCL_CURRENT|MCL_FUTURE);

     for(i = 1; i < argc; i++) {
         if (strcmp(argv[i], "--help") == 0) help();
         if (strcmp(argv[i], "--sigstack") == 0) use_sigstack = 1;
     }

     if (use_sigstack) {
         sa.sa_flags |= SA_ONSTACK;
         sigaltstack(&ss, 0);
     }

     sigfillset(&sa.sa_mask);
     sigaction(SIGSEGV, &sa, 0);

#ifdef USE_XENOMAI
     rval = rt_task_shadow(&mainTask, "MainRecursion", 5, 0);
     if (rval)
         printf("rt_task_shadow return:%d\n", rval);
     rval = rt_sigaction(SIGSEGV, signal_handler_xeno);
     if (rval)
         printf("rt_sigaction return:%d\n", rval);

#endif
     infinite_recursion(0);
}
--------------------------------------------- end source

i create to example first without xenomai, second with xenomai.

root@sigmatek-arm-mp:~# ./signaltest01arm
Segmentation fault

root@sigmatek-arm-mp:~# ./signaltest01arm --sigstack
linux: signal_handler: 11

root@sigmatek-arm-mp:~# ./signaltest01armx
Segmentation fault

root@sigmatek-arm-mp:~# ./signaltest01armx --sigstack
Segmentation fault

root@sigmatek-arm-mp:~#

for a standard linux thread the function sigaltstack will work correct.
But not with xenomai (rt_task_shadow)

we use kernel 3.0.53 & xenomai 2.6.2.1.

regards
   Johann



