From: Matthias Fuchs <matthias.fuchs@domain.hid>
Subject: Re: [Xenomai-core] Re: CAN updates & questions
Date: Sat, 9 Sep 2006 17:39:00 +0200
References: <450290AC.6000009@domain.hid> <45029903.7030108@domain.hid>
In-Reply-To: <45029903.7030108@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200609091739.00665.matthias.fuchs@domain.hid>
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: xenomai@xenomai.org
Cc: Jan Kiszka <jan.kiszka@domain.hid>

Hi Wolfgang,

Wolfgang Grandegger wrote:
> You have to define the real CAN system clock, which is 16/2 = 8 Mhz for
> most SJA 1000 hardware even if the oscillator is running at 16 MHz. I
> will add some reasonable note to rtcan_dev.h
Is there any special reason for this? Wouldn't it be more meaningful to pass 
the SJA1000 externally applied clock frequency? I can imagine that others 
will also run into this issue as Jan and I did yesterday ;-)
>
> > Then we will soon have to discuss how to deal with a rtcan_isa
> > derivative that uses ioremapped memory instead of ports (naming,
> > separation or integration).
>
> We could add a generic device similar to ISA (or extend ISA accordingly).
The SJA1000 isa driver is very simple - and so is the modified version for the 
memory mapped SJA1000. I think that merging both ways of access to the 
SJA1000 into a single driver will make the code much more dirty. I would 
prefer different source files (= different drivers). 

It would be a compromise to add support for boards that use some kind of 
indirect addressing to access the SJA1000 (address + data register) into the 
isa and mem versions of the driver.

One more proposal: I think many (old) ISA drivers name the module parameter 
for the ISA io port "io" instead of "isa". For the memory mapped SJA1000 
driver, I'd like to call the parameter "mem".

Matthias

