Subject: Re: [Xenomai-help] Problem with rt_queue
From: Philippe Gerum <rpm@xenomai.org>
In-Reply-To: <20061016153937.54204.qmail@domain.hid>
References: <20061016153937.54204.qmail@domain.hid>
Content-Type: text/plain
Date: Mon, 16 Oct 2006 17:58:14 +0200
Message-Id: <1161014295.5131.13.camel@domain.hid>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
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
To: mani bhatti <imranbashirbhatti@domain.hid>
Cc: xenomai@xenomai.org

On Mon, 2006-10-16 at 08:39 -0700, mani bhatti wrote:
> Hi all
> I am trying to broadcast a message to a queue  from a producer by
> using function 
> 
> rt_queue_send(&queue_input, msg,sizeof(TInputData), Q_BROADCAST);
> 
> I have two consumers waiting for the data from producer but the
> problem is producer is not broadcasting actually to all consumers and
> at one time if i run both consumers than only one of the consumer
> receives the data from producer the other consumer receives nothing
> and remains blank (the consumer which receives data from queue  is not
> fixed it is arbitrary).If some one has encountered the problem before
> please advice me in this regard-Thanks all.The producer code is given
> below

Excerpt from the documentation:

 * - Q_BROADCAST causes the message to be sent to all tasks currently
 * waiting for messages. [...]

Are both consumers actually aslept on the queue, waiting for a message?
If so, then please send a compilable testcase that reproduces the issue,
with the consumer part, too.
 
> 
>  while(!end){
>                rt_task_wait_period();
>                void *msg = rt_queue_alloc(&queue_input,
> sizeof(TInputData));
>                 if(msg == NULL) {
>                         printf("rt_queue_alloc(queue_inout, %d) failed
> \n",sizeof(TInputData));
>                      }
>                 memcpy(msg, &sendData, sizeof(TInputData));
>                 int bytesSent =
> rt_queue_send(&queue_input,msg,sizeof(TInputData), Q_BROADCAST);
>                 if (bytesSent <= 0) {
>                         printf("rt_queue_send(queue_input) failed: %d
> \n", bytesSent);
>                         rt_queue_free(&queue_input, msg);
>                 }
>                 sendData.counter++;
>         }
> 
> 
> 
> 
> 
> ______________________________________________________________________
> Do you Yahoo!?
> Get on board. You're invited to try the new Yahoo! Mail.
> _______________________________________________
> Xenomai-help mailing list
> Xenomai-help@domain.hid
> https://mail.gna.org/listinfo/xenomai-help
-- 
Philippe.



