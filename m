Message-ID: <45E46E84.4060908@domain.hid>
Date: Tue, 27 Feb 2007 18:46:44 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
Subject: Re: [Xenomai-help] high latency every 8 seconds
References: <45E4646A.10205@domain.hid>
In-Reply-To: <45E4646A.10205@domain.hid>
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
To: Theo Veenker <Theo.Veenker@domain.hid>
Cc: xenomai@xenomai.org

Theo Veenker wrote:
> Hi all,
> 
> I'm installing xenomai 2.2.5 (kernel 2.6.17.14) on a number of
> systems (MSI 945P, Intel P4 3Ghz). My kernel runs fine on several
> other/older systems, but on the new systems there is something going
> on every 8 seconds. See output of latency test below. What could
> this be? Is this an SMI effect?

Yes, typically, enable the SMI workaround and you will see.


-- 
                                                 Gilles Chanteperdrix

