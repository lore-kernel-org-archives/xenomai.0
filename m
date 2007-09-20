Message-ID: <1ce16a2c0709201043m1a05664alf4b5ce6a5ede5a44@domain.hid>
Date: Thu, 20 Sep 2007 19:43:52 +0200
From: "Bachman Kharazmi" <bahkha@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Subject: [Xenomai-help] iterate received data from pipe
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Xenomai <xenomai@xenomai.org>

Hi,
What I try to do is to iterate through  received() data from a pipe.
and break and printout at every '\n' (dec 10)

I've tried to do an inplementation of this in my module.c, but it
doesn't really work.
I would be grateful if anyone could give me hints about what I'm
missing or where to do look for examples that show this.

here's what I'm doing in my periodic task.

while(1){
		err = rt_task_wait_period(NULL);
		if (err) {
			if (err != -ETIMEDOUT) {
				printk("rt_task_wait_period() failed: code %d\n", err);
				rt_task_suspend(NULL);
			}
			continue;
		}
		//number of bytes received
		len = rt_pipe_receive(&myPipe, &msgin, TM_INFINITE);
		printk("number of received bytes %d\n", len);
		pmyChar = P_MSGPTR(msgin);
		while(high < len){
		while(pmyChar[high]!='\n'){
		high++;
		}
		if(pmyChar[high]=='\n'){
		for(;low<high;low++){
			printk("%d",pmyChar[low]);
		}
                 printk("\n");
		high++;
		low = high;
		}
		}
		rt_pipe_free(&myPipe,msgin);
		printk("TASK3 has ran\n");
}

The output in dmesg now is:
TASK1 has ran
TASK2 has ran
number of received bytes 13
104104101104101104101104101104TASK3 has ran

So it doesn't newline after each '\n' :(


thanks
Bachman

