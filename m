Message-ID: <4FC7A46F.1030706@xenomai.org>
Date: Thu, 31 May 2012 19:03:43 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <623784B6C75D274389918D358E89E8BB0B7FDF5C@OPTELIAN5.optelian.local>
In-Reply-To: <623784B6C75D274389918D358E89E8BB0B7FDF5C@OPTELIAN5.optelian.local>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] ARM MX35 MDIO read timeout.
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Chris Stone <chris.stone@optelian.com>
Cc: "xenomai@xenomai.org" <xenomai@xenomai.org>

On 05/29/2012 04:51 PM, Chris Stone wrote:
> diff -r d5a7342d6e47 drivers/net/fec.c
> --- a/drivers/net/fec.c Tue May 29 09:58:21 2012 -0400
> +++ b/drivers/net/fec.c Tue May 29 10:49:24 2012 -0400
> @@ -703,6 +703,7 @@
>                 if (int_events & FEC_ENET_TXF) {
>                         ret = IRQ_HANDLED;
>                         fec_enet_tx(ndev);
> +                       udelay(300);
>                 }
>  
>                 if (int_events & FEC_ENET_MII) {
> 
> Smaller delays don't work. I know this isn't a fix. My question is, does this information give the 
> experts any ideas on what the real problem might be?

This does not ring any bell. The important code is the code which does
the MDIO read. Some code may simply not like being interrupted by
Xenomai, so, you may have to simply increase the timeout.

-- 
					    Gilles.

