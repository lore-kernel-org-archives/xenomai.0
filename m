Message-ID: <1ce16a2c0709120922t50ead4ep695f2bf1b061c57c@domain.hid>
Date: Wed, 12 Sep 2007 18:22:09 +0200
From: "Bachman Kharazmi" <bahkha@domain.hid>
In-Reply-To: <1ce16a2c0709120702m1d4cc503vb045f3d2e0814d67@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <1ce16a2c0709100614u3f23fce9yd2be767406fa536a@domain.hid>
	<46E58BE4.9090109@domain.hid>
	<1ce16a2c0709101142r6cf2d624oe443807575eadcfa@domain.hid>
	<46E59235.2060506@domain.hid>
	<1ce16a2c0709110837r52eedac7vcc970d5c3b4e2d53@domain.hid>
	<46E6F290.9090901@domain.hid>
	<1ce16a2c0709120702m1d4cc503vb045f3d2e0814d67@domain.hid>
Subject: Re: [Xenomai-help] adding PCI support to 16550A.c
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Jan Kiszka <jan.kiszka@domain.hid>
Cc: xenomai@xenomai.org

another example which confuse me:
##
void write_task_proc(void *arg){
	int err;
	RTIME write_time;
	ssize_t sz = sizeof(RTIME);
	ssize_t written = 0;
	err = rt_task_set_periodic(NULL,
TM_NOW,rt_timer_ns2ticks(write_task_period_ns));
	printf("%d\n",err);
if (err) {
		printf(WTASK_PREFIX "error on set periodic, %s\n",
			strerror(-err));
	}
	while (1) {
		printf("test1\n");
		err = rt_task_wait_period(NULL);
		printf("%d\n",err);
		printf("test2\n");
		if (err) {
			printf(WTASK_PREFIX "error on rt_task_wait_period, %s\n", strerror(-err));
			break;
		}
....
##
the code does compile, test1 is printed but neither err or test2.
so what makes my code stoping executing there?
The documentation sais "If NULL, this count will never be copied
back." about the argument, but exactlly what does that mean?

Why does the work in other code examples I have?

/Bachman
On 12/09/2007, Bachman Kharazmi <bahkha@domain.hid> wrote:
> > You can copy this code almost unmodified into an application and compile
> > it against the Xenomai POSIX skin. The serial port configuration apart
> > (same under Linux, though), it will open "rtser<whatever>", even if
> > given like "/dev/rtser...", and work on that port as if it where a Linux
> > one. Life can be simple, sometimes.
>
> Simple? ;)
> I've tried to write a c-program which basiclly should open the device
> rtser0 and write 100x to it and then close.
>
> The simple program can be found here: http://pastebin.ca/693873
>
> I've connected the serial cable to a reading terminal, but there's no
> data at all, when I run the binary. :/
>
> /Bachman
>

