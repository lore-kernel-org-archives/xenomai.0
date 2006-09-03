Message-ID: <44FACC29.4040108@domain.hid>
Date: Sun, 03 Sep 2006 14:35:53 +0200
From: Wolfgang Grandegger <wg@domain.hid>
MIME-Version: 1.0
References: <44F5FA7F.6020405@domain.hid>
In-Reply-To: <44F5FA7F.6020405@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Subject: [Xenomai-core] Re: [PATCH] add virtual CAN bus driver
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

Hi Jan,

Jan Kiszka wrote:
> For review:
> 
> Here comes a tiny but fairly useful new CAN driver: a virtual CAN bus
> consisting of 2..n devices (see module parameter). Transmission takes
> places from the sender to all other devices on the bus, just like in
> real life.
> 
> This driver was already helpful for me while adapting CanFestival, a
> LGPL CANopen library, to our CAN API -- inside qemu, i.e. without any
> real hardware around.

I have tested it on my setup (MPC5200 with MSCAN and PEAK-PCI card under 
Linux 2.4) and it works fine.

Wolfgang.


