Subject: Re: [PATCH] net/drivers: fec: cleanup and backward compatibity with
 5.4 kernel
References: <20211208111904.9455-1-jean-baptiste.tredez@ba-healthcare.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <3bf9a8c0-2aa6-886d-68ae-9339548fd438@siemens.com>
Date: Fri, 10 Dec 2021 11:38:21 +0100
MIME-Version: 1.0
In-Reply-To: <20211208111904.9455-1-jean-baptiste.tredez@ba-healthcare.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: =?UTF-8?Q?Jean-Baptiste_Tr=c3=a9dez?= <jean-baptiste.tredez@ba-healthcare.com>, xenomai@xenomai.org

On 08.12.21 12:19, Jean-Baptiste Trédez via Xenomai wrote:
> remove unused functions (used on linux driver but no longer used on rt driver) :
> - swap_buffer2
> - fec_enet_clear_csum
> - fec_enet_txq_submit_frag_skb
> - fec_enet_txq_put_data_tso
> - fec_enet_txq_put_hdr_tso
> - fec_enet_txq_submit_tso
> - fec_enet_hwtstamp
> - fec_enet_copybreak
> 
> Add backward compatibity with 5.4 kernel API
> 
> Signed-off-by: Jean-Baptiste Trédez <jean-baptiste.tredez@ba-healthcare.com>
> ---
>  .../drivers/net/drivers/freescale/fec_main.c  | 361 ++----------------
>  1 file changed, 22 insertions(+), 339 deletions(-)
> 
> diff --git a/kernel/drivers/net/drivers/freescale/fec_main.c b/kernel/drivers/net/drivers/freescale/fec_main.c
> index a9476d4c8..864e4b5b8 100644
> --- a/kernel/drivers/net/drivers/freescale/fec_main.c
> +++ b/kernel/drivers/net/drivers/freescale/fec_main.c
> @@ -64,8 +64,8 @@
>  #include <linux/prefetch.h>
>  #include <linux/mfd/syscon.h>
>  #include <linux/regmap.h>
> +#include <linux/iopoll.h>
>  #include <soc/imx/cpuidle.h>
> -
>  #include <asm/cacheflush.h>
>  
>  #include "fec.h"
> @@ -346,16 +346,6 @@ static void swap_buffer(void *bufaddr, int len)
>  		swab32s(buf);
>  }
>  
> -static void swap_buffer2(void *dst_buf, void *src_buf, int len)
> -{
> -	int i;
> -	unsigned int *src = src_buf;
> -	unsigned int *dst = dst_buf;
> -
> -	for (i = 0; i < len; i += 4, src++, dst++)
> -		*dst = swab32p(src);
> -}
> -
>  static void fec_dump(struct net_device *ndev)
>  {
>  	struct fec_enet_private *fep = netdev_priv(ndev);
> @@ -388,111 +378,6 @@ static inline bool is_ipv4_pkt(struct sk_buff *skb)
>  	return skb->protocol == htons(ETH_P_IP) && ip_hdr(skb)->version == 4;
>  }
>  
> -static int
> -fec_enet_clear_csum(struct sk_buff *skb, struct net_device *ndev)
> -{
> -	/* Only run for packets requiring a checksum. */
> -	if (skb->ip_summed != CHECKSUM_PARTIAL)
> -		return 0;
> -
> -	if (unlikely(skb_cow_head(skb, 0)))
> -		return -1;
> -
> -	if (is_ipv4_pkt(skb))
> -		ip_hdr(skb)->check = 0;
> -	*(__sum16 *)(skb->head + skb->csum_start + skb->csum_offset) = 0;
> -
> -	return 0;
> -}
> -
> -static struct bufdesc *
> -fec_enet_txq_submit_frag_skb(struct fec_enet_priv_tx_q *txq,
> -			     struct sk_buff *skb,
> -			     struct net_device *ndev)
> -{
> -	struct fec_enet_private *fep = netdev_priv(ndev);
> -	struct bufdesc *bdp = txq->bd.cur;
> -	struct bufdesc_ex *ebdp;
> -	int nr_frags = skb_shinfo(skb)->nr_frags;
> -	int frag, frag_len;
> -	unsigned short status;
> -	unsigned int estatus = 0;
> -	skb_frag_t *this_frag;
> -	unsigned int index;
> -	void *bufaddr;
> -	dma_addr_t addr;
> -	int i;
> -
> -	for (frag = 0; frag < nr_frags; frag++) {
> -		this_frag = &skb_shinfo(skb)->frags[frag];
> -		bdp = fec_enet_get_nextdesc(bdp, &txq->bd);
> -		ebdp = (struct bufdesc_ex *)bdp;
> -
> -		status = fec16_to_cpu(bdp->cbd_sc);
> -		status &= ~BD_ENET_TX_STATS;
> -		status |= (BD_ENET_TX_TC | BD_ENET_TX_READY);
> -		frag_len = skb_frag_size(&skb_shinfo(skb)->frags[frag]);
> -
> -		/* Handle the last BD specially */
> -		if (frag == nr_frags - 1) {
> -			status |= (BD_ENET_TX_INTR | BD_ENET_TX_LAST);
> -			if (fep->bufdesc_ex) {
> -				estatus |= BD_ENET_TX_INT;
> -				if (unlikely(skb_shinfo(skb)->tx_flags &
> -					SKBTX_HW_TSTAMP && fep->hwts_tx_en))
> -					estatus |= BD_ENET_TX_TS;
> -			}
> -		}
> -
> -		if (fep->bufdesc_ex) {
> -			if (fep->quirks & FEC_QUIRK_HAS_AVB)
> -				estatus |= FEC_TX_BD_FTYPE(txq->bd.qid);
> -			if (skb->ip_summed == CHECKSUM_PARTIAL)
> -				estatus |= BD_ENET_TX_PINS | BD_ENET_TX_IINS;
> -			ebdp->cbd_bdu = 0;
> -			ebdp->cbd_esc = cpu_to_fec32(estatus);
> -		}
> -
> -		bufaddr = skb_frag_address(this_frag);
> -
> -		index = fec_enet_get_bd_index(bdp, &txq->bd);
> -		if (((unsigned long) bufaddr) & fep->tx_align ||
> -			fep->quirks & FEC_QUIRK_SWAP_FRAME) {
> -			memcpy(txq->tx_bounce[index], bufaddr, frag_len);
> -			bufaddr = txq->tx_bounce[index];
> -
> -			if (fep->quirks & FEC_QUIRK_SWAP_FRAME)
> -				swap_buffer(bufaddr, frag_len);
> -		}
> -
> -		addr = dma_map_single(&fep->pdev->dev, bufaddr, frag_len,
> -				      DMA_TO_DEVICE);
> -		if (dma_mapping_error(&fep->pdev->dev, addr)) {
> -			if (net_ratelimit())
> -				netdev_err(ndev, "Tx DMA memory map failed\n");
> -			goto dma_mapping_error;
> -		}
> -
> -		bdp->cbd_bufaddr = cpu_to_fec32(addr);
> -		bdp->cbd_datlen = cpu_to_fec16(frag_len);
> -		/* Make sure the updates to rest of the descriptor are
> -		 * performed before transferring ownership.
> -		 */
> -		wmb();
> -		bdp->cbd_sc = cpu_to_fec16(status);
> -	}
> -
> -	return bdp;
> -dma_mapping_error:
> -	bdp = txq->bd.cur;
> -	for (i = 0; i < frag; i++) {
> -		bdp = fec_enet_get_nextdesc(bdp, &txq->bd);
> -		dma_unmap_single(&fep->pdev->dev, fec32_to_cpu(bdp->cbd_bufaddr),
> -				 fec16_to_cpu(bdp->cbd_datlen), DMA_TO_DEVICE);
> -	}
> -	return ERR_PTR(-ENOMEM);
> -}
> -
>  static int fec_rt_txq_submit_skb(struct fec_enet_priv_tx_q *txq,
>  				 struct rtskb *skb, struct net_device *ndev)
>  {
> @@ -595,204 +480,6 @@ static int fec_rt_txq_submit_skb(struct fec_enet_priv_tx_q *txq,
>  	return 0;
>  }
>  
> -static int
> -fec_enet_txq_put_data_tso(struct fec_enet_priv_tx_q *txq, struct sk_buff *skb,
> -			  struct net_device *ndev,
> -			  struct bufdesc *bdp, int index, char *data,
> -			  int size, bool last_tcp, bool is_last)
> -{
> -	struct fec_enet_private *fep = netdev_priv(ndev);
> -	struct bufdesc_ex *ebdp = container_of(bdp, struct bufdesc_ex, desc);
> -	unsigned short status;
> -	unsigned int estatus = 0;
> -	dma_addr_t addr;
> -
> -	status = fec16_to_cpu(bdp->cbd_sc);
> -	status &= ~BD_ENET_TX_STATS;
> -
> -	status |= (BD_ENET_TX_TC | BD_ENET_TX_READY);
> -
> -	if (((unsigned long) data) & fep->tx_align ||
> -		fep->quirks & FEC_QUIRK_SWAP_FRAME) {
> -		memcpy(txq->tx_bounce[index], data, size);
> -		data = txq->tx_bounce[index];
> -
> -		if (fep->quirks & FEC_QUIRK_SWAP_FRAME)
> -			swap_buffer(data, size);
> -	}
> -
> -	addr = dma_map_single(&fep->pdev->dev, data, size, DMA_TO_DEVICE);
> -	if (dma_mapping_error(&fep->pdev->dev, addr)) {
> -		dev_kfree_skb_any(skb);
> -		if (net_ratelimit())
> -			netdev_err(ndev, "Tx DMA memory map failed\n");
> -		return NETDEV_TX_BUSY;
> -	}
> -
> -	bdp->cbd_datlen = cpu_to_fec16(size);
> -	bdp->cbd_bufaddr = cpu_to_fec32(addr);
> -
> -	if (fep->bufdesc_ex) {
> -		if (fep->quirks & FEC_QUIRK_HAS_AVB)
> -			estatus |= FEC_TX_BD_FTYPE(txq->bd.qid);
> -		if (skb->ip_summed == CHECKSUM_PARTIAL)
> -			estatus |= BD_ENET_TX_PINS | BD_ENET_TX_IINS;
> -		ebdp->cbd_bdu = 0;
> -		ebdp->cbd_esc = cpu_to_fec32(estatus);
> -	}
> -
> -	/* Handle the last BD specially */
> -	if (last_tcp)
> -		status |= (BD_ENET_TX_LAST | BD_ENET_TX_TC);
> -	if (is_last) {
> -		status |= BD_ENET_TX_INTR;
> -		if (fep->bufdesc_ex)
> -			ebdp->cbd_esc |= cpu_to_fec32(BD_ENET_TX_INT);
> -	}
> -
> -	bdp->cbd_sc = cpu_to_fec16(status);
> -
> -	return 0;
> -}
> -
> -static int
> -fec_enet_txq_put_hdr_tso(struct fec_enet_priv_tx_q *txq,
> -			 struct sk_buff *skb, struct net_device *ndev,
> -			 struct bufdesc *bdp, int index)
> -{
> -	struct fec_enet_private *fep = netdev_priv(ndev);
> -	int hdr_len = skb_transport_offset(skb) + tcp_hdrlen(skb);
> -	struct bufdesc_ex *ebdp = container_of(bdp, struct bufdesc_ex, desc);
> -	void *bufaddr;
> -	unsigned long dmabuf;
> -	unsigned short status;
> -	unsigned int estatus = 0;
> -
> -	status = fec16_to_cpu(bdp->cbd_sc);
> -	status &= ~BD_ENET_TX_STATS;
> -	status |= (BD_ENET_TX_TC | BD_ENET_TX_READY);
> -
> -	bufaddr = txq->tso_hdrs + index * TSO_HEADER_SIZE;
> -	dmabuf = txq->tso_hdrs_dma + index * TSO_HEADER_SIZE;
> -	if (((unsigned long)bufaddr) & fep->tx_align ||
> -		fep->quirks & FEC_QUIRK_SWAP_FRAME) {
> -		memcpy(txq->tx_bounce[index], skb->data, hdr_len);
> -		bufaddr = txq->tx_bounce[index];
> -
> -		if (fep->quirks & FEC_QUIRK_SWAP_FRAME)
> -			swap_buffer(bufaddr, hdr_len);
> -
> -		dmabuf = dma_map_single(&fep->pdev->dev, bufaddr,
> -					hdr_len, DMA_TO_DEVICE);
> -		if (dma_mapping_error(&fep->pdev->dev, dmabuf)) {
> -			dev_kfree_skb_any(skb);
> -			if (net_ratelimit())
> -				netdev_err(ndev, "Tx DMA memory map failed\n");
> -			return NETDEV_TX_BUSY;
> -		}
> -	}
> -
> -	bdp->cbd_bufaddr = cpu_to_fec32(dmabuf);
> -	bdp->cbd_datlen = cpu_to_fec16(hdr_len);
> -
> -	if (fep->bufdesc_ex) {
> -		if (fep->quirks & FEC_QUIRK_HAS_AVB)
> -			estatus |= FEC_TX_BD_FTYPE(txq->bd.qid);
> -		if (skb->ip_summed == CHECKSUM_PARTIAL)
> -			estatus |= BD_ENET_TX_PINS | BD_ENET_TX_IINS;
> -		ebdp->cbd_bdu = 0;
> -		ebdp->cbd_esc = cpu_to_fec32(estatus);
> -	}
> -
> -	bdp->cbd_sc = cpu_to_fec16(status);
> -
> -	return 0;
> -}
> -
> -static int fec_enet_txq_submit_tso(struct fec_enet_priv_tx_q *txq,
> -				   struct sk_buff *skb,
> -				   struct net_device *ndev)
> -{
> -	struct fec_enet_private *fep = netdev_priv(ndev);
> -	int hdr_len, total_len, data_left;
> -	struct bufdesc *bdp = txq->bd.cur;
> -	struct tso_t tso;
> -	unsigned int index = 0;
> -	int ret;
> -
> -	if (tso_count_descs(skb) >= fec_enet_get_free_txdesc_num(txq)) {
> -		dev_kfree_skb_any(skb);
> -		if (net_ratelimit())
> -			netdev_err(ndev, "NOT enough BD for TSO!\n");
> -		return NETDEV_TX_OK;
> -	}
> -
> -	/* Protocol checksum off-load for TCP and UDP. */
> -	if (fec_enet_clear_csum(skb, ndev)) {
> -		dev_kfree_skb_any(skb);
> -		return NETDEV_TX_OK;
> -	}
> -
> -	/* Initialize the TSO handler, and prepare the first payload */
> -	hdr_len = tso_start(skb, &tso);
> -
> -	total_len = skb->len - hdr_len;
> -	while (total_len > 0) {
> -		char *hdr;
> -
> -		index = fec_enet_get_bd_index(bdp, &txq->bd);
> -		data_left = min_t(int, skb_shinfo(skb)->gso_size, total_len);
> -		total_len -= data_left;
> -
> -		/* prepare packet headers: MAC + IP + TCP */
> -		hdr = txq->tso_hdrs + index * TSO_HEADER_SIZE;
> -		tso_build_hdr(skb, hdr, &tso, data_left, total_len == 0);
> -		ret = fec_enet_txq_put_hdr_tso(txq, skb, ndev, bdp, index);
> -		if (ret)
> -			goto err_release;
> -
> -		while (data_left > 0) {
> -			int size;
> -
> -			size = min_t(int, tso.size, data_left);
> -			bdp = fec_enet_get_nextdesc(bdp, &txq->bd);
> -			index = fec_enet_get_bd_index(bdp, &txq->bd);
> -			ret = fec_enet_txq_put_data_tso(txq, skb, ndev,
> -							bdp, index,
> -							tso.data, size,
> -							size == data_left,
> -							total_len == 0);
> -			if (ret)
> -				goto err_release;
> -
> -			data_left -= size;
> -			tso_build_data(skb, &tso, size);
> -		}
> -
> -		bdp = fec_enet_get_nextdesc(bdp, &txq->bd);
> -	}
> -
> -	/* Save skb pointer */
> -	txq->tx_skbuff[index] = skb;
> -
> -	skb_tx_timestamp(skb);
> -	txq->bd.cur = bdp;
> -
> -	/* Trigger transmission start */
> -	if (!(fep->quirks & FEC_QUIRK_ERR007885) ||
> -	    !readl(txq->bd.reg_desc_active) ||
> -	    !readl(txq->bd.reg_desc_active) ||
> -	    !readl(txq->bd.reg_desc_active) ||
> -	    !readl(txq->bd.reg_desc_active))
> -		writel(0, txq->bd.reg_desc_active);
> -
> -	return 0;
> -
> -err_release:
> -	/* TODO: Release all used data descriptors for TSO */
> -	return ret;
> -}
> -
>  static netdev_tx_t
>  fec_enet_start_xmit(struct sk_buff *skb, struct net_device *ndev)
>  {
> @@ -1190,9 +877,12 @@ fec_stop(struct net_device *ndev)
>  	}
>  }
>  
> -
>  static void
> +#if LINUX_VERSION_CODE > KERNEL_VERSION(5,6,0)
>  fec_timeout(struct net_device *ndev, unsigned int txqueue)
> +#else
> +fec_timeout(struct net_device *ndev)
> +#endif
>  {
>  	struct fec_enet_private *fep = netdev_priv(ndev);
>  
> @@ -1219,21 +909,6 @@ static void fec_enet_timeout_work(struct work_struct *work)
>  	rtnl_unlock();
>  }
>  
> -static void
> -fec_enet_hwtstamp(struct fec_enet_private *fep, unsigned ts,
> -	struct skb_shared_hwtstamps *hwtstamps)
> -{
> -	unsigned long flags;
> -	u64 ns;
> -
> -	spin_lock_irqsave(&fep->tmreg_lock, flags);
> -	ns = timecounter_cyc2time(&fep->tc, ts);
> -	spin_unlock_irqrestore(&fep->tmreg_lock, flags);
> -
> -	memset(hwtstamps, 0, sizeof(*hwtstamps));
> -	hwtstamps->hwtstamp = ns_to_ktime(ns);
> -}
> -
>  static void
>  fec_rt_tx_queue(struct net_device *ndev, u16 queue_id)
>  {
> @@ -1355,12 +1030,6 @@ fec_rt_new_rxbdp(struct net_device *ndev, struct bufdesc *bdp, struct rtskb *skb
>  	return 0;
>  }
>  
> -static bool fec_enet_copybreak(struct net_device *ndev, struct sk_buff **skb,
> -			       struct bufdesc *bdp, u32 length, bool swap)
> -{
> -	return false;
> -}
> -
>  static int
>  fec_rt_rx_queue(struct net_device *ndev, int budget, u16 queue_id)
>  {
> @@ -2649,8 +2318,10 @@ fec_enet_set_wol(struct net_device *ndev, struct ethtool_wolinfo *wol)
>  }
>  
>  static const struct ethtool_ops fec_enet_ethtool_ops = {
> +#if LINUX_VERSION_CODE > KERNEL_VERSION(5,7,0)
>  	.supported_coalesce_params = ETHTOOL_COALESCE_USECS |
>  				     ETHTOOL_COALESCE_MAX_FRAMES,
> +#endif
>  	.get_drvinfo		= fec_enet_get_drvinfo,
>  	.get_regs_len		= fec_enet_get_regs_len,
>  	.get_regs		= fec_enet_get_regs,
> @@ -2687,8 +2358,11 @@ static int fec_enet_ioctl(struct net_device *ndev, struct ifreq *rq, int cmd)
>  		return -ENODEV;
>  
>  	if (fep->bufdesc_ex) {
> +#if LINUX_VERSION_CODE > KERNEL_VERSION(5,9,0)
>  		bool use_fec_hwts = !phy_has_hwtstamp(phydev);
> -
> +#else
> +		bool use_fec_hwts = true;
> +#endif
>  		if (cmd == SIOCSHWTSTAMP) {
>  			if (use_fec_hwts)
>  				return fec_ptp_set(ndev, rq);
> @@ -2832,7 +2506,6 @@ fec_enet_alloc_rxq_buffers(struct net_device *ndev, unsigned int queue)
>  	struct fec_enet_private *fep = netdev_priv(ndev);
>  	struct fec_rt_data *frt = &fep->rtnet;
>  	unsigned int i;
> -	struct sk_buff *skb;
>  	struct rtskb *rtskb;
>  	struct bufdesc	*bdp;
>  	struct fec_enet_priv_rx_q *rxq;
> @@ -3592,7 +3265,9 @@ fec_probe(struct platform_device *pdev)
>  {
>  	struct fec_enet_private *fep;
>  	struct fec_platform_data *pdata;
> +#if LINUX_VERSION_CODE > KERNEL_VERSION(5,5,0)
>  	phy_interface_t interface;
> +#endif
>  	struct net_device *ndev;
>  	int i, irq, ret = 0, eth_id;
>  	const struct of_device_id *of_id;
> @@ -3675,16 +3350,24 @@ fec_probe(struct platform_device *pdev)
>  		phy_node = of_node_get(np);
>  	}
>  	fep->phy_node = phy_node;
> -
> +#if LINUX_VERSION_CODE > KERNEL_VERSION(5,5,0)
>  	ret = of_get_phy_mode(pdev->dev.of_node, &interface);
>  	if (ret) {
> +#else
> +	ret = of_get_phy_mode(pdev->dev.of_node);
> +	if (ret < 0) {
> +#endif
>  		pdata = dev_get_platdata(&pdev->dev);
>  		if (pdata)
>  			fep->phy_interface = pdata->phy;
>  		else
>  			fep->phy_interface = PHY_INTERFACE_MODE_MII;
>  	} else {
> +#if LINUX_VERSION_CODE > KERNEL_VERSION(5,5,0)
>  		fep->phy_interface = interface;
> +#else
> +		fep->phy_interface = ret;
> +#endif
>  	}
>  
>  	fep->clk_ipg = devm_clk_get(&pdev->dev, "ipg");
> 

Thanks, folded into the original patch so that we don't have a bisection
issue in the git history. CI is running...

Jan

-- 
Siemens AG, T RDA IOT
Corporate Competence Center Embedded Linux

