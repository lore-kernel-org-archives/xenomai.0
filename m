From: Philippe Gerum <rpm@xenomai.org>
In-Reply-To: <200909081639.47736.smolorz@domain.hid>
References: <200909081639.47736.smolorz@domain.hid>
Content-Type: text/plain
Date: Sat, 12 Sep 2009 00:23:10 +0200
Message-Id: <1252707790.2820.492.camel@domain.hid>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-core] [PATCH] rtcan: Add support for CAN PCI cards
 from ESD
List-Id: Xenomai life and development <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Sebastian Smolorz <smolorz@domain.hid>
Cc: xenomai-core <xenomai@xenomai.org>

On Tue, 2009-09-08 at 16:39 +0200, Sebastian Smolorz wrote:
> This patch adds support for SJA1000 based PCI CAN interface cards from 
> electronic system design gmbh.
> 
> The following list of boards are supported:
> 
> CAN-PCI/200 (tested)
> CAN-PCI/266
> CAN-PMC266
> CAN-PCIe/2000
> CAN-CPCI/200
> CAN-PCI104
> 
> The patch is based on the Socket-CAN driver for those boards by Matthias 
> Fuchs.
> 
> Signed-off-by: Sebastian Smolorz <smolorz@domain.hid>
> Acked-by: Wolfgang Grandegger <wg@domain.hid>

Merged, thanks.

-- 
Philippe.



