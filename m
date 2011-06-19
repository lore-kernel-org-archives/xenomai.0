MIME-Version: 1.0
In-Reply-To: <4DFE038F.202@domain.hid>
References: <BANLkTikoPvhb1XmycYm=MROT7=BGA8cisg@domain.hid>
	<4DFDF79F.1090502@domain.hid>
	<BANLkTinVUd-R1cpD+40MGZZckzGhwrqRvw@domain.hid>
	<4DFDFD2F.1080506@domain.hid>
	<BANLkTimdiUofRrXahOThW5C1RixQ-s5pMQ@mail.gmail.com>
	<4DFE038F.202@domain.hid>
Date: Sun, 19 Jun 2011 16:21:34 +0200
Message-ID: <BANLkTi=RiME1P8vvx3imrq39gEmyZOJbDQ@mail.gmail.com>
From: Andrey Nechypurenko <andreynech@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Subject: Re: [Xenomai-help] Problem accesing I2C without using Linux kernel
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: Xenomai help <xenomai@xenomai.org>

>> The module works. I think kernel configured it properly because I can
>> use user space utility for example i2cdetect and see my sensors
>> detected on the bus. At the moment where I was trying to read the
>> status I did not made any reconfiguration before. So my assumption was
>> that the module is already configured properly and at least an attempt
>> to read the status should succede.
>
> To be sure of that, you would have to be sure that the clocks are not
> disabled when the device is not opened. To check this, either check the
> kernel sources, or try and open the i2c device, and keep it open before
> you mmap /dev/mem

Just tried your suggestion but unfortunately it does not change enything.

Thank you!

Andrey.

