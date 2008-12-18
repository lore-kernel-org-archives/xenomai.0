Message-ID: <494A67EA.6050900@domain.hid>
Date: Thu, 18 Dec 2008 15:10:34 +0000
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <20081218150221.6297D1C066@domain.hid>
In-Reply-To: <20081218150221.6297D1C066@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] Pentium III performances
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: stefano.franzoni@domain.hid
Cc: "xenomai@xenomai.org" <xenomai@xenomai.org>

stefano.franzoni@domain.hid wrote:
> Dear experts
> 
> we have a systems with Ubuntu Linux 2.6.25.11 and Xenomai 2.4.4.
> The system has a Pentium III (Coppermine) 1GHz.
> The Xenomai installation seems to be ok.
> 
> I generate a periodic event based on a ISA irq every 2 msec. and also seems
> to be right.
> When we generate events in the human interface (open windows, ecc..) we
> don't respect the deadline of 2 msec.

see TROUBLESHOOTING.

> 
> Pentium III is an obsolete system but we are wondering if this loose
> performances depends on it.
> It would be useful to know if this is a supported hardware and if is known
> the related maximum IRQ latency and the maximun IRQ jitter.

run latency, while stressing the system.

-- 
                                                 Gilles.

