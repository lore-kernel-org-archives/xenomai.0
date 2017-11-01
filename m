MIME-Version: 1.0
In-Reply-To: <a6059dd1-27d4-15ac-a611-8f2d513299ba@xenomai.org>
References: <CADXNiGXxi3m+CK9BOGJaKdt4KzZ_KOFTdjXW3AT-cWM=YT4BHw@mail.gmail.com>
 <97a922b1-dd4c-3d63-80c7-1f71cb34dfeb@xenomai.org>
 <a6059dd1-27d4-15ac-a611-8f2d513299ba@xenomai.org>
From: Jackson Jones <jackson.jones@gmail.com>
Date: Wed, 1 Nov 2017 15:40:49 -0700
Message-ID: <CADXNiGVK+sogiLL9wcmBz5x7j79S5_caiOjnmjmqHC9Vxu3CsQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Xenomai] rtdm_safe_copy_from_user() causing mode switch
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Philippe Gerum <rpm@xenomai.org>, xenomai@xenomai.org

yes, I confirmed the page fault, I use this script:

#!/bin/bash
while true
do
    cat /proc/xenomai/sched/stat | grep demo
    sleep 1
done

exit 0

I am trying to pass an integer from a real-time app to the SPI driver. I am
changing the value of  a u32 in the device specific slave. I added an IOCTL
which I really did not want to do. I may be able to work around this. The
others in my group want to be able to change the size of the SPI message
(number of words) like they can when they used spidev. For spidev you just
update the value in the struct that is the message length and pass it back
into spidev equivalent of transfer buffers. Below is the source of my
driver. It works, I had it running for days sending a bunch of different
command (message are received by an FPGA) and checking the results. The
driver is not "finished", I only have support for a word size of 16 bit
words. I plan on being able to support all the word sizes that the hardware
does (through the configure).

/*
 * Copyright 2004-2007, 2016 Freescale Semiconductor, Inc. All Rights
Reserved.
 * Copyright (C) 2008 Juergen Beisert
 *
 * This program is free software; you can redistribute it and/or
 * modify it under the terms of the GNU General Public License
 * as published by the Free Software Foundation; either version 2
 * of the License, or (at your option) any later version.
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with this program; if not, write to the
 * Free Software Foundation
 * 51 Franklin Street, Fifth Floor
 * Boston, MA  02110-1301, USA.
 */

#include <linux/module.h>
#include <linux/slab.h>
#include <linux/err.h>
#include <linux/dma-mapping.h>
#include <linux/interrupt.h>
#include <linux/platform_device.h>
#include <linux/io.h>
#include <linux/clk.h>
#include <linux/spi/spi.h>
#include <linux/of_irq.h>
#include <linux/of_gpio.h>
#include <linux/delay.h>
#include "spi-master.h"
#include <linux/platform_data/spi-imx.h>

#define RTDM_SUBCLASS_IMX6  1

#define MXC_CSPIRXDATA        0x00
#define MXC_CSPITXDATA        0x04
#define MXC_CSPICTRL        0x08
#define MXC_CSPIINT        0x0c
#define MXC_RESET        0x1c

#define MX51_ECSPI_CTRL        0x08
#define MX51_ECSPI_CTRL_ENABLE        (1 <<  0)
#define MX51_ECSPI_CTRL_XCH        (1 <<  2)
#define MX51_ECSPI_CTRL_SMC        (1 << 3)
#define MX51_ECSPI_CTRL_MODE_MASK    (0xf << 4)
#define MX51_ECSPI_CTRL_POSTDIV_OFFSET    8
#define MX51_ECSPI_CTRL_PREDIV_OFFSET    12
#define MX51_ECSPI_CTRL_CS(cs)        ((cs) << 18)
#define MX51_ECSPI_CTRL_BL_OFFSET    20

#define MX51_ECSPI_CONFIG    0x0c
#define MX51_ECSPI_CONFIG_SCLKPHA(cs)    (1 << ((cs) +  0))
#define MX51_ECSPI_CONFIG_SCLKPOL(cs)    (1 << ((cs) +  4))
#define MX51_ECSPI_CONFIG_SBBCTRL(cs)    (1 << ((cs) +  8))
#define MX51_ECSPI_CONFIG_SSBPOL(cs)    (1 << ((cs) + 12))
#define MX51_ECSPI_CONFIG_SCLKCTL(cs)    (1 << ((cs) + 20))

