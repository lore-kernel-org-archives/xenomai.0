Date: Tue, 12 Apr 2011 15:14:53 +0200 (CEST)
From: Mauro Salvini <mauro.salvini@domain.hid>
Message-ID: <537545.221302614089218.JavaMail.SYSTEM@pc-msalvini>
In-Reply-To: <18922906.201302613837843.JavaMail.SYSTEM@pc-msalvini>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Subject: [Xenomai-help] rt_task_join() small issue on not-joinable task
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: xenomai@xenomai.org

Hi to all, 

I'm running Xenomai 2.5.5.2 IPipe 2.7-04 on kernel 2.6.35.7-x86. 

I have a main real time task that creates a thread: this thread calls rt_task_shadow() to turns itself into real-time task 
I discovered this: if I exit from this task and then call rt_task_join() on it from main task, rt_task_join() returns 0 instead -EINVAL as expected (T_JOINABLE flag does not exist for rt_task_shadow() function). Is it correct a behavior? 

Here a simple code to explain it: 

RT_TASK taskHandler; 
pthread_t threadHandler; 
char bContinue; 

void task1 (void *arg) 
{ 
   while( bContinue ) 
   { 
      rt_printf("running\n"); 
      rt_task_sleep(500000000); 
   } 
   rt_printf("exit\n"); 
} 

void * thread1 (void *arg) 
{ 
   int ret=0; 
   rt_printf("shadow:%d\n",(ret=rt_task_shadow(&taskHandler,"Task1",50,0))); 
   if(ret==0) 
      task1(NULL); 
   return NULL; 
} 

int main (int argc, char** argv) 
{ 
   mlockall ( MCL_CURRENT | MCL_FUTURE ); 
   rt_print_auto_init(1); 

   rt_task_shadow(NULL,"Maintask",70,T_JOINABLE); 

   bContinue=1; 
   rt_printf("thread create:%d\n",pthread_create ( &threadHandler , NULL , thread1 , NULL )); 
   rt_task_sleep(2000000000ULL); 
   bContinue=0; 
   rt_printf("join:%d\n",rt_task_join(&taskHandler)); 

   return 0; 
} 

Output is: 

thread create:0 
shadow:0 
running 
running 
running 
running 
exit 
join:0 

I know that rt_task_shadow() wasn't made to create new tasks, it wants to be an example code only. 

Regards 

Mauro 

PS: I discovered this behavior because if I redo immediately pthread_create() call after rt_task_join(), rt_task_shadow() returns -EEXIST (peraphs only if main task has bigger priority than created task: if it has equal or smaller priority, rt_task_shadow() call works fine. But this is another affair). 


