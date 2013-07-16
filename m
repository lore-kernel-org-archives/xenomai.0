Message-ID: <51E55AB0.8070600@siemens.com>
Date: Tue, 16 Jul 2013 16:37:36 +0200
From: Jan Kiszka <jan.kiszka@siemens.com>
MIME-Version: 1.0
References: <51E4F63A.7080203@163.com>
In-Reply-To: <51E4F63A.7080203@163.com>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] general kernel functions in RTDM?
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: aking_jin <jinxin16897123@163.com>
Cc: "xenomai@xenomai.org" <xenomai@xenomai.org>

On 2013-07-16 09:28, aking_jin wrote:
> Hi,all
> What should be take care of while using general kernel functions in
> RTDM? for example: dma operation, GPIO operation and etc .

Depends on their usage context. You can normally use Linux service while
the driver is in Linux context. But once you run over an RT IRQ, RT
timer handler or RT thread (kernel/userspace), most Linux services
become taboo.

DMA mapping/unmapping, e.g., may still work if it involves no hardware
or software IOMMU, otherwise it is required to premap the regions during
setup over a Linux context. GPIO may involve Linux code that
synchronizes against concurrent access. If that code was hardened as
part of the I-pipe patch, you are safe again.

Hope this helped to get the general picture. Detailed answers depend on
what you do, and on which hardware.

Jan

-- 
Siemens AG, Corporate Technology, CT RTC ITP SES-DE
Corporate Competence Center Embedded Linux

