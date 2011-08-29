Message-ID: <4E5B3C2C.7000503@domain.hid>
Date: Mon, 29 Aug 2011 09:13:48 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <OFF5A1868E.F6AC0BF7-ON882578F8.0076FF3F-882578F8.00784B5F@moog.com>
In-Reply-To: <OFF5A1868E.F6AC0BF7-ON882578F8.0076FF3F-882578F8.00784B5F@moog.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] milli-second overruns under heavy load on x86,
 running Xenomai 2.5.6
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: George Broz <GBroz@domain.hid>
Cc: xenomai@xenomai.org

On 08/26/2011 11:49 PM, George Broz wrote:
>> Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org> wrote on 
> 08/26/2011 02:18:05 PM:
>> On 08/26/2011 10:42 PM, George Broz wrote:
>>> Hello,
>>>
>>> I'm experiencing very large overruns in the neighborhood of 10 to 50 
>>> *milli-seconds* as reported by the Xenomai latency tool in user-task 
> mode 
>>> whenever the Linux OS is heavily loaded. Under lighter loads these are 
> in 
>>> the 30 to 70 micro-second (normal) range. 
>>>
>>> My system is:
>>> - Linux 2.6.37.6 (32-bit), Ubuntu 10.10 distribution
>>> - Xenomai 2.5.6 using I-pipe patch adeos-ipipe-2.6.37.6-x86-2.9-02
>>> - Intel x86 Atom (dual-core) CPU D510 @ 1.66GHz 
>>> - Emb. dev board from Intel (ICH8M ctrlr, Ethernet h/w for e1000e)
>>> - Xenomai configured w&w/o --enable-smp --enable-x86-tsc options
>>> - gcc version 4.4.5
>>>
>>> I've followed all of the recommendations for kernel configuration and 
> have 
>>> disabled CPU sleep features in the BIOS such as SpeedStep and 
> C-States. 
>>> Legacy USB has been disabled in the BIOS. Hyperthreading has also been 
> 
>>> disabled, although I don't think it matters.
>>
>> Have you tried to enable the SMI workaround?
>>
>> -- 
>>                                                                 Gilles.
>>
> 
> Yes - SMI workaround was enabled when the overruns were observed.

Could you try disabling CONFIG_SMP to see if you get the same behaviour,
and take a few traces?
If you processor supports 64 bits mode, could you try running a 64 bits
kernel?


-- 
                                                                Gilles.