#define MX51_ECSPI_INT        0x10
#define MX51_ECSPI_INT_TEEN        (1 <<  0)
#define MX51_ECSPI_INT_RREN        (1 <<  3)
#define MX51_ECSPI_INT_TCEN             (1 << 7)

#define MX51_ECSPI_DMA      0x14
#define MX51_ECSPI_DMA_TX_WML_OFFSET    0
#define MX51_ECSPI_DMA_TX_WML_MASK    0x3F
#define MX51_ECSPI_DMA_RX_WML_OFFSET    16
#define MX51_ECSPI_DMA_RX_WML_MASK    (0x3F << 16)
#define MX51_ECSPI_DMA_RXT_WML_OFFSET    24
#define MX51_ECSPI_DMA_RXT_WML_MASK    (0x3F << 24)

#define MX51_ECSPI_DMA_TEDEN_OFFSET    7
#define MX51_ECSPI_DMA_RXDEN_OFFSET    23
#define MX51_ECSPI_DMA_RXTDEN_OFFSET    31

#define MX51_ECSPI_STAT        0x18
#define MX51_ECSPI_STAT_RR        (1 <<  3)
#define MX51_ECSPI_STAT_TE  0x01
#define MX51_ECSPI_STAT_TF  (1 << 2)

// defines for test register
#define MX51_ECSPI_TESTREG  0x20
#define MX51_ECSPI_TESTREG__TXCNT     0x00 // num words in TX counter
#define MX51_ECSPI_TESTREG__RXCNT     0x08 // num words in RX counter
#define MX51_ECSPI_TESTREG_LBC  BIT(31) // 1 enable loopback, 0 disable
loopback

/* generic defines to abstract from the different register layouts */
#define MXC_INT_RR    (1 << 0) /* Receive data ready interrupt */
#define MXC_INT_TE    (1 << 1) /* Transmit FIFO empty interrupt */
#define MXC_INT_TCEN    (1 << 7)   /* Transfer complete */

/* The maximum  bytes that a sdma BD can transfer.*/
#define MAX_SDMA_BD_BYTES  (1 << 15)

// defines for DMA, we are not ready for that yet.
/* 3 Sec for 1MB or less than 1MB, else change with the transfer length */
#define IMX_DEFAULT_DMA_TIMEOUT (msecs_to_jiffies(3000))
#define IMX_DMA_TIMEOUT(len) ((len < 0x100000) ? IMX_DEFAULT_DMA_TIMEOUT : \
                len * IMX_DEFAULT_DMA_TIMEOUT / 0x100000)

#define DRIVER_NAME "spi_imx"

// defines, not part of spi.h
#define SPI_CS_ACTIVE   1
#define SPI_CS_INACTIVE 0

// Defined this as a constant instead of a function, since all
// the imx6 variants have TX/RX sizes of 64
#define  spi_imx6_fifosize 64

// RJJ defines to turn on TX or RX debug messages
//#define TXDBG 1
//#define RXDBG 1

#define HACK_TRACK 6 //RJJ remove after testing

static int HackCount = 0; //RJJ remove after testing
static int SubHackCount = 0;  //RJJ remove after testing

//static u32 new_size;

// Xenomai master device struct
struct spi_master_imx6
{
    struct rtdm_spi_master master;
    void __iomem *regs;
    struct clk *clk;
    struct clk *clk_per;
    struct clk *clk_ipg;
    unsigned long clk_hz;
    rtdm_irq_t irqh;
    const u8 *tx_buf;
    u8 *rx_buf;
    int tx_len;
    int rx_len;
    rtdm_event_t transfer_done;
    u32 count; // RJJ not checked, but keeping just in case.
};

// Xenomai slave device struct
struct spi_slave_imx6
{
    struct rtdm_spi_remote_slave slave;
    void *io_virt;
    void *tx_buf;  //RJJ This kind of sucks
    dma_addr_t io_dma;
    //dma_addr_t new_length;
    size_t io_len;
    u32 transfer_length;
};

static void imx6_intctrl(struct spi_master_imx6 *spim, int enable)
{
    unsigned val = 0;

    if (enable & MXC_INT_TE)
        val |= MX51_ECSPI_INT_TEEN;

    if (enable & MXC_INT_RR)
        val |= MX51_ECSPI_INT_RREN;

    if (enable & MXC_INT_TCEN)
        val |= MX51_ECSPI_INT_TCEN;

    writel(val, spim->regs + MX51_ECSPI_INT);
}

