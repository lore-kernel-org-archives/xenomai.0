Message-ID: <45F91FCC.20906@domain.hid>
Date: Thu, 15 Mar 2007 11:28:28 +0100
From: Theo Veenker <Theo.Veenker@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-help] xenomai on (old) laptop
References: <45F91516.503@domain.hid> <45F9166F.3020901@domain.hid>
	<1173952750.8193.11.camel@domain.hid>
In-Reply-To: <1173952750.8193.11.camel@domain.hid>
Content-Type: text/plain; charset=us-ascii; format=flowed
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
To: rpm@xenomai.org
Cc: Xenomai <xenomai@xenomai.org>

Philippe Gerum wrote:
> On Thu, 2007-03-15 at 10:48 +0100, Gilles Chanteperdrix wrote:
> 
>>Theo Veenker wrote:
>>
>>>Hi all,
>>>
>>>I'm preparing a Toshiba Satellite S1400-153E laptop for field work.
>>>It used to run redhat 9 + RTLinux, but now it runs Ubuntu 6.06 +
>>>Xenomai 2.3.
>>>
>>>Unfortunately the latency test shows high latencies (200..500us) at
>>>irregular intervals (5..20 sec) whereas the typical max latency is
>>>around 10 us. It doesn't seem to be related to any user action.
>>>
>>>I don't think this thing has SMI, anyway xenomai doesn't detect it.
>>>It also doesn't have a local APIC. What could be the cause of these
>>>high latencies?
>>
>>APM ?
>>
> 
> 
> You may also want to check for USB-related issues as explained in the
> TROUBLESHOOTING file.
> 

I have APM, CPU Frequency Scaling and ACPI processor disabled in config.
I'll try to kill my USB stuff to see what happens.

Theo




