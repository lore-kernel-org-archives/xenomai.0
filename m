Message-ID: <516FDC3C.70503@xenomai.org>
Date: Thu, 18 Apr 2013 13:42:52 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <CAFByoKwn0==mQT_q9jnsWvbbTNNJ1cSaH0KaYN+Ryw34v-CZOQ@mail.gmail.com>
In-Reply-To: <CAFByoKwn0==mQT_q9jnsWvbbTNNJ1cSaH0KaYN+Ryw34v-CZOQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] latency test
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: kidd <gong.kidd@gmail.com>
Cc: xenomai@xenomai.org

On 04/18/2013 10:48 AM, kidd wrote:

> Hi
>     I post Adeos+xenomai to S3C6410 SOC with Linux-2.6.35.9, and the Linux
> kernel and Xenomai are ok when system boot(according the printed
> information when system boot)
>    when I input "xeno latency", the information in screen is
> 
>    == Sampling period: 1000 us
>    == Test mode: periodic user-mode task
>    == All results in microseconds
>    Xenomai: registered exported object dispsem-832 (semaphores)
>    warming up...
> 
> 
> Then the system is hang (ctrl + C does not work). Through print debug
> information in code ,I guess the problem is in "display(in
> latency.c)->rt_sem_p"
> 
> Can somebody help me to analyse the problem? Thanks


If you are porting xenomai to S3C6410, you should have a look at the
I-pipe porting guide:
http://xenomai.org/index.php/I-pipe-core:ArmPorting

the fact that the display task waits for the semaphore is probably not
the problem at all.

-- 
                                                                Gilles.