static inline struct spi_slave_imx6 *to_slave_imx6(struct
rtdm_spi_remote_slave *slave)
{
    return container_of(slave, struct spi_slave_imx6, slave);
}

static inline struct spi_master_imx6 *to_master_imx6(struct
rtdm_spi_remote_slave *slave)
{
    return container_of(slave->master, struct spi_master_imx6, master);
}

static inline struct device *master_to_kdev(struct rtdm_spi_master *master)
{
    return &master->kmaster->dev;
}

static int mx51_ecspi_rx_available(struct spi_master_imx6 *spim)
{
    //return readl(spim->regs + MX51_ECSPI_STAT) & MX51_ECSPI_STAT_RR;
    u32 stat = readl(spim->regs + MX51_ECSPI_STAT);
    stat &= MX51_ECSPI_STAT_RR;
    return stat;
}

static inline int mx51_ecspi_tx_not_full(struct spi_master_imx6 *spim)
{
    u32 stat = readl(spim->regs + MX51_ECSPI_STAT);
    stat &= MX51_ECSPI_STAT_TF;
    if (stat)
        return 0;
    else
        return 1;
}

static inline int mx51_ecspi_tx_empty(struct spi_master_imx6 *spim)
{
    u32 stat = readl(spim->regs + MX51_ECSPI_STAT);
    stat &= MX51_ECSPI_STAT_TE;
    if (stat)
        return 1;
    else
        return 0;
}

static inline int mx51_ecspi_tx_done(struct spi_master_imx6 *spim)
{
    u32 ctrl = readl(spim->regs + MX51_ECSPI_CTRL);
    ctrl &= MX51_ECSPI_CTRL_XCH;
    if (ctrl)
        return 0;
    else
        return 1;
}

static inline u32 mx51_ecspi_rx_word_count(struct spi_master_imx6 *spim)
{
    u32 count = 0;
    count = readl(spim->regs + MX51_ECSPI_TESTREG);
    count = ((count & 0x00007f00) >> MX51_ECSPI_TESTREG__RXCNT);
    return count;
}

static inline void trigger(struct spi_master_imx6 *spim)
{
    u32 reg = readl(spim->regs + MX51_ECSPI_CTRL);
    reg |= (MX51_ECSPI_CTRL_XCH);
    writel(reg, spim->regs + MX51_ECSPI_CTRL);
}

static inline u32 imx6_rx(struct spi_master_imx6 *spim)
{
    u16 data = readl(spim->regs + MXC_CSPIRXDATA);
    return data;
}

static inline void imx6_tx(struct spi_master_imx6 *spim)
{
    u16 data = 0;
    if (spim->tx_buf)
    {
        data = *(u16 *)spim->tx_buf;
    }
    writel(data, spim->regs + MXC_CSPITXDATA);
}

static inline void imx6_rx_fifo(struct spi_master_imx6 *spim)
{
    u16 data = 0;

    while (spim->rx_len > 0 && mx51_ecspi_rx_available(spim))
    {
        data = imx6_rx(spim);
        if (spim->rx_buf)
        {
            *(u16 *)spim->rx_buf = data;
#ifdef RXDBG
            pr_err("rx = 0x%.2X  0x%.2X rx_len = %u rx_buf = 0x%X\n",
                    *spim->rx_buf, *(spim->rx_buf + 1),
                    spim->rx_len, (unsigned int)(spim->rx_buf));
#endif
            spim->rx_buf += sizeof(u16);
        }
        spim->rx_len--;
        spim->count--;
    }
}

static inline void imx6_tx_fifo(struct spi_master_imx6 *spim)
{
    if (mx51_ecspi_tx_empty(spim) && mx51_ecspi_tx_done(spim) &&
(spim->tx_len) > 0)
    {
#ifdef TXDBG

pr_err("<%d>-------------------------------------------------------<%d>\n",
HackCount, HackCount);
#endif
        spim->count = 0;

        while (spim->tx_len > 0 && mx51_ecspi_tx_not_full(spim))
        {
            imx6_tx(spim);
#ifdef TXDBG
            pr_err("tx = 0x%.2X  0x%.2X  tx_len = %u tx_buf = 0x%X\n",
                    *spim->tx_buf, *(spim->tx_buf + 1),
                    spim->tx_len, (unsigned int)(spim->tx_buf));
#endif
            spim->tx_buf += sizeof(u16);
            spim->tx_len--;
            spim->count++; // words transmitted
        }
#ifdef TXDBG
        pr_err("\n");
#endif
        trigger(spim);
        imx6_intctrl(spim, MXC_INT_TE);
        SubHackCount++;

        if (SubHackCount == HACK_TRACK)
        {
            SubHackCount = 0;
            HackCount++;
        }
    }
}

