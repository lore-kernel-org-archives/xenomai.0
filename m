Message-ID: <48AC4DB5.1060305@domain.hid>
Date: Wed, 20 Aug 2008 19:00:37 +0200
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
References: <406CC9939904F143B9D42CEEA3E56E56431F57@domain.hid>
	<48AAF55E.9000206@domain.hid>
	<406CC9939904F143B9D42CEEA3E56E56431FCD@oab1mx1.oneaccess.intra>
	<48ABEF11.6060307@domain.hid>
	<406CC9939904F143B9D42CEEA3E56E56432116@domain.hid>
In-Reply-To: <406CC9939904F143B9D42CEEA3E56E56432116@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] uClinux write to pipe returning -ENOMEM
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
To: Filip Van Rillaer <Filip.VanRillaer@domain.hid>
Cc: xenomai@xenomai.org

Filip Van Rillaer wrote:
> Hello,
> 
> Thank you for your work-around.
> Though I have some problems with the implementation:
> pipe_i_handler (Xenomai side) does not know when the xnpipe_write got
> errno=ENOMEM (the pipe_i_handler is I think even not called in case
> ENOMEM is returned).

I assumed that you could anticipate the ENOMEM condition knowing the size of the
largest message that could be sent at a time, but ok.

  So there is I think with the current Xenomai
> implementation no way for the pipe_i_handler to correctly fill in the
> value of buffer_filled_up_p.  This would mean that my writer-thread
> 'userland' would have to set this 'variable'.
> Then I was thinking about moving the <<rt_sem_p(&bsync, TM_INFINITE)>>
> to the writer-thread when errno-ENOMEM is returned, but that would
> require that the writer-thread has to bind the semaphore that was
> created in another program.  This is probably possible via the Xenomai
> registry.
>

The patch below calls the monitoring handler with a new event, namely
P_EVENT_FULL, before xnpipe_write() gets -ENOMEM. You would just need to call
rt_sem_p() in that case. Fully untested.

--- include/native/pipe.h	(revision 4105)
+++ include/native/pipe.h	(working copy)
@@ -35,6 +35,7 @@
 #define P_EVENT_INPUT	1
 #define P_EVENT_OUTPUT	2
 #define P_EVENT_CLOSE	3
+#define P_EVENT_FULL	4

 typedef struct rt_pipe_placeholder {
     xnhandle_t opaque;
Index: ksrc/skins/native/pipe.c
===================================================================
--- ksrc/skins/native/pipe.c	(revision 4105)
+++ ksrc/skins/native/pipe.c	(working copy)
@@ -89,9 +89,14 @@
 static void *__pipe_alloc_handler(int bminor, size_t size, void *cookie)
 {
 	RT_PIPE *pipe = (RT_PIPE *)cookie;
+	void *buf;

 	/* Allocate memory for the incoming message. */
-	return xnheap_alloc(pipe->bufpool, size);
+	buf = xnheap_alloc(pipe->bufpool, size);
+	if (buf ==  NULL && pipe->monitor)
+		pipe->monitor(pipe, P_EVENT_FULL);
+
+	return buf;
 }

 static int __pipe_output_handler(int bminor,


> Best regards,
> Filip.
> 
> -----Original Message-----
> From: Philippe Gerum [mailto:rpm@xenomai.org] 
> Sent: 20 August 2008 12:17
> To: Filip Van Rillaer
> Cc: xenomai@xenomai.org
> Subject: Re: [Xenomai-help] uClinux write to pipe returning -ENOMEM
> 
> Filip Van Rillaer wrote:
>> Hello,
>>
>> My current test-setup is as follows:
>> 1) user-program reads test-samples from a file in non-RT and does a 
>> blocking write to the Xenomai-pipe
>> 2) a RT-program that implements a V34 modem is listening to the
> Xenomai-pipe and will send the data over a telephone line.
>> ---> so it is the intention that at startup the Xenomai-pipe buffer
> gets filled up and from than in stationary state the data should stream
> at the speed of the V34 modem connection.
> 
> A typical work-around to emulate blocking Linux -> Xenomai pipe I/O
> would be:
> 
> RT_SEM bsync;
> 
> int pipe_i_handler(RT_PIPE *pipe, int event) {
> 	if (event == P_EVENT_INPUT && buffer_filled_up_p)
> 		/* Hold userland until buffer drains. */
> 		rt_sem_p(&bsync, TM_INFINITE);
> 	...
> }
> 
> void drain_buffer(void)
> {
> 	send_v34();
> 	rt_sem_v(&bsync);
> }
> 
> void init_kernel_code(void)
> {
> 	rt_sem_create(&bsync, "bsync", 0, S_PULSE); }
> 
> ===
> 
> void userland(void)
> {
> 	/* Make this regular Linux thread a non-RT Xenomai task, so it
> may block on Xenomai synchronization objects. */
> 
> 	rt_task_shadow(NULL, __FUNCTION__, 0, 0);
> 
> 	for (;;) {
> 		/* This may hang in pipe_i_handler() due to flow
> control. */
> 		write(pipefd, buf, len);
> 		...
> 	}
> }
> 
> --
> Philippe.
> 


-- 
Philippe.

