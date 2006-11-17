Message-ID: <455E19F1.2080400@domain.hid>
Date: Fri, 17 Nov 2006 21:22:09 +0100
From: Wolfgang Grandegger <wg@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-help] xeno_rtcan_mem.ko, what are it's parameters?
References: <54b161f50611160749p5405415fk6702af8243428fa4@domain.hid>	
	<455C8B8A.80105@domain.hid> <455CBC4A.5010108@domain.hid>	
	<54b161f50611161200u7a32f87etdad89178ddc1a195@domain.hid>	
	<455CC9DE.6030601@domain.hid>
	<54b161f50611162357o71b7f689v1bf68072861c753e@domain.hid>
	<455D6D3B.9000009@domain.hid>
In-Reply-To: <455D6D3B.9000009@domain.hid>
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
To: Jan Kiszka <jan.kiszka@domain.hid>
Cc: xenomai@xenomai.org

Jan Kiszka wrote:
> Frits de Klark wrote:
>> Hi,
>>
>> to get back on my earlier question: IF the memory mapping might work for
>> me,
>> how should I call it?
>> The PCI card has two CAN ports. Here's (a part of) the output of lspci -vv:
>>
>> Interrupt: pin A routed to IRQ 11
>> Region 0: Memory at e1003000 (32-bit, non prefetchable) [size=128]
>> Region 2: I/O ports at d800 [size=128]
>> Region 3: I/O ports at dc00 [size=128]
>> Region 4: I/O ports at e000 [size=4]
>>
>> What should the insmod command to try if it might work?
> 
> You could try handing region 2 or 3 to the rtcan_isa driver or region 0
> to rtcan_mem. Maybe your adapter actually does 1:1 mapping of the
> SJA1000 address space (it looks like). I just wonder what region 4 is
> doing. Maybe it controls the content of region 0, which may either hold
> the first or the second CAN controller. Just a theory...

To check that, load the mem driver with:

# insmod xeno_rtcan_mem.o mem=0xe1003000 irq=11

maybe there are SJA1000 registers as well. But the extra registers might 
also be there to do a reset, or report some IRQ status.

Wolfgang.

