From: Matti Suominen <matti.suominen@wapice.com>
Date: Mon, 2 May 2016 06:32:46 +0000
Message-ID: <4b738c3a791c4b80af77c3ae52f304bd@EDB3.wapice.localdomain>
References: <47132d04b76942d8bd15c82a5a460f7b@EDB3.wapice.localdomain>
 <20160403190948.GC20399@hermes.click-hack.org>
 <20160430064939.GC1781@hermes.click-hack.org>
In-Reply-To: <20160430064939.GC1781@hermes.click-hack.org>
Content-Language: en-US
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: Re: [Xenomai] A fix to few generic issues in rttcp stack
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: =?iso-8859-1?Q?Lassi_Niemist=F6?= <lassi.niemisto@wapice.com>, "xenomai@xenomai.org" <xenomai@xenomai.org>

Hi and sorry for delay.

Yes, we are using rtnetproxy and I am now testing fallback handler. I'm=20
not sure am I using it right way but it seems to work correctly. Code=20
snippet at end of message.

Matti Suominen
Wapice Oy
www.wapice.com

On Sun, Apr 03, 2016 at 09:09:48PM +0200, Gilles Chanteperdrix wrote:

> I am going to merge your patch for the time being. However, I have a
> question about using rttcp in parallel with Linux tcp: are you using
> the rtnetproxy module? If yes, then testing for
> CONFIG_XENO_DRIVERS_NET_ADDON_PROXY and the rt_ip_fallback_handler
> pointer would be the way to go.


--- tcp.c ---
static struct rtsocket *rt_tcp_dest_socket(struct rtskb *skb)
{
    struct tcphdr    *th =3D skb->h.th;

    u32 saddr =3D skb->nh.iph->saddr;
    u32 daddr =3D skb->nh.iph->daddr;
    u32 sport =3D th->source;
    u32 dport =3D th->dest;

    u32 data_len;

    if (tcp_v4_check(skb->len, saddr, daddr,
		     csum_partial(skb->data, skb->len, 0))) {
	rtdm_printk("rttcp: invalid TCP packet checksum, dropped\n");
	return NULL; /* Invalid checksum, drop the packet */
    }

    /* find the destination socket */
    if ((skb->sk =3D rt_tcp_v4_lookup(daddr, dport)) =3D=3D NULL) {
	/*
	  rtdm_printk("Not found addr:0x%08x, port: 0x%04x\n", daddr, dport);
	*/
#ifdef CONFIG_RTNET_ADDON_PROXY
		if (rt_ip_fallback_handler) {
			/* If a fallback handler for IP protocol has been installed,
			 * call it. */
			rt_ip_fallback_handler(skb);
		}
#endif
		if (skb && !th->rst) {
			/* No listening socket found, send RST|ACK */
			rst_socket.saddr =3D daddr;
			rst_socket.daddr =3D saddr;
			rst_socket.sport =3D dport;
			rst_socket.dport =3D sport;

			data_len =3D skb->len - (th->doff << 2);

			rst_socket.sync.seq =3D 0;
			rst_socket.sync.ack_seq =3D rt_tcp_compute_ack_seq(th, data_len);

			if (rt_ip_route_output(&rst_socket.rt, daddr, saddr) =3D=3D 0) {
			rt_socket_reference(&rst_socket.sock);
			rt_tcp_send(&rst_socket, TCPHDR_ACK|TCPHDR_RST);
			rtdev_dereference(rst_socket.rt.rtdev);
			}
		}
    }

    return skb->sk;
}

