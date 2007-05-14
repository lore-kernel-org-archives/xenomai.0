Message-ID: <464865D7.3000005@domain.hid>
Date: Mon, 14 May 2007 15:36:23 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <0B45E93C5FF65740AEAE690BF3848B7A4AB0C9@domain.hid>
In-Reply-To: <0B45E93C5FF65740AEAE690BF3848B7A4AB0C9@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] Problem with Message queue
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Fillod Stephane <stephane.fillod@domain.hid>
Cc: xenomai@xenomai.org

Fillod Stephane wrote:
> Perrine Martignoni wrote:
> [..]
> 
>>int DESTRUCT=0;
> 
>  
> I'm always nervous to see global variables shared among threads without
> a volatile keyword. An explicit memory barrier would be better, as it
> has been re-explained in a LWN article lately (wait Thursday for free access)
> http://lwn.net/Articles/233479/
> 
> But the problem in routine2 is somewhere else:
> 
> void routine2 (void * cookie){
> 	int ret; 
> 	struct sched_param param = {.sched_priority = 10 };
> 	pthread_setschedparam(pthread_self(), SCHED_FIFO, &param);
> 	for(;;){
> 		affich(2);
> 		ret = mq_send(mq2, buf2, MSG_SIZE, 0);
> 		printf("send mq2 returned %d, errno %s\n", ret, errno );
> ouch!                                           ^^          ^^^^^
> 		ret = mq_receive(mq1, buf1, MSG_SIZE, NULL );
> 		printf("receive mq1 returned %d, errno %s\n", ret, errno); 
> ouch!                                              ^^          ^^^^^
>  
> 
> This should be either
> 		printf("receive mq1 returned %d, errno %d\n", ret, errno);
> or
> 		printf("receive mq1 returned %d, errno %s\n", ret, strerror(errno));

Yes, I did not look at gcc warnings long enough. Yet another error (but
this one is arguably a bug in Xenomai posix skin) is to pass a null
pointer as last argument of mq_receive.


-- 
                                                 Gilles Chanteperdrix

