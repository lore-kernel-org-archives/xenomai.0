Message-ID: <4382CEF6.7020109@domain.hid>
Date: Tue, 22 Nov 2005 08:55:34 +0100
From: Anders Blomdell <anders.blomdell@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-help] __raw_*lock for Xenaomai 2.01 on ppc
References: <4381FC29.5040506@domain.hid> <43821221.9070702@domain.hid>
In-Reply-To: <43821221.9070702@domain.hid>
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
To: Philippe Gerum <rpm@xenomai.org>
Cc: xenomai@xenomai.org

>> Is it by design or mistake that I get the following undefined symbols 
>> on a PowerPC
>>
>> # insmod xeno_nucleus.ko
>> xeno_nucleus: Unknown symbol __raw_read_lock
>> xeno_nucleus: Unknown symbol __raw_write_unlock
>> xeno_nucleus: Unknown symbol __raw_read_unlock
>> xeno_nucleus: Unknown symbol __raw_write_lock
>>
>> unless the kernel is compiled with:
>>
>> CONFIG_DEBUG_KERNEL=y
>> CONFIG_DEBUG_SPINLOCK=y
> Patch version, please.
xenomai-2.0.1/arch/ppc/patches/adeos-ipipe-2.6.14-ppc-1.0-06.patch

The problem probably is that the EXPORT_SYMBOL are done in 
lib/spinlock_debug.c, which is only compiled if CONFIG_DEBUG_SPINLOCK=y

Regards

Anders Blomdell

