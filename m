Message-ID: <4B194E6F.7090806@domain.hid>
Date: Fri, 04 Dec 2009 19:01:19 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <c024fefc0912040111s78a97159vde8d7391b5702acf@domain.hid>
In-Reply-To: <c024fefc0912040111s78a97159vde8d7391b5702acf@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] Problem with Xenomai Install
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Adrian Boeing <me@domain.hid>
Cc: Xenomai help <xenomai@xenomai.org>

Adrian Boeing wrote:
> Hi,
> 
> I have installed Xenomai on a PC, but when I try to run any of the
> examples (rtprint, trivial-periodic, etc...) the system freezes.
> 
> Does anyone know what may have caused this?

Probably a oops. You should try and run the examples from text mode to
see the oops text. Or redirect the kernel console to a serial port.

> 
> I am using Ubuntu, 2.6.24.6 kernel, and /proc/xenomai/version is 2.4.10

Kernel too old. Things have been fixed on x86 since then.

-- 
                                          Gilles


