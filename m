Date: Fri, 20 Feb 2015 07:29:47 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Message-ID: <20150220062947.GC16978@hermes.click-hack.org>
References: <CAAg8yo2U6Djk+myWxLJ+rBqEfoy0z3pZhZQMbPDUyi17jH-B+w@mail.gmail.com>
 <20150208174239.GB2014@hermes.click-hack.org>
 <CAAg8yo2Nx-PFM3Fm5bjeCfROrNq5yaicx-ewcQnj9qfVNHFErA@mail.gmail.com>
 <20150220052215.GB16978@hermes.click-hack.org>
 <CAAg8yo2nAj1Bk+J15jms8goZqFP7SASoo-h9kzORZwZM_5snEw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAAg8yo2nAj1Bk+J15jms8goZqFP7SASoo-h9kzORZwZM_5snEw@mail.gmail.com>
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

On Thu, Feb 19, 2015 at 10:26:44PM -0800, Zhe Su wrote:
> Dear Gilles,
> 
> Thanks for your prompt reply. In my last email, it already included the pci
> ids, shown in the bold letters:
> 
> lspci -nn
> 02:00.0 Network controller [0280]: PEAK-System Technik GmbH PCAN-PCI
> CAN-Bus controller *[001c:0001]* (rev 02)
> 22:00.0 Network controller [0280]: PEAK-System Technik GmbH Device
> *[001c:0003]* (rev 02)
> 
> 001c is the manufacturer id, and 0001 and 0003 is the 2-channel PCI
> and 4-channel
> PCI express, respectively.

Indeed. Anyway, what is the problem exactly ? "It does not work"
does not give much details.

-- 
					    Gilles.

