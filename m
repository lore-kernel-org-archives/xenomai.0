Message-ID: <4639ECA7.50208@domain.hid>
Date: Thu, 03 May 2007 16:07:35 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <4639D724.5010702@domain.hid> <1178198991.29605.54.camel@domain.hid>
In-Reply-To: <1178198991.29605.54.camel@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] Latency calculation and test
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: rpm@xenomai.org
Cc: Xenomai-help@domain.hid

Philippe Gerum wrote:
> Hard RT signals are not yet supported by Xenomai. It's on the 2.4
> roadmap though. So you are right, POSIX signals are presently only
> available from the regular glibc/kernel support, therefore Xenomai
> threads automatically move to secondary mode to process them. Precise
> timing can be achieved with the POSIX skin using the non-portable
> pthread_set_periodic_np/pthread_wait_np interface.

It is also possible to use clock_nanosleep or nanosleep. IIRC cyclictest
allows to use them.

-- 
                                                 Gilles Chanteperdrix

