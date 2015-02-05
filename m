Message-ID: <54D350CA.90801@control.lth.se>
Date: Thu, 05 Feb 2015 12:15:22 +0100
From: Anders Blomdell <anders.blomdell@control.lth.se>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Subject: [Xenomai] xenomai-3/next: modprobe rtpacket fails with -EINVAL
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: "Xenomai@xenomai.org" <Xenomai@xenomai.org>

AFAICT there are two ways to fix it, either change kernel/cobalt/rtdm/device.c:

       if (drv->device_count <= 0)
                return -EINVAL;
to:
       if (drv->device_count <= 0 ||
	   (drv->device_count == 0 && 
	    (drv->device_flags & RTDM_DEVICE_TYPE_MASK) != RTDM_PROTOCOL_DEVICE)))
                return -EINVAL;    

or change kernel/drivers/net/stack/packet/af_packet.c:

  static struct rtdm_driver packet_proto_drv = {
    .profile_info =     RTDM_PROFILE_INFO(packet,
                                        RTDM_CLASS_NETWORK,
                                        RTDM_SUBCLASS_RTNET,
                                        RTNET_RTDM_VER),
    .device_flags =     RTDM_PROTOCOL_DEVICE,
    .context_size =     sizeof(struct rtsocket),
    ...
  }

to:

  static struct rtdm_driver packet_proto_drv = {
    .profile_info =     RTDM_PROFILE_INFO(packet,
                                        RTDM_CLASS_NETWORK,
                                        RTDM_SUBCLASS_RTNET,
                                        RTNET_RTDM_VER),
    .device_flags =     RTDM_PROTOCOL_DEVICE,
    .device_count =     1,
    .context_size =     sizeof(struct rtsocket),
    ...
  }

Since the second change is what 'rtdm_driver raw_packet_proto_drv', and the code looks
prettier, I guess that the second way is the preferred one?

/Anders
-- 
Anders Blomdell                  Email: anders.blomdell@control.lth.se
Department of Automatic Control
Lund University                  Phone:    +46 46 222 4625
P.O. Box 118                     Fax:      +46 46 138118
SE-221 00 Lund, Sweden


