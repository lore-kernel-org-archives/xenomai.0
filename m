Message-ID: <45D41BD9.9020403@domain.hid>
Date: Thu, 15 Feb 2007 09:37:45 +0100
From: Wolfgang Grandegger <wg@domain.hid>
MIME-Version: 1.0
References: <45D35545.20100@domain.hid>
In-Reply-To: <45D35545.20100@domain.hid>
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Subject: [Xenomai-core] Re: RT-CAN tx_sem
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Jan Kiszka <jan.kiszka@domain.hid>
Cc: xenomai-core <xenomai@xenomai.org>

Jan Kiszka wrote:
> Hi Wolfgang,
> 
> fiddling with the CAN utils, I noticed the behaviour that rtcansend on
> freshly registered but stopped devices simply blocks. And when you
> meanwhile call rtcanconfig up on that device, rtcansend will continue to
> block.

This is a bug, the send function should return an error in that case.

> The reason is that during startup of CAN devices the tx-semaphore is
> re-initialised while it is already set up during device registration.
> Re-init on an already initialised rtdm_sem is, say, undefined.
> 
> So rtdm_sem should better only be initialised/destroyed by the drivers.
> Trying to send on a shut down CAN device could be catched differently,
> e.g. via the device state. This likely needs more thoughts, take it as a
> note that $something should be done.

I'm going to check this later today or tomorrow.

Wolfgang.

