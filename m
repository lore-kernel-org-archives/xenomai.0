Message-ID: <4AF7F0E4.1020800@domain.hid>
Date: Mon, 09 Nov 2009 11:37:24 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <200911091459.18335.anisha.kaul@domain.hid>
In-Reply-To: <200911091459.18335.anisha.kaul@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-core] Function for writing to serial port through
 Xenomai API
List-Id: Xenomai life and development <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Anisha Kaul <anisha.kaul@domain.hid>
Cc: xenomai@xenomai.org

Anisha Kaul wrote:
> Dear all,

Hi,

> 
> I know that outb() being a linux system call can be used to write to the 
> serial/parallel ports. Currently I am working on a real time operating system 
> with Xenomai and a micro kernel. If I use outb() for port access, control 
> will shift to the soft-real time linux which I don't want. Is there any way I 
> can access ports using (Xenomai) functions rather than the linux system 
> calls ?

Well, Xenomai has a real-time driver for the serial port, so, you could
use that. Other than that outb does not cause its caller to switch to
secondary mode if you have made the proper call to ioperm or iopl.

-- 
                                          Gilles


