Message-ID: <4C878E69.4030608@domain.hid>
Date: Wed, 08 Sep 2010 15:23:53 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <20100908111656.GA24409@domain.hid>
	<4C8779EA.5030506@domain.hid>
In-Reply-To: <4C8779EA.5030506@domain.hid>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] XENO_HW_SMI_WORKAROUND safety
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Richard Cochran <richardcochran@domain.hid>
Cc: xenomai@xenomai.org

Gilles Chanteperdrix wrote:
> Richard Cochran wrote:
>> As an x86 dummy, I have a question about XENO_HW_SMI_WORKAROUND and
>> XENO_HW_SMI_ALL. I remember from the 2009 RTLW, that Thomas Gleixner
>> said not to disable SMIs or it might melt my cpu.
>>
>> Is there any risk in enabling the Xenomai options?
> 
> Some people seem to have used it without any problem. The problem
> happens if SMIs are used for regulating the cpu fans speed. So far, I
> have not seen PCs which do this, but who knows?
> 
> You can run a stress test, measuring the CPU temperature, with and
> without the SMIs disabled. This way, if the SMIs are involved in
> regulating the cpu fan speed, you will know it, and in this case, yes,
> you can not disable them.
> 
> Note however that the Intel chipsets allow to prevent you from disabling
> the SMIs. So, it would be plain silly if your PC manufacturer used the
> SMI for regulating the cpu fan speed, and did not prevent you from
> disabling them.

Also note that the chipset allows you to disable the SMI sources
selectively, so, if the cpu fan speed regulation is a fast SMI, you can
disable the others, and keep that one.

So, there are several things to try before giving up on SMIs.

-- 
					    Gilles.

