Message-ID: <4818BEE0.7060509@domain.hid>
Date: Wed, 30 Apr 2008 20:48:00 +0200
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
References: <51B669A8A7D2914E9AB2B3F40AC6553E646F13@domain.hid>		<51B669A8A7D2914E9AB2B3F40AC6553E646F52@domain.hid>		<18454.9396.476627.446653@domain.hid>		<51B669A8A7D2914E9AB2B3F40AC6553E646F54@domain.hid>		<48162C69.6040101@domain.hid>		<18454.12323.344999.258031@domain.hid>		<51B669A8A7D2914E9AB2B3F40AC6553E646F55@domain.hid>		<48163EE7.5000604@domain.hid>		<18454.17297.451664.334250@domain.hid>		<48164652.5090102@domain.hid>	<2ff1a98a0804290252j1c9dc444kffb345ebaeb123d@domain.hid>	<48187366.2060006@domain.hid>
	<51B669A8A7D2914E9AB2B3F40AC6553E646F5C@afsexc01.aurora.aero>
	<4818BB0B.6020008@domain.hid>
	<51B669A8A7D2914E9AB2B3F40AC6553E646F5E@afsexc01.aurora.aero>
In-Reply-To: <51B669A8A7D2914E9AB2B3F40AC6553E646F5E@afsexc01.aurora.aero>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: Philippe Gerum <philippe.gerum@domain.hid>
Subject: Re: [Xenomai-help] Segfault Problems with Message Queues
Reply-To: rpm@xenomai.org
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: "Karch, Joshua" <jkarch@domain.hid>
Cc: xenomai@xenomai.org

Karch, Joshua wrote:
> Phillipe,
> 
> I'm running 2.4.3 and compiling it on the same machine (a geode based machine).  Appending exit(99); to the next line after printf() allows the program to exit with just the "error" from printf().  No seg faults there, but it seems the rt_queue_alloc is the problem right now.
>

You may want to pass the error code to fail() and print it out. The problem is
that you ask rt_queue_alloc() to get a block from a non-existent queue, because
the queue descriptor is invalid for the main() task. You have to call
rt_queue_create() first.

> Thank you,
> 
> Joshua Karch
> 
> -----Original Message-----
> From: Philippe Gerum on behalf of Philippe Gerum
> Sent: Wed 4/30/2008 2:31 PM
> To: Karch, Joshua
> Cc: xenomai@xenomai.org
> Subject: Re: [Xenomai-help] Segfault Problems with Message Queues
>  
> Karch, Joshua wrote:
>> Hi All,
>>
>> I tried implementing inter-task message queues and following the
>> msg_queue.c example
>> (http://www.xenomai.org/documentation/trunk/html/api/msg__queue_8c-example.html)
>> and when I try to run the implementation after fixing some of the code
>> (declaring fail() to printf an error, declaring int err, and changing
>> &task_body to &consumer), I get the following error
>> msg_queue[3897]: segfault at 00000000 eip b7cf8933 esp bf8dce04 error
>> 6.  This comes out of the rt_queue_alloc function.
>>
>> Has the implementation of message passing between userspace tasks
>> changed?  Is there a more recent example?  My end goal is to send non
>> blocking messages from one producer task at 50Hz to two reading tasks
>> tasks with similar (though not exactly same) loop rates-- i.e. None of
>> the tasks are synchronized, though they all run at about 50Hz.  Should I
>> use message queues to do this?
>>
>> Thank you,
>>
>> Joshua Karch
>>
>> Attached is the code I used..
>>
>> #include <sys/mman.h>
>> #include <stdio.h>
>> #include <string.h>
>> #include <native/task.h>
>> #include <native/queue.h>
>>
>> #define TASK_PRIO  99 /* Highest RT priority */
>> #define TASK_MODE  0  /* No flags */
>> #define TASK_STKSZ 0  /* Stack size (use default one) */
>>
>> RT_QUEUE q_desc;
>>
>> RT_TASK task_desc;
>>
> 
> We need to know whether an error actually occurred. Nothing guarantees us that
> all stdio buffers would be flushed upon SEGV. Does the executable still behave
> the same way with that patch?
> 
>> void fail()
>> {
>>         printf("error\n");
> 
> +	exit(99);
>> }
>>
>>
>> void consumer (void *cookie)
>>
>> {
>>     ssize_t len;
>>     void *msg;
>>     int err;
>>
>>     /* Bind to a queue which has been created elsewhere, either in
>>        kernel or user-space. The call will block us until such queue
>>        is created with the expected name. The queue should have been
>>        created with the Q_SHARED mode set, which is implicit when
>>        creation takes place in user-space. */
>>
>>     err = rt_queue_bind(&q_desc,"SomeQueueName",TM_INFINITE);
>>
>>     if (err)
>>         fail();
>>
>>     /* Collect each message sent to the queue by the queuer() routine,
>>        until the queue is eventually removed from the system by a call
>>        to rt_queue_delete(). */
>>
>>     while ((len = rt_queue_receive(&q_desc,&msg,TM_INFINITE)) > 0)
>>         {
>>         printf("received message> len=%d bytes, ptr=%p, s=%s\n",
>>                len,msg,(const char *)msg);
>>         rt_queue_free(&q_desc,msg);
>>         }
>>
>>     /* We need to unbind explicitly from the queue in order to
>>        properly release the underlying memory mapping. Exiting the
>>        process unbinds all mappings automatically. */
>>
>>     rt_queue_unbind(&q_desc);
>>
>>     if (len != -EIDRM)
>>         /* We received some unexpected error notification. */
>>         fail();
>>
>>     /* ... */
>> }
>>
>>
>> int main (int argc, char *argv[])
>>
>> {
>>     static char *messages[] = { "hello", "world", NULL };
>>     int n, len;
>>     void *msg;
>>     int err;
>>
>>     mlockall(MCL_CURRENT|MCL_FUTURE);
>>
>>     err = rt_task_create(&task_desc,
>>                          "MyTaskName",
>>                          TASK_STKSZ,
>>                          TASK_PRIO,
>>                          TASK_MODE);
>>     if (!err)
>>         rt_task_start(&task_desc,&consumer,NULL);
>>
>>     /* ... */
>>
>>     for (n = 0; messages[n] != NULL; n++)
>>         {
>>         len = strlen(messages[n]) + 1;
>>         /* Get a message block of the right size. */
>>         msg = rt_queue_alloc(&q_desc,len);
>>
>>         if (!msg)
>>             /* No memory available. */
>>             fail();
>>
>>         strcpy((char *)msg,messages[n]);
>>         rt_queue_send(&q_desc,msg,len,Q_NORMAL);
>>         }
>>
>>     rt_task_delete(&task_desc);
>> }
>>
>>
>> ------------------------------------------------------------------------
>>
>> _______________________________________________
>> Xenomai-help mailing list
>> Xenomai-help@domain.hid
>> https://mail.gna.org/listinfo/xenomai-help
> 
> 


-- 
Philippe.

