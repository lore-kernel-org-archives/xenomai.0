Message-ID: <504F6C8E.8070706@logilin.fr>
Date: Tue, 11 Sep 2012 18:53:34 +0200
From: Christophe Blaess <mailist@logilin.fr>
MIME-Version: 1.0
References: <CAP1DbD7y_G+5tjUucgXE57gA-8K4vMCe5s_cVfOoEJV3CVF_RQ@mail.gmail.com>
	<504F6604.2000104@xenomai.org>
In-Reply-To: <504F6604.2000104@xenomai.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Xenomai] Children of forked process do not die upon receiving
 SIGKILL in Xenomai?
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

Le 11/09/2012 18:25, Gilles Chanteperdrix a =E9crit :
> On 09/11/2012 06:22 PM, Soo-Hyun Yoo wrote:
>> Hello,
>>
>> I have a certain process "A" that forks and execs a process "B". B
>> spawns multiple child processes.
>>
>> In the vanilla Linux kernel, I can have A send a SIGTERM or SIGKILL to
>> B and thereby successfully kill B and all of its children.
No, the childs of B remain alive. Try this code.

*test-kill.c*

#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>

int main(void)
{
     pid_t pid;

     fprintf(stderr, "[%d] I'm A\n", getpid());
     if ((pid =3D fork()) =3D=3D 0) {
         fprintf(stderr, "[%d] I'm B\n", getpid());
        if (fork() =3D=3D 0) {
             while (1) {
                 fprintf(stderr, "[%d] I'm C\n", getpid());
                 sleep(1);
             }
         } else {
             while (1) {
                 fprintf(stderr, "[%d] I'm B\n", getpid());
                 sleep(1);
             }
         }
     }
     sleep(3);
     fprintf(stderr,"A kills B\n");
     kill(pid, 9);
     fprintf(stderr, "and A exits\n");
     exit(0);
}


And you'll see :

$ ./test-kill
[15925] I'm A
[15926] I'm B
[15926] I'm B
[15927] I'm C
[15926] I'm B
[15927] I'm C
[15926] I'm B
[15927] I'm C
A kills B
and A exits
$ [15927] I'm C
[15927] I'm C
[15927] I'm C
[15927] I'm C
[15927] I'm C
[15927] I'm C
[15927] I'm C

To kill B's childs, you need to send the signal to the group of processes=
.


