Message-ID: <1ce16a2c0709131222g3acfb8a8y2c48ce4eee964903@domain.hid>
Date: Thu, 13 Sep 2007 21:22:45 +0200
From: "Bachman Kharazmi" <bahkha@domain.hid>
In-Reply-To: <2ff1a98a0709131016o4fbf1e99l9e3024b622ec63e7@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <1ce16a2c0709131003t673986c5v417ddce15dd29de6@domain.hid>
	<2ff1a98a0709131016o4fbf1e99l9e3024b622ec63e7@domain.hid>
Subject: Re: [Xenomai-help] seperate native write task
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: xenomai@xenomai.org

rt_task_shadow() commented out.
fd only declared in the header.. so it should be the same everywhere.

Still all output is written to terminal and nothing over rtser0 (my
serial port).
My updated version: http://pastebin.ca/696180

/Bachman

On 13/09/2007, Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org> wrote:
> On 9/13/07, Bachman Kharazmi <bahkha@domain.hid> wrote:
> > void myWriteTask(void *arg){
> >         char* myString = "hej\n";
> >         int fd,err,counter;
> >         counter=0;
> >         RTIME write_time;
> >         ssize_t sz = sizeof(RTIME);
> >         ssize_t written = 0;
> >         //create rt device
> >         fd = rt_dev_open(WRITE_FILE, 0);
> >         if (fd < 0) {
> >                 perror("open(WRITE_FILE)");
> >                 exit(EXIT_FAILURE);
> >         }
> >
> >         //setup config
> >         err = rt_dev_ioctl(fd, RTSER_RTIOC_SET_CONFIG, &write_config);
> >         if (err) {
> >                 printf(MAIN_PREFIX "error while RTSER_RTIOC_SET_CONFIG, %s\n",
> > strerror(-err));
> >         }
> >         rt_task_shadow(&write_task, NULL, 50, 0);
>
> This is useless, a task created with rt_task_create is already a real-time task.
>
> >         err = rt_task_set_periodic(NULL,
> > TM_NOW,rt_timer_ns2ticks(write_task_period_ns));
> >         if (err) {
> >         printf(WTASK_PREFIX "error on set periodic, %s\n", strerror(-err));
> >                 }
> > while(counter<100){
> >         err=write(fd, myString, strlen(myString));
>
> This is no good, a file descriptor returned by rt_dev_open should be
> used with rt_dev_write. If you want to use write, you should use open
> and ioctl, and not forget to compile with the flags returned by
> xeno-config --posix-cflags and xeno-config --posix-ldflags.
>
> --
>                                                Gilles Chanteperdrix
>

