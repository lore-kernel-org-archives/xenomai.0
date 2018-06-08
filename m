From: Philippe Gerum <rpm@xenomai.org>
References: <9DA3CFDAD528B6408A6F2150A12D33CA51A776E1@SHSMSX103.ccr.corp.intel.com>
 <b55360b0-3453-50be-b81e-e895ed01845c@xenomai.org>
 <9DA3CFDAD528B6408A6F2150A12D33CA51A77EC6@SHSMSX103.ccr.corp.intel.com>
 <e7ec797a-61b5-0033-cc00-cb6df3e39923@xenomai.org>
Message-ID: <764a018e-5768-c093-7993-2ad290d58797@xenomai.org>
Date: Fri, 8 Jun 2018 09:10:30 +0200
MIME-Version: 1.0
In-Reply-To: <e7ec797a-61b5-0033-cc00-cb6df3e39923@xenomai.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] INTR-REMAP issue while enabling GPIO interrupt as
 RTDM interrupt
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: "Yan, Hongliang" <archer.hl.yan@intel.com>, "Xenomai@xenomai.org" <Xenomai@xenomai.org>

On 06/08/2018 09:07 AM, Philippe Gerum wrote:
> On 06/08/2018 07:22 AM, Yan, Hongliang wrote:
>> Hi Philippe,
>>   May I ask why you use irq_set_chained_handler_and_data instead of rtdm_irq_request? It seems irq_set_chained_handler_and_data register the irq as ipipe_root_domain while rtdm_irq_request register the irq as xnsched_realtime_domain. Can we use xnsched_realtime_domain for this GPIO interrupt?
> 
> That is the other way around. The rtdm* API is based on the modified
> genirq core from the Linux kernel. Modifying the pinctrl driver enables
> IRQ pipelining, which in turn allows rtdm* calls to interpose on the IRQ
> flow for handling events in rt mode.
> 

This may be worth a read:
http://git.xenomai.org/ipipe-noarch.git/tree/Documentation/ipipe.rst

-- 
Philippe.