static void imx6_reset(struct spi_master_imx6 *spim)
{
    /* drain RX */
    while (mx51_ecspi_rx_available(spim))
        readl(spim->regs + MXC_CSPIRXDATA);
}

static void inline _reset_block(struct spi_master_imx6 *spim)
{
    u32 CONTROL_REG;

    CONTROL_REG = 0x00000000;
    writel(CONTROL_REG, spim->regs + MX51_ECSPI_CTRL);

    CONTROL_REG = 0x00000001;
    writel(CONTROL_REG, spim->regs + MX51_ECSPI_CTRL);
}

static int spi_imx_isr(rtdm_irq_t *irqh)
{
    u32 inttype = 0;
    struct spi_master_imx6 *spim;
    spim = rtdm_irq_get_arg(irqh, struct spi_master_imx6);

    inttype = readl(spim->regs + MX51_ECSPI_INT);

    switch (inttype)
    {
        case MX51_ECSPI_INT_TEEN :
            //pr_err("isr TEEN");
            if (mx51_ecspi_tx_done(spim))
            {
                imx6_intctrl(spim, 0);
                rtdm_event_signal(&spim->transfer_done);
                imx6_intctrl(spim, MXC_INT_RR);
            }
            break;

        case MX51_ECSPI_INT_RREN :
            //pr_err("isr RREN");
            if (mx51_ecspi_rx_available(spim))
            {
                imx6_intctrl(spim, 0);
                imx6_rx_fifo(spim);
            }
            break;

        default :
            pr_err("isr Unhandled IRQ Type!!");
            break;
    }

    imx6_tx_fifo(spim);

    return RTDM_IRQ_HANDLED;
}

static unsigned int mx51_ecspi_clkdiv(unsigned int fin, unsigned int fspi,
                                      unsigned int *fres)
{
    /*
     * there are two 4-bit dividers, the pre-divider divides by
     * $pre, the post-divider by 2^$post
     */
    unsigned int pre, post;

    if (unlikely(fspi > fin))
        return 0;

    post = fls(fin) - fls(fspi);
    if (fin > fspi << post)
        post++;

    /* now we have: (fin <= fspi << post) with post being minimal */
    post = max(4U, post) - 4;
    if (unlikely(post > 0xf))
    {
        pr_err("%s: cannot set clock freq: %u (base freq: %u)\n",
                __func__, fspi, fin);
        return 0xff;
    }

    pre = DIV_ROUND_UP(fin, fspi << post) - 1;

    pr_debug("%s: fin: %u, fspi: %u, post: %u, pre: %u\n",
            __func__, fin, fspi, post, pre);

    /* Resulting frequency for the SCLK line. */
    *fres = (fin / (pre + 1)) >> post;

    return (pre << MX51_ECSPI_CTRL_PREDIV_OFFSET) |
            (post << MX51_ECSPI_CTRL_POSTDIV_OFFSET);
}

