Message-ID: <47CFBB2E.3010700@domain.hid>
Date: Thu, 06 Mar 2008 10:36:46 +0100
From: Laurent BESSARD <laurent.bessard@domain.hid>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="------------000808080304010704030904"
Subject: [Xenomai-help] Need help with pipes
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: xenomai@xenomai.org

This is a multi-part message in MIME format.
--------------000808080304010704030904
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: quoted-printable

Hello everybody,

I'm using Xenomai for realtime developments for a couple of time. I have=20
written a program using pipes for Xenomai 2.1.0 and a 2.6.15 Linux=20
kernel compiled with Xenomai support. All worked or seemed to work fine.

Recently, I decided to upgrade my system to Xenomai 2.4.1 and a 2.6.23=20
Linux kernel. But during my program execution, I get a kernel=20
segmentation fault while I try to delete the pipe. After having test any=20
possibility of problem while deleting pipe, I finally find that just=20
creating and then deleting a pipe causes a kernel segmentation fault.

Now I don't know where my problem is located:
   - There is something I'm doing wrong when I use pipes.
   - I have mis-installed Xenomai on my system.
   - It is a known problem with the version of Xenomai I installed.

I attached a sample of code that causes my problem.

Could anybody help me?
Thank you in advance.

Best regards,

Laurent BESSARD

--=20
LOLITech - TBI sarl
24, rue Pierre Evrat
88100 Saint-Di=E9 des Vosges
tel: 03 29 52 95 67
fax: 03 29 58 93 16
laurent.bessard@domain.hid <mailto:laurent.bessard@domain.hid>
http://www.lolitech.fr 	<http://www.lolitech.fr>


--------------000808080304010704030904
Content-Type: text/x-csrc;
 name="test_pipe.c"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="test_pipe.c"

#include <stdio.h>
#include <signal.h>
#include <sys/fcntl.h>
#include <unistd.h>
#include <sys/mman.h>

#include <native/task.h>
#include <native/timer.h>
#include <native/pipe.h>

#define PIPE_DEVICE        "/dev/rtp0"
#define PIPE_MINOR         0
#define PIPE_SIZE          500000

RT_PIPE test_pipe;

int main(int argc, char* argv[])
{
    int ret = 0;

    /* no memory-swapping for this programm */
    mlockall(MCL_CURRENT | MCL_FUTURE);

    /* create test_pipe */
    ret = rt_pipe_create(&test_pipe, "test_pipe", PIPE_MINOR, PIPE_SIZE);
    if (ret) {
        printf("failed to create test_pipe, code %d\n",ret);
        goto error;
    }
    printf("test_pipe created\n");

    /* delete test_pipe */
    ret = rt_pipe_delete(&test_pipe);
    if (ret) {
        printf("failed to delete test_pipe, code %d\n",ret);
        goto error;
    }
    printf("test_pipe deleted\n");

    pause();
    return 0;

error:
    return ret;
}


--------------000808080304010704030904--

