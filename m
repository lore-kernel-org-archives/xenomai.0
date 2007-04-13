Message-ID: <461FE560.8070100@domain.hid>
Date: Fri, 13 Apr 2007 22:17:36 +0200
From: Jean-Luc Pamart <jlpamart@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Subject: [Xenomai-help] Execution error with rtdm heartbeat example
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

Hello

I  try to execute the heartbeat example (xenomai 2.3 with kernel 2.6.19)
With the unmodified sources when the heartbeat module
is being unloaded (rmmod)  I obtain :

atkbd.c: Spurious ACK on isa0060/serio0. Some program might be trying 
access hardware directly.  

and the unloading can't be finished.

I try to slightly change the sources. It works with no bad kernel 
message and
complete unloaded with this modification :

void heartbeat(void *cookie)
{
       
        while (!end) {
              ...
        }
    set_leds(0);
    
}
void cleanup_module(void)
{
    //  set_leds(0);
}  

My interpretation :
In the non modified example, We try to access directly to the keyboard
after the end of the rt-driver(after  
rtdm_task_join_nrt(&heartbeat_task, 100);)
So it is a problem for the kernel.

Is it a good interpretation ?
 
what is the difference between rtdm_task_join_nrt(&heartbeat_task, 100) and
 rtdm_task_destroy(&heartbeat_task) ?
What is the role of the polling argument (value 100) ?


best regards

