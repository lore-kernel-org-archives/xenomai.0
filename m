Message-ID: <51A9050B.3060206@xenomai.org>
Date: Fri, 31 May 2013 22:16:11 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <CAN0BPY_SzMoNrgOF2fBwrMA=7scopqTKPC+pxkk12wtGMsWdGQ@mail.gmail.com>	<CAN0BPY_gK3-_qLZVpq1hgoGWqqRRH++fRAcTdReo3ojf6U8Hfg@mail.gmail.com>	<51A88783.100@xenomai.org>
	<CAN0BPY_Gicv-2em8mqbjupC=9VFTgTLgP-djQrjvi1c8PcM1yA@mail.gmail.com>
In-Reply-To: <CAN0BPY_Gicv-2em8mqbjupC=9VFTgTLgP-djQrjvi1c8PcM1yA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] Fwd: Fwd: SMI problems with 2.6.2.1 and last weekends
 git	version
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: John Candlish <john.candlish@gmail.com>
Cc: xenomai@xenomai.org

On 05/31/2013 04:03 PM, John Candlish wrote:

> Thank you for you timely reply.  I'll check again with another of the same
> computer+bios as well as a core2 ICH7 machine.
> 
> I should mention that the particular machine tested does respond to the
> rtai_smi.ko module, in that the presence of that module significantly
> reduces (eliminates actually) the periodic smi latencies.
> 
> It is curious.  I'll look again.


Well, the RTAI module does not check if clearing the SMI bit actually
work, this was added later in Xenomai. So, I would say the result is the
same, only you do not see it.

Another difference is that the RTAI module does not do the
"pci_device_put" right away, which prevents loading other kernel modules
which would like to request the LPC PCI device. I doubt that could make
a difference though.

-- 
                                                                Gilles.

