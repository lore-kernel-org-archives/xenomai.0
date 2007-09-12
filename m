Message-ID: <1ce16a2c0709121230n19192fd5yc0c0ceba5880faf9@domain.hid>
Date: Wed, 12 Sep 2007 21:30:28 +0200
From: "Bachman Kharazmi" <bahkha@domain.hid>
In-Reply-To: <2ff1a98a0709120943y366f22f2g157bd2d7e18e035c@domain.hid>
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
	<1ce16a2c0709120922t50ead4ep695f2bf1b061c57c@domain.hid>
	<2ff1a98a0709120933t43a8636g32b61652aea163b1@domain.hid>
	<2ff1a98a0709120943y366f22f2g157bd2d7e18e035c@domain.hid>
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
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: xenomai@xenomai.org, Jan Kiszka <jan.kiszka@domain.hid>

Sorry I didn't paste my code, http://pastebin.ca/694397
The output from it is:
sandbox:/home/bkw/code/driver# ./simpledriver
0
test1

And then it exits, no test2 printed at all.. :/
And nothing in the while loop seem to write to the serialport as I expected.

what am I doing wrong?
/Bachman
On 12/09/2007, Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org> wrote:
> On 9/12/07, Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org> wrote:
> > On 9/12/07, Bachman Kharazmi <bahkha@domain.hid> wrote:
> > > another example which confuse me:
> > > ##
> > > void write_task_proc(void *arg){
> > >         int err;
> > >         RTIME write_time;
> > >         ssize_t sz = sizeof(RTIME);
> > >         ssize_t written = 0;
> > >         err = rt_task_set_periodic(NULL,
> > > TM_NOW,rt_timer_ns2ticks(write_task_period_ns));
> >
> > How much is writ_task_period_ns ? If it is 10000000011, then you
> > should wait around 10 s before "test2" is displayed.
>
> Sorry, I confused 1 with l.
> --
>                                                Gilles Chanteperdrix
>

