Message-ID: <472B315C.4040809@domain.hid>
Date: Fri, 02 Nov 2007 06:17:00 -0800
From: Dennis Nguyen <dennisnguy@domain.hid>
MIME-Version: 1.0
References: <47279853.9050704@domain.hid> <4729AED3.20200@domain.hid>
In-Reply-To: <4729AED3.20200@domain.hid>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] Xenomai loading module error when running
	xero-test
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
Cc: xenomai-help <xenomai@xenomai.org>



Jan Kiszka wrote:
> Dennis Nguyen wrote:
>   
>> Hello,
>> I'm using linux kernel i386 2.6.20.10, xenomai 2.4-rc5, 
>> adeos-ipipe-2.6.20-i386-1.10.10.patch.
>> I got errors when running xenoo-test:
>> FATAL: Error inserting xeno_nucleus 
>> (/lib/modules/2.6.20.10/kernel/kernel/xenomai/nucleus/xeno_nucleus.ko): 
>> No such device
>>     
>
> Please have a look at the kernel messaged (e.g. via dmesg), then follow
> the suggestions given there. I would bet it's a local APIC configuration
> issue...
>
> Jan
>
>   
Hi Jan,
You are right, the problem related to APIC. I set -lapic=1 to boot 
param. I also enabled-x86-sep and enable-x86-tsp while configure xenomai 
in build_root. It happened on a Intel Pentium III  650 MHz.
Thanks for your help,
Dennis

