Message-ID: <4587E3A9.7090401@domain.hid>
Date: Tue, 19 Dec 2006 14:05:45 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
Subject: Re: Aw: Re: [Xenomai-help] NMI watchdog: Loading of xeno_native
	leads...
References: <4587B287.2060603@domain.hid>
	<358035.1166518774710.JavaMail.ngmail@domain.hid>
	<4587A2D4.3020102@domain.hid> <45879DE5.5080507@domain.hid>
	<7145056.1166514841031.JavaMail.ngmail@domain.hid>
	<4970132.1166516081275.JavaMail.ngmail@domain.hid>
	<2579704.1166520394117.JavaMail.ngmail@domain.hid>
	<4383100.1166529856857.JavaMail.ngmail@domain.hid>
In-Reply-To: <4383100.1166529856857.JavaMail.ngmail@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
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
To: "M. Koehrer" <mathias_koehrer@domain.hid>
Cc: xenomai@xenomai.org, jan.kiszka@domain.hid

M. Koehrer wrote:
> Hi Jan,
> 
> I tried to enable the kernel hacking parameters you proposed.
> However, now I get a "NMI early shots: 0" message many times per second.
> These seems to slow down everything dramatically, it is hard to work with the
> system. What are the early shots messages and how can I avoid them?

Normally, when you see "NMI early shots: 0", your system is about to
panic. I guess the reason why your system is able to recover from this
situation is because you enabled the watchdog. What would be interesting
would be to know what is printed right after "NMI early shots: 0", it
may be significant, if not, simply disable the NMI watchdog, maybe it
does not work properly on your machine.

-- 
                                                 Gilles Chanteperdrix