static int imx6_configure(struct rtdm_spi_remote_slave *slave)
{
    struct spi_master_imx6 *spim = to_master_imx6(slave);
    struct rtdm_spi_config *config = &slave->config;

    u32 ctrl = MX51_ECSPI_CTRL_ENABLE, cfg = 0;
    u32 clk = config->speed_hz, delay, reg;
    _reset_block(spim);

    HackCount = 0;
    SubHackCount = 0;

    /*
     * The hardware seems to have a race condition when changing modes. The
     * current assumption is that the selection of the channel arrives
     * earlier in the hardware than the mode bits when they are written at
     * the same time.
     * So set master mode for all channels as we do not support slave mode.
     */
    ctrl |= MX51_ECSPI_CTRL_MODE_MASK;

    /* set clock speed */
    ctrl |= mx51_ecspi_clkdiv(spim->clk_hz, config->speed_hz, &clk);

    /* set chip select to use */
    ctrl |= MX51_ECSPI_CTRL_CS(slave->chip_select);

    ctrl |= (config->bits_per_word - 1) << MX51_ECSPI_CTRL_BL_OFFSET;

    cfg |= MX51_ECSPI_CONFIG_SBBCTRL(slave->chip_select);

    if (config->mode & SPI_CPHA)
        cfg |= MX51_ECSPI_CONFIG_SCLKPHA(slave->chip_select);

    if (config->mode & SPI_CPOL)
    {
        cfg |= MX51_ECSPI_CONFIG_SCLKPOL(slave->chip_select);
        cfg |= MX51_ECSPI_CONFIG_SCLKCTL(slave->chip_select);
    }
    if (config->mode & SPI_CS_HIGH)
        cfg |= MX51_ECSPI_CONFIG_SSBPOL(slave->chip_select);
    else
        cfg |= ~MX51_ECSPI_CONFIG_SSBPOL(slave->chip_select);

    reg = readl(spim->regs + MX51_ECSPI_TESTREG);

    if (config->mode & SPI_LOOP)
    {
        reg |= MX51_ECSPI_TESTREG_LBC;
        pr_err("In Loopback");
    }
    else
    {
        reg &= ~MX51_ECSPI_TESTREG_LBC;
        pr_err("Not in Loopback");
    }

    writel(ctrl, spim->regs + MX51_ECSPI_CTRL);
    writel(cfg, spim->regs + MX51_ECSPI_CONFIG);
    writel(reg, spim->regs + MX51_ECSPI_TESTREG);

    // Disable DMA for now
    writel(0x00, spim->regs + MX51_ECSPI_DMA);

    /*
     * Wait until the changes in the configuration register CONFIGREG
     * propagate into the hardware. It takes exactly one tick of the
     * SCLK clock, but we will wait two SCLK clock just to be sure. The
     * effect of the delay it takes for the hardware to apply changes
     * is noticable if the SCLK clock run very slow. In such a case, if
     * the polarity of SCLK should be inverted, the GPIO ChipSelect might
     * be asserted before the SCLK polarity changes, which would disrupt
     * the SPI communication as the device on the other end would consider
     * the change of SCLK polarity as a clock tick already.
     */
    delay = (2 * 1000000) / clk;
    if (likely(delay < 10))    /* SCLK is faster than 100 kHz */
        udelay(delay);
    else            /* SCLK is _very_ slow */
        usleep_range(delay, delay + 10);

    return 0;
}

static void imx6_chip_select(struct rtdm_spi_remote_slave *slave, bool
is_active)
{
    struct rtdm_spi_config *config = &slave->config;
    int gpio = slave->cs_gpio;
    int active = is_active != SPI_CS_INACTIVE;
    int dev_is_lowactive = !(config->mode & SPI_CS_HIGH);

    if (!gpio_is_valid(gpio))
    {
        return;
    }
    gpio_set_value(gpio, dev_is_lowactive ^ active);
}

static int do_transfer_irq(struct rtdm_spi_remote_slave *slave)
{
    struct spi_master_imx6 *spim = to_master_imx6(slave);
    int ret = 0;
    u32 cs;

    cs = readl(spim->regs + MX51_ECSPI_CTRL);

    if (gpio_is_valid(slave->cs_gpio))
    {
        imx6_tx_fifo(spim);
    }

    ret = rtdm_event_wait(&spim->transfer_done);
    if (ret)
    {
        imx6_reset(spim);
        return ret;
    }
    return 0;
}

static int imx6_transfer_iobufs(struct rtdm_spi_remote_slave *slave)
{
    struct spi_master_imx6 *spim = to_master_imx6(slave);
    struct spi_slave_imx6 *imx = to_slave_imx6(slave);

    if (imx->io_len == 0)
        return -EINVAL;    /* No I/O buffers set. */

    spim->tx_len = imx->transfer_length;
    spim->rx_len = imx->transfer_length;
    spim->rx_buf = imx->io_virt;
    spim->tx_buf = imx->tx_buf;

    return do_transfer_irq(slave);
}

static void imx6_change_xfer_size(struct rtdm_spi_remote_slave *slave,
                                  u32 new_size)
{
#if 0
    struct spi_slave_imx6 *imx = to_slave_imx6(slave);
    if (imx->new_size == NULL)
    {

    }
    imx->transfer_length = new_size;
#endif
}

static ssize_t imx6_read(struct rtdm_spi_remote_slave *slave,
                         void *rx, size_t len)
{
    struct spi_master_imx6 *spim = to_master_imx6(slave);

    //pr_err("imx6_read->len = %u\n", len);
    spim->tx_len = len;
    spim->rx_len = len;
    spim->tx_buf = NULL;
    spim->rx_buf = rx;

    return do_transfer_irq(slave) ?: len;
}

