Message-ID: <49F69187.9030402@domain.hid>
Date: Tue, 28 Apr 2009 07:17:59 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <b131c9f0904230220j3f0a7d7ej9172ee4fb48aa69c@domain.hid>
	<1240479431.6990.30.camel@domain.hid>
	<1240482629.7599.45.camel@domain.hid>
	<1240487288.6990.71.camel@domain.hid>
	<Pine.LNX.4.64.0904271229410.719@domain.hid>
	<49F640A0.4010904@domain.hid> <49F64500.50901@domain.hid>
	<Pine.LNX.4.64.0904271720580.6463@domain.hid>
In-Reply-To: <Pine.LNX.4.64.0904271720580.6463@domain.hid>
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
> On Tue, 28 Apr 2009, Gilles Chanteperdrix wrote:
>> Ok. I missed the NO_HZ option. With NO_HZ (and high res), I can
>> reproduce the issue.
> 
> Excellent. Just to confirm, I was also using NO_HZ and high-res
> timers.

On my side, disabling NO_HZ is enough to make the issue disappear. So, I
am back to my first observation: it looks like a bad interaction between
the I-pipe and the NO_HZ code. And it happens when Linux timing is based
on another timer than the intercepted local APIC timer.

-- 
					    Gilles.

