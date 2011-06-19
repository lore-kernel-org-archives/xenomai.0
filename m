Message-ID: <4DFE038F.202@domain.hid>
Date: Sun, 19 Jun 2011 16:11:27 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <BANLkTikoPvhb1XmycYm=MROT7=BGA8cisg@domain.hid>	<4DFDF79F.1090502@domain.hid>	<BANLkTinVUd-R1cpD+40MGZZckzGhwrqRvw@domain.hid>	<4DFDFD2F.1080506@domain.hid>
	<BANLkTimdiUofRrXahOThW5C1RixQ-s5pMQ@mail.gmail.com>
In-Reply-To: <BANLkTimdiUofRrXahOThW5C1RixQ-s5pMQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
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
To: Andrey Nechypurenko <andreynech@domain.hid>
Cc: Xenomai help <xenomai@xenomai.org>

On 06/19/2011 04:06 PM, Andrey Nechypurenko wrote:
>> Note that this mailing list is probably not the best place to ask your
>> question, since we mostly talk about Xenomai here, and your issue does
>> not seem to have anything to do with Xenomai.
> 
> I understand. Do you have an idea what list might be more appropriate
> for it? I did also post the same question to the BeagleBoard mail
> list.

Ok, maybe you will get better support there. There may also be some IRC
channel somewhere, where you can get a more interactive help.

>> Second stupid questions: are you sure all the clocks needed to get that
>> I2C module running are enabled?
> 
> The module works. I think kernel configured it properly because I can
> use user space utility for example i2cdetect and see my sensors
> detected on the bus. At the moment where I was trying to read the
> status I did not made any reconfiguration before. So my assumption was
> that the module is already configured properly and at least an attempt
> to read the status should succede.

To be sure of that, you would have to be sure that the clocks are not
disabled when the device is not opened. To check this, either check the
kernel sources, or try and open the i2c device, and keep it open before
you mmap /dev/mem


-- 
                                                                Gilles.

