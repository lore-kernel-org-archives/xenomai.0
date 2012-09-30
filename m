MIME-Version: 1.0
In-Reply-To: <5066E73D.6010704@xenomai.org>
References: <CAKKWdtdinbdLC7uBFu9Yyq6aWvJOQj5HEOKEd+pyAPObQ_ZH1g@mail.gmail.com>
	<5066E73D.6010704@xenomai.org>
Date: Sun, 30 Sep 2012 13:30:12 +0330
Message-ID: <CAKKWdtckyrV=FCM6-ru=WqMXL0zkUCPBA=Dsbn6qYw0N7LvmEg@mail.gmail.com>
From: ali hagigat <hagigatali@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Subject: Re: [Xenomai] question about latency
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>, xenomai@xenomai.org

Xenomai does not add gatekeeper threads?

On Sat, Sep 29, 2012 at 3:49 PM, Gilles Chanteperdrix
<gilles.chanteperdrix@xenomai.org> wrote:
> On 09/29/2012 02:13 PM, ali hagigat wrote:
>
>> What is "-D" option in latency test?
>
>
> int benchdev_no = 0;
>
> (...)
>
>         while ((c = getopt(argc, argv, "g:hp:l:T:qH:B:sD:t:fc:P:b")) != EOF)
>                 switch (c) {
> (...)
>                 case 'D':
>
>                         benchdev_no = atoi(optarg);
>                         break;
> (...)
>         if (test_mode != USER_TASK) {
>                 char devname[RTDM_MAX_DEVNAME_LEN];
>
>                 snprintf(devname, RTDM_MAX_DEVNAME_LEN, "rttest-timerbench%d",
>                          benchdev_no);
>                 benchdev = rt_dev_open(devname, O_RDWR);
>
>                 if (benchdev < 0) {
>                         fprintf(stderr,
>                                 "latency: failed to open benchmark device, code %d\n"
>                                 "(modprobe xeno_timerbench?)\n", benchdev);
>                         return 0;
>                 }
>         }
>
>> is Gatekeeper() a Xenomai task or a linux task?
>
> Neither, it is probably a task from your application.
>
> --
>                                                                 Gilles.

