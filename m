Message-ID: <534FBE16.7070201@xenomai.org>
Date: Thu, 17 Apr 2014 13:42:14 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <295eff24.b8f5.1456ea4352a.Coremail.ericvic@163.com>
In-Reply-To: <295eff24.b8f5.1456ea4352a.Coremail.ericvic@163.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: Re: [Xenomai] imx6q xenomai ipipe-3.0-imx6q
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: =?UTF-8?B?5bWM5YWl5byP5bel56iL5biI?= <ericvic@163.com>
Cc: huang.c.h@lynuc.cn, liu.h.f@lynuc.cn, "xenomai@xenomai.org" <xenomai@xenomai.org>

On 04/17/2014 09:43 AM, 嵌入式工程师 wrote:
> I use the  ipipe-3.0-imx6q and xenomai-2.6.3 ,my board is imx6q 800MHz . And I analog my actual application.  when I use share memery in different  rt_tasks and bind with different cpus . The latency in 1000us at beginning  it is about 14us  but  when i run more tasks it will reach 150us or higher .My tasks run more contents than the blow examples .  I do not know if some thing wrong with my task.
> 
> 
> result:
> 1task: 0.000421 ms                                                              
> pmax: 0.014372 ms                                                               
> 1task: 0.057951 ms                                                              
> 1max: 0.153273 ms   
> 
> 
> the example test.  Thank you very much

Do you observe high latencies when running the latency test with no
other real-time activity but all the non real-time activity you want?


-- 
                                                                Gilles.

