Message-ID: <49F640A0.4010904@domain.hid>
Date: Tue, 28 Apr 2009 01:32:48 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <b131c9f0904230220j3f0a7d7ej9172ee4fb48aa69c@domain.hid>	<1240479431.6990.30.camel@domain.hid>	<1240482629.7599.45.camel@domain.hid>	<1240487288.6990.71.camel@domain.hid>
	<Pine.LNX.4.64.0904271229410.719@domain.hid>
In-Reply-To: <Pine.LNX.4.64.0904271229410.719@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] Lockups on a new Celeron-430 system detected and
 resolved.
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Martin Shepherd <mcs@domain.hid>
Cc: xenomai-help <xenomai@xenomai.org>

Martin Shepherd wrote:
> I have just installed Xenomai 2.5-rc1 on a new computer that has a new
> Celeron-430 1.8GHz processor on a Foxconn G31AX motherboard.
> Initially I experienced similar lockup problems with this setup as I
> previously reported for an ancient 850MHz AMD Athlon computer. As with
> the AMD Athlon, fixing the lockup problem required me to turn off both
> HPET_TIMER and X86_PM_TIMER.

I just tested on an atom here, using a 32bits kernel without smp, with
PM timer, apic, io-apic and HPET timer enabled, everything is detected
at boot and everything is fine. Also, it does not seem to me like you
needed to turn off HPET on the Athlon ? I guess Athlons do not have an
HPET anyway...

Could you send us your console logs ?

-- 
					    Gilles.

