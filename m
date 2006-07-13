Message-ID: <e325d110607130503k37a4e648p1ae581e7b984abb4@domain.hid>
Date: Thu, 13 Jul 2006 13:03:42 +0100
From: "Kim Chuan Lim" <lim.kim.chuan@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Subject: [Xenomai-help] RT timer help
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: xenomai@xenomai.org

Hi all,

I am a bit confuse with the rt timer clock tick.
printf("rt_timer_ns2tsc(1000000000) == %lld
\n",rt_timer_ns2tsc(1000000000));//1second
rt_timer_ns2tsc(1000000000) == 1193182;

rt_task_set_periodic(NULL, TM_NOW, 1193182LLu);
while (1) {
       rt_task_wait_period(NULL);
       /* real-time jobs */
	k_time = rt_timer_read();
	printf("Hello Jan!! count_%d k_time_%llu\n",++count,k_time);
   }

The printf appear very fast rather than 1ms.

May i know i have make what mistake?

Regards,
Kim Chuan.

