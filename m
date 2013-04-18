MIME-Version: 1.0
Date: Thu, 18 Apr 2013 16:48:38 +0800
Message-ID: <CAFByoKwn0==mQT_q9jnsWvbbTNNJ1cSaH0KaYN+Ryw34v-CZOQ@mail.gmail.com>
From: kidd <gong.kidd@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Subject: [Xenomai] latency test
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

Hi
    I post Adeos+xenomai to S3C6410 SOC with Linux-2.6.35.9, and the Linux
kernel and Xenomai are ok when system boot(according the printed
information when system boot)
   when I input "xeno latency", the information in screen is

   == Sampling period: 1000 us
   == Test mode: periodic user-mode task
   == All results in microseconds
   Xenomai: registered exported object dispsem-832 (semaphores)
   warming up...


Then the system is hang (ctrl + C does not work). Through print debug
information in code ,I guess the problem is in "display(in
latency.c)->rt_sem_p"

Can somebody help me to analyse the problem? Thanks