static ssize_t imx6_write(struct rtdm_spi_remote_slave *slave,
                          const void *tx, size_t len)
{
    struct spi_master_imx6 *spim = to_master_imx6(slave);

    //pr_err("imx6_write->len = %u\n", len);
    spim->tx_len = len;
    spim->rx_len = len;
    spim->tx_buf = tx;
    spim->rx_buf = NULL;

    return do_transfer_irq(slave) ?: len;
}

static int set_iobufs(struct spi_slave_imx6 *imx, size_t len)
{
    struct rtdm_spi_remote_slave *slave = &imx->slave;
    struct rtdm_spi_config *config = &slave->config;

    dma_addr_t dma;
    void *p;

    if (len == 0)
        return -EINVAL;

    // The L1 cache align sizes up to 64 (which is the size of the
    // Cortex-A9 L1 cache line).
    len = L1_CACHE_ALIGN(len) * 2 * (config->bits_per_word / 8);

    if (len == imx->io_len)
        return 0;

    if (imx->io_len)
        return -EINVAL;    /* I/O buffers may not be resized. */

    /*
     * Since we need the I/O buffers to be set for starting a
     * transfer, there is no need for serializing this routine and
     * transfer_iobufs(), provided io_len is set last.
     *
     * NOTE: We don't need coherent memory until we actually get
     * DMA transfers working, this code is a bit ahead of
     * schedule.
     *
     * Revisit: this assumes DMA mask is 4Gb.
     */

    p = dma_alloc_coherent(NULL, len, &dma, GFP_KERNEL);
    if (p == NULL)
        return -ENOMEM;

    imx->io_dma = dma;
    imx->io_virt = p;
    smp_mb();
    /*
     * May race with transfer_iobufs(), must be assigned after all
     * the rest is set up, enforcing a membar.
     */
    imx->io_len = len;

    return 0;
}

static int imx6_set_iobufs(struct rtdm_spi_remote_slave *slave,
                           struct rtdm_spi_iobufs *p)
{
    struct spi_slave_imx6 *imx = to_slave_imx6(slave);
    int ret;

    imx->transfer_length = p->io_len;

    ret = set_iobufs(imx, p->io_len);
    if (ret)
        return ret;

    p->i_offset = 0;
    p->o_offset = imx->io_len / 2;
    p->map_len = imx->io_len;
    imx->tx_buf = imx->io_virt + p->o_offset;

    //@@@RJJ ma

    return 0;
}

static int imx6_mmap_iobufs(struct rtdm_spi_remote_slave *slave,
                            struct vm_area_struct *vma)
{
    struct spi_slave_imx6 *imx = to_slave_imx6(slave);

    /*
     * dma_alloc_coherent() delivers non-cached memory, make sure
     * to return consistent mapping attributes. Typically, mixing
     * memory attributes across address spaces referring to the
     * same physical area is architecturally wrong on ARM.
     */
    vma->vm_page_prot = pgprot_noncached(vma->vm_page_prot);

    return rtdm_mmap_kmem(vma, imx->io_virt);
}

static void imx6_mmap_release(struct rtdm_spi_remote_slave *slave)
{
    struct spi_slave_imx6 *imx = to_slave_imx6(slave);

    dma_free_coherent(NULL, imx->io_len, imx->io_virt, imx->io_dma);
    imx->io_len = 0;
}

static int find_cs_gpio(struct spi_device *spi, struct rtdm_spi_master
*master)
{
    struct spi_master *kmaster;
    struct spi_imx_master *mxc_platform_info;
    struct platform_device *pdev;
    struct device_node *np;
    int cs_gpio = 0;
    int i, num_cs;
    int ret = 0;

    kmaster = master->kmaster;
    pdev = to_platform_device(&kmaster->dev);
    np = pdev->dev.of_node;
    mxc_platform_info = dev_get_platdata(&kmaster->dev);

    if (!np && !mxc_platform_info)
    {
        dev_err(&pdev->dev, "can't get the platform data\n");
        return -EINVAL;
    }

    ret = of_property_read_u32(np, "fsl,spi-num-chipselects", &num_cs);
    if (ret < 0)
    {
        if (mxc_platform_info)
            num_cs = mxc_platform_info->num_chipselect;
        else
            return ret;
    }

    for (i = 0; i < kmaster->num_chipselect; i++)
    {
        cs_gpio = of_get_named_gpio(np, "cs-gpios", i);
        if (!gpio_is_valid(cs_gpio) && mxc_platform_info)
        {
            cs_gpio = mxc_platform_info->chipselect[i];
        }
        if (!gpio_is_valid(cs_gpio))
            continue;

        spi->chip_select = i;
        spi->cs_gpio = cs_gpio;
    }

    ret = gpio_direction_output(spi->cs_gpio, (spi->mode & SPI_CS_HIGH) ? 0
: 1);
    if (ret)
    {
        dev_err(&spi->dev, "could not set CS%i gpio %i as output: %i",
                           spi->chip_select, spi->cs_gpio, ret);
        return ret;
    }
    gpio_set_value(spi->cs_gpio, (spi->mode & SPI_CS_HIGH) ? 0 : 1);

    return 0;
}

