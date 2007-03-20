MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17920.13832.789072.876398@domain.hid>
Date: Tue, 20 Mar 2007 20:29:12 +0100
Subject: Re: [Xenomai-core] Xenomai support for ARM926EJ
In-Reply-To: <fdba73240703201122w447cce8bl186ba32df55665c7@domain.hid>
References: <fdba73240703151522l3aa73a81v84661caf17f489ae@domain.hid>
	<17914.63535.18893.207257@domain.hid>
	<fdba73240703201122w447cce8bl186ba32df55665c7@domain.hid>
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Muruganandam Ganapathy <muruganandam.ganapathy@domain.hid>
Cc: xenomai@xenomai.org

Muruganandam Ganapathy wrote:
 > The board is based on the Fujitsu SOC which has the ARM926EJ processor core.
 > 
 > This board has SPI, I2C and 10/100 ethernet interfaces and it can support
 > 16/32MB SDRAM
 > and 4/8MB flash memory.

You still do not tell us the name of the board, but it is probably not
supported.

 > 
 > 
 > In addition, I would like to know the interrupt reponse  mesaured with
 > Xenomai in ARM9
 > processor based platforms, if any.
 > The interrupt response expected is around 40 -50 microseconds in our case.
 > The interrupt response I mean, it is the time between the generation of the
 > interrupt and the actual ISR invocation.
 > 
 > 
 > Whether use of Xenomai will enable us meet this timing reqirement.

The latencies I have observed so far on ARM are usually larger than 150
microseconds, but these are userspace dispatch latencies.

So, you could improve situation if you stay in interrupt handlers.

Another way to improve the situation a bit more is to use ucLinux, if
your platform is supported.

Still, IMHO, 40-50 microseconds is too ambitious.

-- 


					    Gilles Chanteperdrix.

