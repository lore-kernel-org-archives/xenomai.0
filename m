Message-ID: <46434837.9080605@domain.hid>
Date: Thu, 10 May 2007 18:28:39 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <20070510120938.307800@domain.hid> <46434561.2090309@domain.hid>
In-Reply-To: <46434561.2090309@domain.hid>
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] high latency with Intel Core 2 Duo
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Jan Kiszka <jan.kiszka@domain.hid>
Cc: xenomai@xenomai.org

Jan Kiszka wrote:
> Karl Reichert wrote:
> 
>>Hello,
>>
>> I'm using an Intel Core 2 Duo at work and an AMD XP3000+ at home. I installed Xenomai 2.3.1 with nearly same configuration at both and run the xeno-test. I get 10 times higher latency with Core 2 Duo. How is it possible? May the SMP be the reason?
> 
> 
> SMP surely increases latencies (more synchronisation overhead), but the
> tests you ran were also far to short for a thorough comparison. 2 us
> worst-case is far too good, even on high end. Also 20 us on loaded SMP
> boxes may not hold. Leave the test running for a longer period ("-T"
> parameter, I think).

You should configure the user-space libraries with the --enable-smp
option when configuring for SMP.

Also, did you compile a 32 bits or 64 bits kernel for the core 2 duo ?

If you think that you observe high latencies, check the TROUBLESHOOTING
file.

-- 
                                                 Gilles Chanteperdrix

