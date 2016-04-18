From: Johann Obermayr <johann.obermayr@sigmatek.at>
Message-ID: <57155DFC.9000606@sigmatek.at>
Date: Tue, 19 Apr 2016 00:21:48 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Subject: [Xenomai] rt task & stack overflow
Reply-To: johann.obermayr@sigmatek.at
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

Hello,

is there a way to handle a stack overflow with a xenomai  rt_task ?

this example work for a standard linux
#define _XOPEN_SOURCE 700
#include <stdio.h>
#include <signal.h>
#include <unistd.h>
void handler(int sig)
{
     printf("stack overflow: %d\n", sig);
     _exit(1);
}
unsigned infinite_recursion(unsigned x) {
     return infinite_recursion(x)+1;
}
int main()
{
     static char stack[SIGSTKSZ];
     stack_t ss = {
         .ss_size = SIGSTKSZ,
         .ss_sp = stack,
     };
     struct sigaction sa = {
         .sa_handler = handler,
         .sa_flags = SA_ONSTACK
     };
     sigaltstack(&ss, 0);
     sigfillset(&sa.sa_mask);
     sigaction(SIGSEGV, &sa, 0);
     infinite_recursion(0);
}


thanks for help

regards
   Johann

