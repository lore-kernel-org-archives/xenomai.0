Message-ID: <4E2FFE1B.5010900@domain.hid>
Date: Wed, 27 Jul 2011 14:01:31 +0200
From: zenati <omar.zenati@domain.hid>
MIME-Version: 1.0
References: <4E2EAB0F.6050109@domain.hid> <4E2FD923.2040003@domain.hid>
In-Reply-To: <4E2FD923.2040003@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-core] Debugging Xenomai kernel
List-Id: Xenomai life and development <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Jan Kiszka <jan.kiszka@domain.hid>
Cc: Xenomai core <Xenomai-core@domain.hid>

On 07/27/2011 11:23 AM, Jan Kiszka wrote:
> On 2011-07-26 13:54, zenati wrote:
>> Dear,
>>
>> I'm trying to debug Xenomai kernel with GDB and Qemu.
> QEMU in emulation or KVM mode?
>
I'm using Qemu in emulation mode.
>> So, I launch
>> Xenomai in Qemu and make it waiting for GDB. Then I start GDB and
>> connect them to Qemu, make breakpoint at the desired function to debug
>> and start Xenomai. If the function belongs to the linux kernel, the
>> execution stop at the breakpoint. But, if the function belongs to the
>> Xenomai nucleus, GDB recognize the breakpoint at the execution but don't
>> stop.
> Is Xenomai built as module or part of the main kernel image? The latter
> is simpler to handle as you don't have to deal with modules as symbol
> sources, find out their addresses, and load them at the right location.
>
Xenomai is built as a part of the main kernel.
>> Is it possible to debug Xenomai with GDB and Qemu?
> Definitely.
>
>> Is it the good way to debug?
>>
>> Thank you for your attention and your help.
>> Sincerely,
>>
>> Omar ZENATI
> Jan
>

Omar ZENATI

