Message-ID: <51A9C9EF.2040702@xenomai.org>
Date: Sat, 01 Jun 2013 12:16:15 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <4cacd80b.2131b.13ef60cf09e.Coremail.ericvic@163.com>
	<51A79898.50805@xenomai.org>
	<34806652.2924.13ef838eb26.Coremail.ericvic@163.com>
	<4855a071.2a22.13ef83b0d46.Coremail.ericvic@163.com>
	<51A835DE.5020409@xenomai.org>
	<700980f4.7d37.13ef927183f.Coremail.ericvic@163.com>
	<27b32d48.5247.13efee65625.Coremail.ericvic@163.com>
In-Reply-To: <27b32d48.5247.13efee65625.Coremail.ericvic@163.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: Re: [Xenomai] freescale(imx53)  with xenomai patch
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: =?UTF-8?B?5bWM5YWl5byP5bel56iL5biI?= <ericvic@163.com>
Cc: xenomai@xenomai.org

On 06/01/2013 10:41 AM, 嵌入式工程师 wrote:

> I have try the kernal-3.4.6 with ipipe-core-3.4.6-arm-4.patch 
> when I set three same Priority tasks I found untill the tasks stop ,the interrut founction will not run.
> It same like before version kernal-2.6.35.9 with  ipipe-core-2.6.35.9-arm-4.patch
> 
> 
> static int test_thread(void *data)
> {
> 	//phase=ctrl_mnm1221_m();
> 	while(1)
> 	{
> 	if(flag)
> 	{
> 		printk("runting %lld\n",tt3);
> 		flag=0;
> 		}
> 	SLEEP_MILLI_SEC(50);
> 
> 	}
> 	return 0;
> }
> 
> int irq_handle_function(int irq, void *device_id)
> {
> 	//if(phase==PH_RUNNING)
> 	//ctrl_mnm1221_m();
> 	rt_intr_disable(&amp;intr_desc);
> 	tt1=rt_timer_read();
> 	tt3=tt1-tt2;
> 	if(tt3&gt;300000)
> 	flag=1;
> 	tt2=tt1;
> 	rt_intr_enable(&amp;intr_desc);
> 	return RT_INTR_HANDLED;;
> }


Why do you disable/enable the irq during the irq handler?


-- 
                                                                Gilles.

