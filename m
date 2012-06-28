Message-ID: <4FEC51DE.406@xenomai.org>
Date: Thu, 28 Jun 2012 14:45:18 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <D1DC5191D5CF3A45A867CD95644B923921629A6D@REXMF.intranet.epfl.ch>,
	<4FE60190.5000108@xenomai.org>
	<D1DC5191D5CF3A45A867CD95644B92392162B98F@REXMF.intranet.epfl.ch>
In-Reply-To: <D1DC5191D5CF3A45A867CD95644B92392162B98F@REXMF.intranet.epfl.ch>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] Peak PCI CAN card RTCAN problem
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Kronander Klas <klas.kronander@epfl.ch>
Cc: "xenomai@xenomai.org" <xenomai@xenomai.org>

On 06/28/2012 01:11 PM, Kronander Klas wrote:
> Jun 28 11:58:14 wam-desktop kernel: [   13.017820] Xenomai:
> xnintr_shirq_handler: IRQ17 not handled. Disabling IRQ line.
> 
> I don't know exactly what happens there or why, but it seems that IRQ
> 17 is disabled? Why and when does this happen?
> 
> On IRQ 17 there is the CAN card and two usb controllers. In the
> rc.local we try to disable the conflicting devices using:

That is a problem (maybe not what causes the issues you have, but 
something you will have to deal with eventually), see:

http://xenomai.org/index.php/FAQs#What_can_I_do_if_Xenomai_and_Linux_devices_share_the_same_IRQ.3F

-- 
					    Gilles.

