MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Transfer-Encoding: 8bit
Date: Mon, 04 Jul 2016 17:00:38 +0200
From: Geoffrey BONNEVILLE <geoffrey.bonneville@smile.fr>
In-Reply-To: <20160702150226.GC12357@hermes.click-hack.org>
References: <3137778ca215b6db6061de83fa64dcae@smile.fr>
 <20160702150226.GC12357@hermes.click-hack.org>
Message-ID: <304b3c85b2eb4c147b9df3163efcf90a@smile.fr>
Subject: Re: [Xenomai] RTnet - List corruption when creating packet socket
 two consecutive times
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

Hi,

I can confirm that your patch fixes the problem. Thank you !

FYI I tried to create a socket with and without a loaded driver :
rt_loopback.ko and another one for Beaglebone.
As you said, none of them has "rtskb_map/rtskb_unmap" methods.

Best regards.



Le 2016-07-02 17:02, Gilles Chanteperdrix a écrit :
> On Fri, Jul 01, 2016 at 04:31:58PM +0200, Geoffrey BONNEVILLE wrote:
>> 
>> 
>> Hi,
>> 
>> Tested with Xenomai 3.0.2 (Cobalt) on a 4.1 kernel. Both on a
>> 32-bits ARM and a 32 bits x86 platform.
>> 
>> I get a list corruption
>> warning when I try to open()/close() one packet socket, two (or more)
>> consecutive times.
>> 
>> I think the problem is not limited to packet
>> sockets.
>> 
>> Steps to reproduce:
>> 
>> - Use a kernel with CONFIG_DEBUG_LIST=y
>> 
>> 
>> - Load rtnet.ko and rtpacket.ko
>> 
>> - Execute a program which open() and
>> close() a packet socket. (see test_socket.c below)
> 
> Hi,
> 
> had a look finally. First of all this test does not correspond to a
> realistic use case, at least with RTnet: users are not expected to
> destroy sockets before they have installed network drivers.
> Obviously, a socket with such a short lifetime has not been very
> useful. And this problem does not happen if you load a driver which
> has "rtskb_map/rtskb_unmap" methods, that is, that does DMA mapping
> of rtskbs.
> 
> However, only two drivers have these methods, e1000e and igb, and
> all others do not have them, so the problem you report could happen in
> realistic situations. The patch at the end of the mail seems to fix 
> it.
> Unfortunately, I did not test it with e1000e and igb drivers to see
> if it does not break them, so I am not going to merge it for the
> time being.
> 
> Regards.
> 
> diff --git a/kernel/drivers/net/stack/include/rtskb.h
> b/kernel/drivers/net/stack/include/rtskb.h
> index 7489aa6..fdb6294 100644
> --- a/kernel/drivers/net/stack/include/rtskb.h
> +++ b/kernel/drivers/net/stack/include/rtskb.h
> @@ -145,6 +145,7 @@ cap_rtmac_stamp field now contains valid data.
>  #define RTSKB_CAP_RTMAC_STAMP   2   /* cap_rtmac_stamp is valid       
>      */
> 
>  #define RTSKB_UNMAPPED          0
> +#define RTSKB_UNMAPPED_INLIST	1
> 
>  struct rtskb_queue;
>  struct rtsocket;
> diff --git a/kernel/drivers/net/stack/rtdev.c 
> b/kernel/drivers/net/stack/rtdev.c
> index 5eb73ce..940b8ff 100644
> --- a/kernel/drivers/net/stack/rtdev.c
> +++ b/kernel/drivers/net/stack/rtdev.c
> @@ -379,6 +379,7 @@ static int rtskb_map(struct rtnet_device *rtdev,
> struct rtskb *skb)
>  	return -ENOMEM;
> 
>      if (skb->buf_dma_addr != RTSKB_UNMAPPED &&
> +	skb->buf_dma_addr != RTSKB_UNMAPPED_INLIST &&
>  	addr != skb->buf_dma_addr) {
>  	printk("RTnet: device %s maps skb differently than others. "
>  	       "Different IOMMU domain?\nThis is not supported.\n",
> @@ -412,8 +413,11 @@ int rtdev_map_rtskb(struct rtskb *skb)
>  	}
>      }
> 
> -    if (!err)
> +    if (!err) {
> +	if (skb->buf_dma_addr == RTSKB_UNMAPPED)
> +	    skb->buf_dma_addr = RTSKB_UNMAPPED_INLIST;
>  	list_add(&skb->entry, &rtskb_list);
> +    }
> 
>      mutex_unlock(&rtnet_devices_nrt_lock);
> 
> @@ -453,13 +457,14 @@ void rtdev_unmap_rtskb(struct rtskb *skb)
> 
>      list_del(&skb->entry);
> 
> -    for (i = 0; i < MAX_RT_DEVICES; i++) {
> -	rtdev = rtnet_devices[i];
> -	if (rtdev && rtdev->unmap_rtskb) {
> -	    rtdev->unmap_rtskb(rtdev, skb);
> +    if (skb->buf_dma_addr != RTSKB_UNMAPPED_INLIST) {
> +	for (i = 0; i < MAX_RT_DEVICES; i++) {
> +	    rtdev = rtnet_devices[i];
> +	    if (rtdev && rtdev->unmap_rtskb) {
> +		rtdev->unmap_rtskb(rtdev, skb);
> +	    }
>  	}
>      }
> -
>      skb->buf_dma_addr = RTSKB_UNMAPPED;
> 
>      mutex_unlock(&rtnet_devices_nrt_lock);

