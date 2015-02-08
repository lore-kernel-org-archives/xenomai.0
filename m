Date: Sun, 8 Feb 2015 18:42:39 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Message-ID: <20150208174239.GB2014@hermes.click-hack.org>
References: <CAAg8yo2U6Djk+myWxLJ+rBqEfoy0z3pZhZQMbPDUyi17jH-B+w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAAg8yo2U6Djk+myWxLJ+rBqEfoy0z3pZhZQMbPDUyi17jH-B+w@mail.gmail.com>
Subject: Re: [Xenomai] Compatibility of PCAN PCI Express Four Channel
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Zhe Su <zhesu@usc.edu>
Cc: xenomai@xenomai.org

On Sat, Feb 07, 2015 at 05:23:33PM -0800, Zhe Su wrote:
> Dear all,
> 
> I am running xenomai 2.6.3 on Ubuntu 12.04, and I would like use a
> four-channel PCI express CAN board manufactured by PEAK system. The exact
> model name and number are PCAN-PCI Express Four Channel galvanic isolated
> IPEH-003040. I am wondering if xenomai 2.6.3 rtcan driver will be
> compatible with this board?

To check whether your board is compatible, get its ids with lspci.

Then look at:
https://git.xenomai.org/xenomai-jro.git/tree/kernel/drivers/can/sja1000/rtcan_peak_pci.c#n73

To see if the pci ids of your card are supported. If they are not,
you may be able to get the driver working for your board by adding
you board's ids to the peak_pci_tbl array, if the board is
compatible with the driver.

-- 
					    Gilles.

