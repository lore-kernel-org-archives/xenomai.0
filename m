Message-ID: <4F79B7B2.1010004@domain.hid>
Date: Mon, 02 Apr 2012 16:29:06 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <CAGq8jPjvtxSjKW+RpiUX5u02mnXv7q2K2PLgfF2E6CT1Eaw6Mg@domain.hid>
In-Reply-To: <CAGq8jPjvtxSjKW+RpiUX5u02mnXv7q2K2PLgfF2E6CT1Eaw6Mg@domain.hid>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] analogy - serial port
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Minh GIANG <giang.hminh@domain.hid>
Cc: xenomai@xenomai.org

On 04/02/2012 04:12 PM, Minh GIANG wrote:
> Hello everybody,
> 
> Do the Analogy driver support the serial port. I can attach the serial
> port(ttyS0) to rtser0 with xeno_16550A.ko as mentionned in Xenomai
> Documentation
> 
> modprobe xeno_16550A io=<io1>[,<io2>...] irq=<irq1>[,<irq2>...]
>                      [baud_base=<base1>[,<base2>...]]
>                      [tx_fifo=<len1>[,<len2>...]] [start_index=<index>]
> 
> 
> How can i tell to  the Analogy driver to recognize the serial port in
> order to use the Analogy API. i have seen the command
> 
> /xeno_install/sbin/analogy_config analogy0 analogy_ni_pcimio 
> 
> i think that analogy_ni_pcimio is the drivers suppors of National
> Instruments PCI / PXI cards. But i don't have the DAQ card yet,
> currently i test with two serial ports on my computer while connecting
> them by one cable. the first aim is to test the api analogy.

Sorry, I did not make myself clear: the RTDM API is a general API for
making drivers, Analogy is a class of drivers for acquisition boards
written using RTDM. The analogy library allow access to this class of
driver, so, you can not use the analogy library with a serial port driver.

> 
> Thanks,
> 
> 
> 
> when i try to add the analogy_ni_pcimio module over terminal linux. i
> get one message error
> 
> insmod analogy_ni_pcimio.ko
> 
> analogy_ni_pcimio.ko : -1 Unknown symbol in module

See dmesg to understand what symbol is missing.


-- 
					    Gilles.

