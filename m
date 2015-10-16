References: <5620CA75.7010100@sigmatek.at>
From: Philippe Gerum <rpm@xenomai.org>
Message-ID: <5620CDE1.2040806@xenomai.org>
Date: Fri, 16 Oct 2015 12:13:53 +0200
MIME-Version: 1.0
In-Reply-To: <5620CA75.7010100@sigmatek.at>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] RTDM SPI Driver for ARM
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: johann.obermayr@sigmatek.at, "xenomai@xenomai.org" <xenomai@xenomai.org>

On 10/16/2015 11:59 AM, Johann Obermayr wrote:
> Hello,
> 
> i search a RTDM SPI for the Freescale imx6 ARM Processor.
> 
> i only found "Xenomai RT SPI Driver for Blackfin
> <https://web.archive.org/web/20071016064104/http://www.rcode.net/blog/tlaurenzo/2007/04/14/xenomai-rt-spi-driver-for-blackfin/>"
> with
> http://www.rcode.net/blogattach/dist/rtspi-20070414.tgz
> <https://web.archive.org/web/20071016064104/http://www.rcode.net/blogattach/dist/rtspi-20070414.tgz>
> 
> 
> But the tgz is not available any more.
> Any idea , where i can found this driver ?
> Or has any an exist code.

I'm not aware of any published code, but knowing a bit about the eCSPI
module on the imx6 platform, it should not be a big deal to implement a
basic SPI master over RTDM, with DMA-based transfers.

-- 
Philippe.

