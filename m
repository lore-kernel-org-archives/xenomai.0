Message-ID: <45C1F351.6080109@domain.hid>
Date: Thu, 01 Feb 2007 15:04:01 +0100
From: Steven Scholz <steven.scholz@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-core] rt_task_create() hangs ?
References: <45B75FFB.6030205@domain.hid> <45C1E625.1010600@domain.hid>
	<45C1EA10.9060109@domain.hid>
In-Reply-To: <45C1EA10.9060109@domain.hid>
Content-Type: multipart/mixed; boundary="------------030500050500040605000603"
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: xenomai@xenomai.org

This is a multi-part message in MIME format.
--------------030500050500040605000603
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

Hi Gilles,

>> I now tested Gille's brand new adeos-ipipe-2.6.19-arm-1.6-01.patch. The
>> above problems disapeared. I even do see a "Xenomai: POSIX: destroyed
>> thread" now.
>>
>> So is this a known bug of ipipe-1.5 vs ipipe-1.6?
>> Or does anyone remember a bug like that?
> 
> I do not think there is such a known bug. There were some recent fixes
> in the native skin, but as far as I remember they were for anonymous
> objects. In any case, as Philippe already told you, it is hard to say
> anything without seeing any code. 
Did he? I never saw that mail. :-(
However I attach the file that hangs when starting it for the second time.

PLEASE NOTE: I just found that the programm runs fine again and again even
under 2.6.14 iff I deselect CONFIG_XENO_HW_FPU. With CONFIG_XENO_HW_FPU=y it
will hang...

So I am now suspecting that it would hang with your new
adeos-ipipe-2.6.19-arm-1.6-01.patch as well...
Problem is: I can only compile your patch with FPU disabled! Otehrwise he
complains about a missing fp_init() !!!

BTW: Is CONFIG_XENO_HW_FPU intended for HW floating point support!? Or for
floating point emulation done by the kernel? NWFPE? Are there actually ARM
cpus with HW FPU?

> As for the posix skin messages about
> objects destruction, they only appear if an option is selected in the
> kernel configuration. Are you sure this option was enabled when you did
> not see the messages ?
Yes I am.

-- 
Steven

--------------030500050500040605000603
Content-Type: text/plain;
 name="threadtest1.c"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="threadtest1.c"


#include <stdio.h>
#include <signal.h>
#include <unistd.h>
#include <sys/mman.h>

#include <native/task.h>


#define STATE_TASK_1_CREATED       1
#define STATE_TASK_2_CREATED       2

unsigned int my_state = 0;

RT_TASK  task_1;
RT_TASK  task_2;

/* .................................................................................... */


void cleanup_all(void) {


  if (my_state & STATE_TASK_2_CREATED) {
    printf("delete task_2\n");
    rt_task_delete(&task_2);
    my_state &= ~STATE_TASK_2_CREATED;
  }

  if (my_state & STATE_TASK_1_CREATED) {
    printf("delete task_1\n");
    rt_task_delete(&task_1);
    my_state &= ~STATE_TASK_1_CREATED;
  }

}


/* .................................................................................... */

int main(int argc, char* argv[]) {
  int ret = 0;

  /* no memory-swapping for this programm */
  mlockall(MCL_CURRENT | MCL_FUTURE);


  /* create task_1 */
  ret = rt_task_create(&task_1,"task_1",0,50,0);
  if (ret) {
    printf("failed to create task_1, code %d\n",ret);
    goto error;
  }
  my_state |= STATE_TASK_1_CREATED;
  printf("created task_1\n");



  /* create task_2 */
  ret = rt_task_create(&task_2,"task_2",0,51,0);
  if (ret) {
    printf("failed to create task_2, code %d\n",ret);
    goto error;
  }
  my_state |= STATE_TASK_2_CREATED;
  printf("created task_2\n");

error:
  cleanup_all();
  return ret;
}



--------------030500050500040605000603--

