Message-ID: <5085B6BC.8060906@xenomai.org>
Date: Mon, 22 Oct 2012 23:12:28 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <1349212116.21898.108.camel@ENG-09-LX.emacinc.com>	
	<506B5D6B.80005@xenomai.org> <506B5E0E.5050900@xenomai.org>	
	<1349369822.3775.107.camel@ENG-09-LX.emacinc.com>	
	<506DC2DA.5000105@xenomai.org> <506E9510.7090105@xenomai.org>	
	<1349462858.26881.43.camel@ENG-09-LX.emacinc.com>	
	<506F402A.9030102@xenomai.org>	
	<1349473634.26881.221.camel@ENG-09-LX.emacinc.com>	
	<506F6283.2040901@xenomai.org>	
	<5afa3b9a7c7daf116f8284b4f255227e.squirrel@mail.emacinc.com>	
	<506FFDDC.60104@xenomai.org>	
	<1349816136.25350.426.camel@ENG-09-LX.emacinc.com>	
	<50749349.5070900@xenomai.org>	
	<1350681759.1282.88.camel@ENG-09-LX.emacinc.com>	
	<5081FF74.4010109@xenomai.org>	
	<1350933768.17153.16.camel@ENG-09-LX.emacinc.com>	
	<50859D99.5040009@xenomai.org>
	<1350934476.17153.20.camel@ENG-09-LX.emacinc.com>
In-Reply-To: <1350934476.17153.20.camel@ENG-09-LX.emacinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] Adeos I-Pipe patch problem on vendor-specific kernel
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Wayne Warren <wwarren@emacinc.com>
Cc: xenomai@xenomai.org

On 10/22/2012 09:34 PM, Wayne Warren wrote:

> 
>>
>> Chances are you are calling into Adeos code too early. Normally, the
>> first call to local_irq_enable() happens in init/main.c, after the call
>> to __ipipe_init() (you should see both in function start_kernel). I
>> suspect you can not call services such as __set_irq_handler too early in
>> the boot process.
> 
> In the code I am looking at, local_irq_enable() is called after
> ipipe_init().
> 
> Are you saying that the __set_irq_handler() service should not be called
> before ipipe_init() also? Cause it is called after ipipe_init_early()
> but before ipipe_init().


The same order happens on OMAP3 for the primary interrupt controller.
So, that should work.

-- 
                                                                Gilles.

