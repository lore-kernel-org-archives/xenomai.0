Message-ID: <45F90DC1.2030009@domain.hid>
Date: Thu, 15 Mar 2007 10:11:29 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
Subject: Re: [Xenomai-help] mem usage and other application
References: <17913.899.384216.185459@domain.hid>
In-Reply-To: <17913.899.384216.185459@domain.hid>
Content-Type: text/plain; charset=ISO-8859-15
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
To: Xenomai help <xenomai@xenomai.org>

Maksym Veremeyenko wrote:
> Gilles Chanteperdrix ~~~~~:
> 
> 
>>Well, it really looks like an FPU bug. Could you try to:
>>- upgrade your trunk to latest revision, then test
>>- then apply the attached patch to your up-to-date trunk, then test
>>  again ?
>>
> 
> 
> I used configuration 2.6.17.14, xenomai-r2299
> 
> Before patching xenomai result was the same and more faulty after 
> decreasing RAM size down to 256M.
> 
> After applying patch situation become worth, i got "Bad pte" messages, 
> sometimes "Soft lockup detected", and kernel dump:

Why changing the RAM size ? Could you double-check with your RAM size
normally set ? Do you observe the "Bad pte" message with latency or
switchbench running, or with your RT application ?

-- 
                                                 Gilles Chanteperdrix

