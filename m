Date: Tue, 10 Feb 2015 13:26:57 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Message-ID: <20150210122657.GG3200@hermes.click-hack.org>
References: <1942863149.11150.1422371568908.JavaMail.zimbra@wandercraft.eu>
 <20150127153903.GD16502@hermes.click-hack.org>
 <383897695.12140.1422374079502.JavaMail.zimbra@wandercraft.eu>
 <20150127160045.GE16502@hermes.click-hack.org>
 <1196678867.12503.1422375100449.JavaMail.zimbra@wandercraft.eu>
 <591131357.26954.1423565161829.JavaMail.zimbra@wandercraft.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <591131357.26954.1423565161829.JavaMail.zimbra@wandercraft.eu>
Subject: Re: [Xenomai] Patch rtnet support Intel i217/i218 Ethernet
	Controller
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Huy Cong Vu <huy-cong.vu@wandercraft.eu>
Cc: xenomai@xenomai.org

On Tue, Feb 10, 2015 at 11:46:01AM +0100, Huy Cong Vu wrote:
> 
> 
> ----- Mail original -----
> > De: "Huy Cong Vu" <huy-cong.vu@wandercraft.eu>
> > À: "Gilles Chanteperdrix" <gilles.chanteperdrix@xenomai.org>
> > Cc: xenomai@xenomai.org
> > Envoyé: Mardi 27 Janvier 2015 17:11:40
> > Objet: Re: [Xenomai] Patch rtnet support Intel i217/i218 Ethernet Controller
> 
> > ----- Mail original -----
> >> De: "Gilles Chanteperdrix" <gilles.chanteperdrix@xenomai.org>
> >> À: "Huy Cong Vu" <huy-cong.vu@wandercraft.eu>
> >> Cc: xenomai@xenomai.org
> >> Envoyé: Mardi 27 Janvier 2015 17:00:45
> >> Objet: Re: [Xenomai] Patch rtnet support Intel i217/i218 Ethernet Controller
> > 
> >> On Tue, Jan 27, 2015 at 04:54:39PM +0100, Huy Cong Vu wrote:
> >>> 
> >>> 
> >>> ----- Mail original -----
> >>> > De: "Gilles Chanteperdrix" <gilles.chanteperdrix@xenomai.org>
> >>> > À: "Huy Cong Vu" <huy-cong.vu@wandercraft.eu>
> >>> > Cc: xenomai@xenomai.org
> >>> > Envoyé: Mardi 27 Janvier 2015 16:39:03
> >>> > Objet: Re: [Xenomai] Patch rtnet support Intel i217/i218 Ethernet Controller
> >>> 
> >>> > On Tue, Jan 27, 2015 at 04:12:48PM +0100, Huy Cong Vu wrote:
> >>> >> Hello Xenomai group,
> >>> >> I recently run a test of rtnet on xenomai-3-next on my Intel NUC D54250WYK with
> >>> >> the Intel I218V Ethernet Controller.
> >>> >> It is patched on linux 3.14.17. Here I attached the patch to make rtnet work
> >>> >> with i217/i218 Intel family.
> >>> >> Also, I found out that in rtpacket module, the declaration of packet_proto_drv
> >>> >> lack of .device_count attribute, which makes the rtpacket & rtcap modules
> >>> >> unable to loaded ( -EINVAL is returned), so I merge it in my patch too.
> >>> >> I test on my system and all the following command is now working:
> >>> >> modprobe rtnet
> >>> >> modprobe rt_e1000e
> >>> >> modprobe rtpacket
> >>> >> modprobe rtcap
> >>> >> rtifconfig rteth0 up
> >>> >> ifconfig rteth0 up
> >>> >> ifconfig rteth0-mac up
> >>> >> But if I used the rteth0 interface, I can't unload rt_e1000e.
> >>> >> Could you take a look and see if anything is wrong, and if you find it useful,
> >>> >> merge it in your git repository.
> >>> >> Best regards,
> >>> > 
> >>> > In Xenomai 3, you need to deconfigure the interface before you try
> >>> > to unload it.
> >>> 
> >>> If I tried to turn off rteth0 interface after using it, I still can't unload
> >>> rt_e1000e.
> >>> For now, this work:
> >>> modprobe rt_e1000e
> >>> modprobe rtpacket
> >>> rtifconfig rteth0 up
> >>> rtifconfig rteth0 down
> >>> rmmod rt_e1000e
> >>> rmmod rtpacket
> >>> 
> >>> This doesn't work:
> >>> modprobe rt_e1000e
> >>> modprobe rtpacket
> >>> rtifconfig rteth0 up
> >>> //Send datagram through rteth0 interface
> >>> rtifconfig rteth0 down
> >>> rmmod rt_e1000e
> >>> 
> 
> This patch helps. 
> 
> diff --git a/kernel/drivers/net/stack/packet/af_packet.c b/kernel/drivers/net/stack/packet/af_packet.c
> index dd862fe..6a9f183 100644
> --- a/kernel/drivers/net/stack/packet/af_packet.c
> +++ b/kernel/drivers/net/stack/packet/af_packet.c
> @@ -456,6 +456,7 @@ rt_packet_sendmsg(struct rtdm_fd *fd, const struct msghdr *msg, int msg_flags)
>      }
>  
>   out:
> +    rtdev_dereference(rtdev);
>      return ret;
>  
>   err:
> 
> Now it seems ok to unload all modules for me.

Ok, will merge, thanks.

-- 
					    Gilles.

