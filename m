Message-ID: <45A81E1B.3080201@domain.hid>
Date: Fri, 12 Jan 2007 17:47:39 -0600
From: Jeff Webb <jeff.webb@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-help] xeno_16550A and 8250.nr_uarts=0
References: <45A68383.3070203@domain.hid> <45A6CB80.9060306@domain.hid>
	<45A802CD.8010606@domain.hid>
In-Reply-To: <45A802CD.8010606@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Jan Kiszka <jan.kiszka@domain.hid>
Cc: Xenomai help <xenomai@xenomai.org>

Jeff Webb wrote:
> Thanks for the suggestion.  I looked at the PnP-related code in 
> irqbench.c, and compared this to what is in 
> linux/drivers/parport/parport_pc.c.  I then modified 16550A.c in a 
> similar fashion, merging in the required code from 
> linux/drivers/serial/8250_pnp.c.  I can now boot the kernel with 
> 8250.nr_uarts=0", insert the modified xeno_16550A module, and then run 
> my serial test program successfully.  I have not tried compiling the 
> modified xeno_16550A code into the kernel, but I will try this next.

I compiled the modified xeno_16550A code into a new kernel image, and the serial port works.  Thanks again for pointing me in the right direction, Jan.

Jeff

