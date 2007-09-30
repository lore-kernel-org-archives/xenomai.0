Message-ID: <1ce16a2c0709300923g339c6760hecd76a78a2c6424e@domain.hid>
Date: Sun, 30 Sep 2007 18:23:28 +0200
From: "Bachman Kharazmi" <bahkha@domain.hid>
In-Reply-To: <46FFC5FE.5080406@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <1ce16a2c0709261252o67cebde3q8cf03a0d21a27288@domain.hid>
	<46FFC5FE.5080406@domain.hid>
Subject: Re: [Xenomai-help] rtdm driver development
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
Cc: Xenomai <xenomai@xenomai.org>

I've _solved_ my problem since a few days.
My code is available here: http://bachman.tor.lindesign.se/mthesis/code/comm/
What it does is that it makes it possible to write to a rtp0 device
file which then handles the periodic push and write to a rtser0.

Questions which still remain.
-Are there any problems setting a high value for the pipe task?
#define TASK_STKSZ_PIPETASK  50000

I use it when creating the task:
rt_task_create(&task3,"kernel_task3",TASK_STKSZ_PIPETASK,TASK_PRIO_PIPETASK,TASK_MODE);
Is it the size of data that the pipe can handle before it gets filled?

-Can I write data to the pipe( /dev/rtp0 ) using the outputstream from
java without any delays? In the example testa.java I do that, but I'm
working on getting that working from a data-generating thread. so that
there will be a continues quick write to the device.

-When is a outputstream.flush() needed? Is that after every single
command or just once at the end when all write():s are done?

/Bachman

On 30/09/2007, Jan Kiszka <jan.kiszka@domain.hid> wrote:
> Bachman Kharazmi wrote:
> > Hi
> > I've implemented a ringbuffer which will buffer strings between a
> > pipe-read-task=>[buffer]=>rtdm-rtserial-writetask
> >
> > The buffer has been implemented in userland and it works.
> > But in kernelspace (everything in a loaded in a kernel-module) things
> > doesn't work. It's the put(token) which doesn't work.
> > The function is put(char* c){ ... }
> >
> > I've heard that there's an address difference. But how do I handle that?
> >
> > http://www.xenomai.org/documentation/trunk/html/api/group__util.html#g9ce418051ccb7dd2366128efb8674262
> > is rtdm_strncpy_from_user() something I should use?
> >
> > exactlly what is: rtdm_user_info_t *  else than a pointer?
> > Where do I declare it? There's no clickable link in the api for that that type..
> >
> > The description sais: "User information pointer as passed to the
> > invoked device operation handler"
> > ...
>
> Please have a look at xenomai/examples/rtdm/driver-api. Those tutorial
> may give you some ideas. Feel free to suggest better descriptions of
> that field above.
>
> Jan
>
>
>

