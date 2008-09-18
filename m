Message-ID: <48D272B9.2080304@domain.hid>
Date: Thu, 18 Sep 2008 17:24:41 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <mailman.1448.1221743175.22433.adeos-main@gna.org>	
	<217b7eb20809180614u28d04ef8vc63fadb0b7db1ae9@domain.hid>	
	<48D255E0.7000603@domain.hid>	
	<217b7eb20809180722w423f78b2qb4d7db0bfb248953@domain.hid>	
	<48D264B6.6080504@domain.hid>	
	<217b7eb20809180807j9bf19ecnb43d69355d2e4ff6@domain.hid>	
	<48D26F8F.8030401@domain.hid>
	<217b7eb20809180817p15cb4161o8ef6482fe835f143@domain.hid>
In-Reply-To: <217b7eb20809180817p15cb4161o8ef6482fe835f143@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: Re: [Adeos-main] adeos-ipipe-2.6.19-arm-1.7-00 on iMX31: init
 doesn't complete!
List-Id: General discussion about Adeos <adeos-main.gna.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
List-Archive: </public/adeos-main>
List-Post: <mailto:adeos-main@gna.org>
List-Help: <mailto:adeos-main-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
To: Hank <hank007@domain.hid>
Cc: adeos-main@gna.org

Hank wrote:
> On 9/18/08, Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org> wrote:
>> Hank wrote:
>>> Well, some of the tricks helped during initial stages but other don't
>> seem
>>> to apply now as there is no crash here!
>> Oh yes ? Are you sure the timer is ticking correctly ?
>>
>> --
>>                                                 Gilles.
> 
> 
> Yes. Also, forced it to a soft lockup crash in ret_to_user() and trace
> showed timer interrupt ticking and updating process timers all the way up!

I am afraid I can not help much. The patch you use is too old, I fixed
some bugs recently in the traps interception code which should lead to a
clear crash instead of some lockup. I also added support for VFP.

So, do you observe the same phenomenon with a vanilla 2.6.26 and the
latest patch (AFAIK Litekit is supported by mainline) ?

I also suspect a bug when using Xenomai with NO_HZ on ARM. So, you may
try to disable NO_HZ.

-- 
                                                 Gilles.

