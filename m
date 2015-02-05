Date: Thu, 5 Feb 2015 12:50:20 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Message-ID: <20150205115020.GA32156@hermes.click-hack.org>
References: <54D350CA.90801@control.lth.se>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <54D350CA.90801@control.lth.se>
Subject: Re: [Xenomai] xenomai-3/next: modprobe rtpacket fails with -EINVAL
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Anders Blomdell <anders.blomdell@control.lth.se>
Cc: "Xenomai@xenomai.org" <Xenomai@xenomai.org>

On Thu, Feb 05, 2015 at 12:15:22PM +0100, Anders Blomdell wrote:
> AFAICT there are two ways to fix it, either change kernel/cobalt/rtdm/device.c:
> 
>        if (drv->device_count <= 0)
>                 return -EINVAL;
> to:
>        if (drv->device_count <= 0 ||
> 	   (drv->device_count == 0 && 
> 	    (drv->device_flags & RTDM_DEVICE_TYPE_MASK) != RTDM_PROTOCOL_DEVICE)))
>                 return -EINVAL;    
> 
> or change kernel/drivers/net/stack/packet/af_packet.c:
> 
>   static struct rtdm_driver packet_proto_drv = {
>     .profile_info =     RTDM_PROFILE_INFO(packet,
>                                         RTDM_CLASS_NETWORK,
>                                         RTDM_SUBCLASS_RTNET,
>                                         RTNET_RTDM_VER),
>     .device_flags =     RTDM_PROTOCOL_DEVICE,
>     .context_size =     sizeof(struct rtsocket),
>     ...
>   }
> 
> to:
> 
>   static struct rtdm_driver packet_proto_drv = {
>     .profile_info =     RTDM_PROFILE_INFO(packet,
>                                         RTDM_CLASS_NETWORK,
>                                         RTDM_SUBCLASS_RTNET,
>                                         RTNET_RTDM_VER),
>     .device_flags =     RTDM_PROTOCOL_DEVICE,
>     .device_count =     1,
>     .context_size =     sizeof(struct rtsocket),
>     ...
>   }
> 
> Since the second change is what 'rtdm_driver raw_packet_proto_drv', and the code looks
> prettier, I guess that the second way is the preferred one?

I received a patch for this issue, I simply need to merge it. Thanks
for the reminder.

-- 
					    Gilles.

