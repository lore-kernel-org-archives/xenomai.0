Message-ID: <5066E73D.6010704@xenomai.org>
Date: Sat, 29 Sep 2012 14:19:09 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <CAKKWdtdinbdLC7uBFu9Yyq6aWvJOQj5HEOKEd+pyAPObQ_ZH1g@mail.gmail.com>
In-Reply-To: <CAKKWdtdinbdLC7uBFu9Yyq6aWvJOQj5HEOKEd+pyAPObQ_ZH1g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] question about latency
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: ali hagigat <hagigatali@gmail.com>
Cc: xenomai@xenomai.org

On 09/29/2012 02:13 PM, ali hagigat wrote:

> What is "-D" option in latency test?


int benchdev_no = 0;

(...)

        while ((c = getopt(argc, argv, "g:hp:l:T:qH:B:sD:t:fc:P:b")) != EOF)
                switch (c) {
(...)
                case 'D':                                                        
                                                                                 
                        benchdev_no = atoi(optarg);                              
                        break;                                                   
(...)
        if (test_mode != USER_TASK) {
                char devname[RTDM_MAX_DEVNAME_LEN];

                snprintf(devname, RTDM_MAX_DEVNAME_LEN, "rttest-timerbench%d",
                         benchdev_no);
                benchdev = rt_dev_open(devname, O_RDWR);

                if (benchdev < 0) {
                        fprintf(stderr,
                                "latency: failed to open benchmark device, code %d\n"
                                "(modprobe xeno_timerbench?)\n", benchdev);
                        return 0;
                }
        }

> is Gatekeeper() a Xenomai task or a linux task?

Neither, it is probably a task from your application.

-- 
                                                                Gilles.

