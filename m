Message-ID: <4DB4DA61.9070906@domain.hid>
Date: Sun, 24 Apr 2011 22:20:17 -0400
From: Simon Leonard <sleonard@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Subject: [Xenomai-help] Calling rt_task_shadow from a POSIX thread with
	--enable-dlopen-skins
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

I have code based on the POSIX skin. For a (python related) reason, I 
had to re-compile Xenomai with --enable-dlopen-skins. The result is that 
unless I call rt_task_shadow, my threads don't work like they used to.

Although I *think* my code works by mixing rt_task_shadow with the POSIX 
skin I'm not convinced that it is legit. Can anybody advise?

Essentially, I need a CAN object that is instantiated and configured 
from main(). Then that object (pointer) is passed to a thread that 
Read/Write from/to it. Here a simplified version.

A few questions:
1) Can I mix rt_task_shadow from a thread created from POSIX skin?
2) If yes, is there limitations to POSIX function? For example, are the 
attributes of any pthread_attr_t discarded after calling rt_task_shadow?
4) How about a thread that doesn't use RTDM? Will it have "RT" latencies 
or rt_task_shadow must be called for that too?
4) Is it just better to port everything to native skin?

class CANdevice{

   RT_TASK task; // Added this for calling rt_task_shadow

public:

   CANdevice(){
     // add this block to Read/Write from main()
     if( rt_task_self() == NULL )
       { rt_task_shadow( &task, "can", prio, flags); }
   }

   void Configure(){ /* Read()/Write() */ }
   void Read() { /* rt_dev_recv  */
   void Write(){ /* rt_dev_send */

};

void* thread( void* argv ){

   CANdevice* can = (CANdevice*)argv;

   /* add this block to Read/Write from thread(void*) */
   RT_TASK task;
   if( rt_task_self() == NULL ){
     printf( "NOT A XENOMAI TASK\n" );
     rt_task_shadow(&task, "thread", prio, flags );
   }

   pthread_make_periodic_np ( pthread_self(), &starttp, &periodtp );

   while(1){
     can->Read();
     can->Write();
     pthread_wait_np(&overruns_r);
   }

   return NULL;
}

int main(){
   CANdevice can;
   can.Configure(); // main() must be Xenomai task to use RTDM

   pthread_t tid;
   pthread_attr_t attr;
   struct sched_param param;
   param.sched_priority = prio;

   // attributes
   pthread_attr_init( &attr );
   pthread_attr_setschedpolicy( &attr, SCHED_FIFO );
   pthread_attr_setschedparam( &attr, &param );

   // thread must be Xenomai task to use RTDM
   pthread_create( &tid, &attr, thread, (void*)&can );

}

/sl

