Date: Mon, 2 May 2016 09:10:34 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Message-ID: <20160502071034.GD1761@hermes.click-hack.org>
References: <47132d04b76942d8bd15c82a5a460f7b@EDB3.wapice.localdomain>
 <20160403190948.GC20399@hermes.click-hack.org>
 <20160430064939.GC1781@hermes.click-hack.org>
 <4b738c3a791c4b80af77c3ae52f304bd@EDB3.wapice.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4b738c3a791c4b80af77c3ae52f304bd@EDB3.wapice.localdomain>
Subject: Re: [Xenomai] A fix to few generic issues in rttcp stack
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Matti Suominen <matti.suominen@wapice.com>
Cc: Lassi =?iso-8859-1?Q?Niemist=F6?= <lassi.niemisto@wapice.com>, "xenomai@xenomai.org" <xenomai@xenomai.org>

On Mon, May 02, 2016 at 06:32:46AM +0000, Matti Suominen wrote:
> Hi and sorry for delay.
> 
> Yes, we are using rtnetproxy and I am now testing fallback handler. I'm 
> not sure am I using it right way but it seems to work correctly. Code 
> snippet at end of message.
> 
> Matti Suominen
> Wapice Oy
> www.wapice.com
> 
> On Sun, Apr 03, 2016 at 09:09:48PM +0200, Gilles Chanteperdrix wrote:
> 
> > I am going to merge your patch for the time being. However, I have a
> > question about using rttcp in parallel with Linux tcp: are you using
> > the rtnetproxy module? If yes, then testing for
> > CONFIG_XENO_DRIVERS_NET_ADDON_PROXY and the rt_ip_fallback_handler
> > pointer would be the way to go.
> 
> 
> --- tcp.c ---
> static struct rtsocket *rt_tcp_dest_socket(struct rtskb *skb)
> {
>     struct tcphdr    *th = skb->h.th;
> 
>     u32 saddr = skb->nh.iph->saddr;
>     u32 daddr = skb->nh.iph->daddr;
>     u32 sport = th->source;
>     u32 dport = th->dest;
> 
>     u32 data_len;
> 
>     if (tcp_v4_check(skb->len, saddr, daddr,
> 		     csum_partial(skb->data, skb->len, 0))) {
> 	rtdm_printk("rttcp: invalid TCP packet checksum, dropped\n");
> 	return NULL; /* Invalid checksum, drop the packet */
>     }
> 
>     /* find the destination socket */
>     if ((skb->sk = rt_tcp_v4_lookup(daddr, dport)) == NULL) {
> 	/*
> 	  rtdm_printk("Not found addr:0x%08x, port: 0x%04x\n", daddr, dport);
> 	*/
> #ifdef CONFIG_RTNET_ADDON_PROXY
> 		if (rt_ip_fallback_handler) {
> 			/* If a fallback handler for IP protocol has been installed,
> 			 * call it. */
> 			rt_ip_fallback_handler(skb);
> 		}
> #endif

You do not need to call rt_ip_fallback_handler, it will be called by
ip_input.c when dest_socket returns NULL. However, you need to
return, otherwise the RST|ACK is sent, which is what you wanted to
avoid.

-- 
					    Gilles.
https://click-hack.org

