References: <574D9B03.8080706@sigmatek.at>
 <20160531141646.GG5951@hermes.click-hack.org> <574EE886.2020907@sigmatek.at>
 <20160601141238.GC14103@hermes.click-hack.org> <574FEB2D.5010509@sigmatek.at>
 <20160602082318.GB1801@hermes.click-hack.org> <5755204C.6090701@sigmatek.at>
 <20160606153545.GA376@hermes.click-hack.org> <5756D673.4080408@sigmatek.at>
From: Philippe Gerum <rpm@xenomai.org>
Message-ID: <e1d520de-c557-82fb-470f-40a105e9862e@xenomai.org>
Date: Tue, 7 Jun 2016 19:22:56 +0200
MIME-Version: 1.0
In-Reply-To: <5756D673.4080408@sigmatek.at>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] Performance impact after switching from 2.6.2.1 to
 2.6.4
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: wolfgang.netbal@sigmatek.at
Cc: xenomai@xenomai.org

On 06/07/2016 04:13 PM, Wolfgang Netbal wrote:

> As I wrote above, I get interrupts 1037 handled by rthal_apc_handler()
> and 1038 handled by xnpod_schedule_handler() while my realtime task
> is running on kernel 3.10.53 with Xenomai 2.6.4.
> On kernel 3.0.43 with Xenomai 2.6.4 there are no interrupts, except the
> once that are send by my board using GPIOs, but this virtual interrupts
> are assigned to Xenomai and Linux as well but I didn't see a handler
> installed.
> I'm pretty sure that these interrupts are slowing down my system, but
> where do they come from ?
> why didn't I see them on Kernel 3.0.43 with Xenomai 2.6.4 ?
> how long do they need to process ?
> 
> Is there any dependecy in Xenomai between the kernel version and this
> virtual interrupts ?
> 

Maybe you should consider reading all the replies you get:

On 05/31/2016 05:08 PM, Philippe Gerum wrote:
> On 05/31/2016 04:09 PM, Wolfgang Netbal wrote:
>> Dear all,
>>
>> we have moved our application from "XENOMAI 2.6.2.1 + Linux 3.0.43" to
>> "XENOMAI 2.6.4. + Linux 3.10.53". Our target is an i.MX6DL. The system
>> is now up and running and works stable. Unfortunately we see a
>> difference in the performance. Our old combination (XENOMAI 2.6.2.1 +
>> Linux 3.0.43) was slightly faster.
>>
>
> Could you quantify "slightly faster"? This is a dual kernel system, so
> changes on either the regular kernel side and/or the co-kernel side may
> have a measurable impact.
>
>> At the moment it looks like that XENOMAI 2.6.4 calls
>> xnpod_schedule_handler much more often then XENOMAI 2.6.2.1 in our old
>> system.  Every call of xnpod_schedule_handler interrupts our main
>> XENOMAI task with priority = 95.
>
> That handler is attached to the inter-processor interrupt used for
> rescheduling tasks running on a remote CPU. You may want to check the
> CPU affinity settings of your tasks, and the way they
interact/synchronize.
>

You may also want to check the mode switch count for your threads in
/proc/xenomai/stat (MSW field). I suspect your application may be
switching mode like crazy between Linux and Xenomai, causing interrupt
activity for waking up either sides in turn.

-- 
Philippe.

