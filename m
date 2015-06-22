Message-ID: <5587C449.7030109@rts.uni-hannover.de>
Date: Mon, 22 Jun 2015 10:16:09 +0200
From: Jan Carstensen <carstensen@rts.uni-hannover.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Subject: [Xenomai] rt_task_shadow - Switches
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Xenomai <xenomai@xenomai.org>

Hi All,

i am currently working to get the ach ipc library up and running, after 
a lot of debugging i got a sample running, but after switching from 
rt_task_create to rt_task_shadow i am getting tones of mode-switches 
which i cannot locate.

I am using Ubuntu 14.04 with a 3.16.7 and xenomai 2.6.4

The test program i am using:

________________________________________________________________________

#include "std_msgs/UInt32.h"
#include "Ach.hpp"
#include "ach.h"
#include <sys/mman.h>

#include "rtdk.h"
#include "native/task.h"
#include "native/timer.h"

#include "std_msgs/Time.h"

using namespace std;

RT_TASK demo_task;

void demo(void *arg){

     ach_channel_t publish_channel;
     std::string topic = "rt_test";

     int r = ach_create( topic.c_str() , 0, 0, NULL);
     assert( ACH_OK == r || ACH_EEXIST == r );

     int rs = ach_open(&publish_channel, topic.c_str() , NULL);
     assert( ACH_OK == rs );

     std_msgs::Time ros_msg;
     double  period = 1000000000llu / 1;
     rt_task_set_periodic(NULL, TM_NOW, period);

     while(1) {
          RTIME now = rt_timer_read();

          ros::Time rosTime;
          rosTime.fromNSec(now);

          rt_printf("%f \n", rosTime.toSec());

          ros_msg.data = rosTime;

          ach_put(&publish_channel,  &ros_msg, sizeof(ros_msg) );

          rt_task_wait_period(NULL);

     }


	rt_printf("stoped task\n");
}



int main(int argc, char* argv[]){

   rt_print_auto_init(1);

   mlockall(MCL_CURRENT|MCL_FUTURE);

   rt_task_create(&demo_task, "rts_put_ach", 0, 51, T_JOINABLE);
   rt_task_start(&demo_task, &demo, 0);

   rt_task_join (&demo_task);

//  RT_TASK main_shadow_task;
//  int ret = rt_task_shadow(NULL, "rts_put_ach", 51, T_FPU);
//  void* vpoint;
//  demo(&vpoint);

}

___________________________________________________________________________



when i use rt_task_create (as currently commented in):


CPU  PID    MSW        CSW        PF    STAT       %CPU  NAME
   0  0      0          225982254  0     00500080  100.0  ROOT/0
   1  0      0          2113       0     00500080  100.0  ROOT/1
   2  0      0          2109       0     00500080  100.0  ROOT/2
   3  0      0          2109       0     00500080  100.0  ROOT/3
   0  10278  1          1          0     00b00380    0.0  talker_rts_ach
   0  10287  1          8          0     00340184    0.0  rts_put_ach
   1  0      0          1419312    0     00000000    0.0  IRQ16641:[timer]
   2  0      0          1419317    0     00000000    0.0  IRQ16641: [timer]
   3  0      0          1419302    0     00000000    0.0  IRQ16641: [timer]


when i use rt_task_shadow:

CPU  PID    MSW        CSW        PF    STAT       %CPU  NAME
   0  0      0          226711353  0     00500080   83.9  ROOT/0
   1  0      0          2113       0     00500080  100.0  ROOT/1
   2  0      0          2109       0     00500080  100.0  ROOT/2
   3  0      0          2109       0     00500080  100.0  ROOT/3
   0  10446  729096     729096     0     00b40188   15.5  talker_rts_ach
   1  0      0          1508065    0     00000000    0.0  IRQ16641: [timer]
   2  0      0          1508070    0     00000000    0.0  IRQ16641: [timer]
   3  0      0          1508056    0     00000000    0.0  IRQ16641: [timer]


i am grateful for any advice you may have.

Regards,
Jan Carstensen