static struct rtdm_spi_remote_slave *imx6_attach_slave(struct
rtdm_spi_master *master,
                                                       struct spi_device
*spi)
{
    struct spi_slave_imx6 *imx;
    int ret;

    if (spi->chip_select > 3)
    {
        dev_err(&spi->dev, "%s: only two native chip-selects are
supported\n", __func__);
        return ERR_PTR(-EINVAL);
    }

    ret = find_cs_gpio(spi, master);
    if (ret)
    {
        pr_err("got an error from find_cs_gpio: %d\n", ret);
        return ERR_PTR(ret);
    }

    imx = kzalloc(sizeof(*imx), GFP_KERNEL);
    if (imx == NULL)
    {
        return ERR_PTR(-ENOMEM);
    }

    ret = rtdm_spi_add_remote_slave(&imx->slave, master, spi);
    if (ret)
    {
        dev_err(&spi->dev, "%s: failed to attach slave\n", __func__);
        kfree(imx);
        return ERR_PTR(ret);
    }

    return &imx->slave;
}

static void imx6_detach_slave(struct rtdm_spi_remote_slave *slave)
{
    struct spi_slave_imx6 *imx = to_slave_imx6(slave);

    rtdm_spi_remove_remote_slave(slave);
    kfree(imx);
}

static int inline imx6_prepare_clocks(struct platform_device *pdev,
                                      struct spi_master_imx6 *spim)
{
    int ret;

    spim->clk = devm_clk_get(&pdev->dev, NULL);
    if (IS_ERR(spim->clk))
    {
        ret = PTR_ERR(spim->clk);
        pr_err("Can't get clk\n");
        return -1;
    }

    spim->clk_ipg = devm_clk_get(&pdev->dev, "ipg");
    if (IS_ERR(spim->clk_ipg))
    {
        ret = PTR_ERR(spim->clk_ipg);
        pr_err("Can't get clk_ipg\n");
        return -1;
    }

    spim->clk_per = devm_clk_get(&pdev->dev, "per");
    if (IS_ERR(spim->clk_per))
    {
        ret = PTR_ERR(spim->clk_per);
        pr_err("Can't get clk_per\n");
        return -1;
    }

    ret = clk_prepare_enable(spim->clk);
    if(ret)
    {
        pr_err("unable to prepair clk\n");
        return -1;
    }

    ret = clk_prepare_enable(spim->clk_per);
    if(ret)
    {
        pr_err("unable to prepair clk_per\n");
        return -1;
    }
    ret = clk_prepare_enable(spim->clk_ipg);
    if(ret)
    {
        pr_err("unable to prepair clk_ipg\n");
        return -1;
    }

    return 0;
}

static struct rtdm_spi_master_ops imx6_master_ops =
{
    .configure = imx6_configure,
    .chip_select = imx6_chip_select,
    .set_iobufs = imx6_set_iobufs,
    .mmap_iobufs = imx6_mmap_iobufs,
    .mmap_release = imx6_mmap_release,
    .transfer_iobufs = imx6_transfer_iobufs,
    .change_xfer_size = imx6_change_xfer_size,
    .write = imx6_write,
    .read = imx6_read,
    .attach_slave = imx6_attach_slave,
    .detach_slave = imx6_detach_slave,
};

static int spi_imx_probe(struct platform_device *pdev)
{
    // Linux devices
    struct spi_master *kmaster;

    // Xenomai devices
    struct spi_master_imx6 *spim;
    struct rtdm_spi_master *master;
    struct resource *r;
    int ret = 0, irq;

    dev_dbg(&pdev->dev, "%s: entered\n", __func__);

    master = rtdm_spi_alloc_master(&pdev->dev, struct spi_master_imx6,
master);
    if (master == NULL)
        return -ENOMEM;

    master->subclass = RTDM_SUBCLASS_IMX6;
    master->ops = &imx6_master_ops;
    platform_set_drvdata(pdev, master);
    kmaster = master->kmaster;

    kmaster->mode_bits = SPI_CPOL | SPI_CPHA | SPI_CS_HIGH;
    kmaster->bits_per_word_mask = SPI_BPW_MASK(16);
    kmaster->dev.of_node = pdev->dev.of_node;
    kmaster->bus_num = pdev->id;

    spim = container_of(master, struct spi_master_imx6, master);
    rtdm_event_init(&spim->transfer_done, 0);

    r = platform_get_resource(pdev, IORESOURCE_MEM, 0);
    spim->regs = devm_ioremap_resource(&pdev->dev, r);
    if (IS_ERR(spim->regs))
    {
        dev_err(&pdev->dev, "%s: cannot map I/O memory\n", __func__);
        ret = PTR_ERR(spim->regs);
        goto fail;
    }

    // Get irq
    irq = irq_of_parse_and_map(pdev->dev.of_node, 0);
    if (irq <= 0)
    {
        ret = irq ?: -ENODEV;
        goto fail;
    }

    ret = rtdm_irq_request(&spim->irqh, irq, spi_imx_isr, 0,
dev_name(&pdev->dev), spim);
    if (ret)
    {
        dev_err(&pdev->dev, "%s: cannot request IRQ%d\n", __func__, irq);
        goto fail;
    }

    ret = rtdm_spi_add_master(&spim->master);
    if (ret)
    {
        dev_err(&pdev->dev, "%s: failed to add master\n", __func__);
        goto fail;
    }

    if (imx6_prepare_clocks(pdev, spim))
    {
        goto fail_unclk;
    }

    // Set clock speed
    spim->clk_hz = clk_get_rate(spim->clk_per);

    // Clears all RX
    imx6_reset(spim);

    // masks all interrupts
    imx6_intctrl(spim, 0);

    return 0;

fail_unclk:
    clk_disable_unprepare(spim->clk);
    clk_disable_unprepare(spim->clk_ipg);
    clk_disable_unprepare(spim->clk_per);
fail:
    spi_master_put(kmaster);

    return ret;
}

static int spi_imx_remove(struct platform_device *pdev)
{
    struct rtdm_spi_master *master = platform_get_drvdata(pdev);
    struct spi_master_imx6 *spim;

    dev_dbg(&pdev->dev, "%s: entered\n", __func__);

    spim = container_of(master, struct spi_master_imx6, master);

    imx6_reset(spim);

    rtdm_irq_free(&spim->irqh);

    clk_disable_unprepare(spim->clk);

    rtdm_spi_remove_master(master);

    return 0;
}

static const struct of_device_id imx6_spi_match[] =
{
    {
        .compatible = "fsl,imx51-ecspi",
    },
    { /* Sentinel */ },
};
MODULE_DEVICE_TABLE(of, imx6_spi_match);

static struct platform_driver spi_imx_driver =
{
    .driver =
    {
        .name = DRIVER_NAME,
        .of_match_table = imx6_spi_match,
    },
    .probe = spi_imx_probe,
    .remove = spi_imx_remove,
};
module_platform_driver(spi_imx_driver);

MODULE_LICENSE("GPL");


On Wed, Nov 1, 2017 at 2:19 PM, Philippe Gerum <rpm@xenomai.org> wrote:

> On 11/01/2017 10:14 PM, Philippe Gerum wrote:
> > On 10/07/2017 03:56 AM, Jackson Jones wrote:
> >> I noticed that when I call rtdm_safe_copy_from_user() it causes a mode
> >> switch. I am looking to pass a uint32_t (u32 in kernel space) from
> >> user-space to a rtdm driver.
> >>
> >> Is there a way of doing this that avoids a mode switch. I am doing this
> in
> >> an rtdm spi driver for the imx6. It is used to change the transfer size
> >> (number of words) for the next call to transfer_iobufs (using the
> >> SPI_RTIOC_TRANSFER ioctl).
> >>
> >
> > The mode switch is most likely caused by an access fault taken by the
> > CPU. Is /proc/xenomai/fault confirming this?
> >
>
> More precisely, this is most likely a fault due to a page table miss
> which cannot be resolved on the fly by a simple page table fixup then
> return. Instead, the whole thing has to go through the regular kernel
> page fault handler, which requires Cobalt to switch to secondary mode
> first.
>
> --
> Philippe.
>
