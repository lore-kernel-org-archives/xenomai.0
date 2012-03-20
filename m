Message-ID: <4F68DCBE.407@domain.hid>
Date: Tue, 20 Mar 2012 20:38:38 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <CB8E2B24.1EE49%glen@domain.hid>
In-Reply-To: <CB8E2B24.1EE49%glen@domain.hid>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] Linux Serial Does not work with
 CONFIG_XENO_OPT_PERVASIVE enabled
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Glen Wernersbach <glen@domain.hid>
Cc: xenomai@xenomai.org

On 03/20/2012 05:40 PM, Glen Wernersbach wrote:
> Here it is. Just a simple modification of the atmel_serial.
> 
> The define for it is CONFIG_MACH_MATRIX518

>From a quick glance, I do not see anything conflicting with xenomai.
Note that this driver has the same issue as the vanilla atmel serial: it
may loose characters in case of high irq latencies.

Anyway, could you post the two kernel configurations, the one which
works, the one which does not work?

Other than that, I guess all you can do is try and debug the driver,
starting with the serial irq and trying and understanding how it gets lost.

-- 
                                                                Gilles.

