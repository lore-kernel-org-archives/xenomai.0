From: Paul <paul_c@domain.hid>
Subject: Re: [Xenomai-help] problems installing peak CAN dongle
Date: Sun, 4 Mar 2007 10:01:46 +0000
References: <bc4264770703020023o4e15cdafh6e254fff4b225e8a@domain.hid>
	<45E7E31B.1090102@domain.hid>
In-Reply-To: <45E7E31B.1090102@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200703041001.46604.paul_c@domain.hid>
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: xenomai@xenomai.org
Cc: Jan Kiszka <jan.kiszka@domain.hid>


Hi Jan

On Friday 02 March 2007 08:40, Jan Kiszka wrote:
> Maybe a conflict with parport_pc.
>
> Wolfgang, do we always have to remove that module, or is there a chance
> to cooperate with it without loosing real-time? When removing the Linux
> parport layer, there is the risk that the port is powered off (see
> irqbench), and xeno_can_peak_dng does not account for this yet.

Apologies if you're already aware of the following...
There are a series of calls within the parport subsystem that allow you to 
register the driver and claim exclusive access to the port - This has several 
advantages:

 * The IO address is validated (usefull for PCI cards).
 * IRQ & base addresses returned in a single struct.
 * Correct IEEE-1284 device present can be checked.
 * IEEE-1284 modes configured with a single call.
 * Numerous read/write calls for EPP/SP modes (depending on .config, not RT 
safe).

Retaining parport_pc should avoid any problems with the port being powered off 
and also allow easy access to PCI card based ports... Unfortunately I don't 
have a Can dongle to test, so can only offer pointers to parport.h and 
http://people.redhat.com/twaugh/parport/html/parportguide.html - Although the 
doc relates to 2.4 series kernels, the info is valid for 2.6.xx (I'm using 
parport_claim & friends for another project).


Regards, Paul.

