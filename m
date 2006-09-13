Message-ID: <45081913.8000004@domain.hid>
Date: Wed, 13 Sep 2006 09:43:31 -0500
From: Jeff Webb <jeff.webb@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-help] Kernel panic with Xenomai SMP kernel
References: <44F6E774.2000701@domain.hid>	
	<44F72F35.4070109@domain.hid>	<44F75C54.90608@domain.hid>	
	<17655.28122.163232.842311@domain.hid>	
	<44F84C23.9070105@domain.hid>	
	<17656.30980.846435.69720@domain.hid>	
	<44F8B112.9070203@domain.hid> <1157182863.4967.2.camel@domain.hid>	
	<44FF2E2C.9050209@domain.hid> <1157581459.5064.128.camel@domain.hid>
In-Reply-To: <1157581459.5064.128.camel@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
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
To: xenomai@xenomai.org

Philippe Gerum wrote:
> Jeff Webb wrote:
>
>> I was happy to discover the source of the kernel panic, but the SMP 
>> kernel was still not quite right (... strange pauses and repeated 
>> keystrokes, as I mentioned in a previous email).  I proceed to go 
>> through the kernel options in great detail and disable options that 
>> I thought were unnecessary.  After doing this, I finally ended up 
>> with an SMP xenomai kernel that appears to function properly.  I am 
>> now trying to find the option that caused the strange behavior.  I 
>> will let you know which option it is, if I can track it down.
> 
> Thanks.

After many, many recompiles.... As it turns out, this buggy behavior occurs when I turn off CONFIG_ACPI completely, instead of just turning off CONFIG_ACPI_PROCESSOR.  I tried this same configuration file with the non-patched vanilla kernel, and got strange behavior as well, so the problem is probably not in the adeos patch (unlike the other two issues we discussed).  I am not really concerned about this, since I would rather have some of the CONFIG_ACPI options on anyway.  I just wanted to follow up and let you know I tracked down the problem as far as I care to take it for the moment.

Thanks,

Jeff


