Message-ID: <49E89BC7.6000704@domain.hid>
Date: Fri, 17 Apr 2009 17:09:59 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <2b490f270904170749m3ec39cc8vddab1b5aa50f4b4c@domain.hid>
In-Reply-To: <2b490f270904170749m3ec39cc8vddab1b5aa50f4b4c@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] RT Serial, rt_dev_read blocking problem
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Dehann Fourie <dehann.fourie@domain.hid>
Cc: xenomai@xenomai.org

Dehann Fourie wrote:
> Hi,
> 
> I am having trouble with reading data from the serial port. I initially
> followed the RT Serial example from captain. I changed the read task to a
> periodic 20ms task, from which I read from the serial port (rtser0). This is
> all that the rt_task is doing. The serial port config is:
> 
> static const struct rtser_config
> <http://www.xenomai.org/documentation/trunk/html/api/structrtser__config.html>
> read_config = {
>         .config_mask       = 0xFFFF,
>         .baud_rate         = 57600,
>         .parity            = RTSER_NO_PARITY,
>         .data_bits         = RTSER_8_BITS,
>         .stop_bits         = RTSER_1_STOPB,
>         .handshake         = RTSER_NO_HAND,
>         .fifo_depth        = RTSER_DEF_FIFO_DEPTH,
>         .rx_timeout        = RTSER_DEF_TIMEOUT,

Did you try to set .rx_timeout = RTSER_TIMEOUT_NONE here ? I may be
completely wrong because I never used the serial driver, but it looks
like what you are looking for.

> I am on a Geode 500MHz single board computer with kernel 2.6.23 and xeno
> 2.4.3.

Some issues with FPU on Geode were fixed recently, so, you should use
Xenomai 2.4.7, using the latest I-pipe patch which ship with this
version, and apply the commit 3a23967f3cc8d6881d8e3280130bbc431195aa31
from head.

-- 
					    Gilles.

