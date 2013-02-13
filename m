In-Reply-To: <511BD801.7060304@gmail.com>
References: <OF682F5C70.F8F7AA50-ON85257AF1.005F580A-85257AF1.005F580C@aanddtech.com>
	<50F3DD9A.9050306@gmail.com> <5117AD5A.1080504@xenomai.org>
	<OF7193B3EB.20F44A56-ON85257B11.006195D9-85257B11.0062A0F5@aanddtech.com>
	<511BD801.7060304@gmail.com>
MIME-Version: 1.0
Message-ID: <OF7BC2A1E9.4D41277B-ON85257B11.00662217-85257B11.006671E8@aanddtech.com>
From: mfornero@aanddtech.com
Date: Wed, 13 Feb 2013 13:38:58 -0500
Content-Type: text/plain; charset="US-ASCII"
Subject: Re: [Xenomai] Porting Ipipe to new ARM SoC (Xilinx Zynq)
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Stefan Roese <stefan.roese@gmail.com>
Cc: Xenomai@xenomai.org

Stefan Roese <stefan.roese@gmail.com> wrote on 02/13/2013 01:14:25 PM:

> Thanks for this update. This solves the twd issue (boot hangup) which
> seems to be related to a defconfig misconfiguration.
> 
> BTW: Did you also add the Xilinx GPIO driver changes to your git
> repository I made to support GPIO interrupts? If not I'll send the
> patches again to the list tomorrow.
> 
> Thanks,
> Stefan

Hi Stefan,

No, I didn't grab your GPIO changes-- just modified my defconfig to get 
rid of the twd issues.

-Matt
