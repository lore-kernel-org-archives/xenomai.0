Date: Wed, 11 Feb 2015 21:23:04 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Message-ID: <20150211202304.GB6103@hermes.click-hack.org>
References: <1942863149.11150.1422371568908.JavaMail.zimbra@wandercraft.eu>
 <20150127153903.GD16502@hermes.click-hack.org>
 <383897695.12140.1422374079502.JavaMail.zimbra@wandercraft.eu>
 <20150127160045.GE16502@hermes.click-hack.org>
 <1196678867.12503.1422375100449.JavaMail.zimbra@wandercraft.eu>
 <591131357.26954.1423565161829.JavaMail.zimbra@wandercraft.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
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

Merged, thanks.

-- 
					    Gilles.

