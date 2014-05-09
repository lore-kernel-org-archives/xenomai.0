Message-Id: <4843693B-831F-4E2F-B5F3-7D3D1141ADDA@gmail.com>
From: Andreas Glatz <andi.glatz@gmail.com>
In-Reply-To: <mailman.1.1399629601.13467.xenomai@xenomai.org>
Mime-Version: 1.0 (Apple Message framework v936)
Date: Fri, 9 May 2014 11:18:18 +0100
References: <mailman.1.1399629601.13467.xenomai@xenomai.org>
Content-Type: text/plain;
	charset=US-ASCII;
	format=flowed;
	delsp=yes
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] Configuring analog subdevice via analogy
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org


On 9 May 2014, at 11:00, xenomai-request@xenomai.org wrote:
>
> Message: 2
> Date: Thu, 08 May 2014 22:00:30 +0200
> From: Wojciech Domski <wojciech.domski@gmail.com>
> To: xenomai@xenomai.org
> Subject: Re: [Xenomai] Configuring analog subdevice via analogy
> 	interface
> Message-ID: <536BE25E.7040203@gmail.com>
> Content-Type: text/plain; charset=UTF-8; format=flowed
>
> W dniu 2014-04-17 13:14, Wojciech Domski pisze:
>> Dear all,
>>
>> I have question concerning analog subdevice support in Analogy.
>>
>> I have signal Sensoray 626 which is capable of setting range
>> for analog input to +/-5V or +/-10V. During writing the driver
>> for Sensoray 626 I have ported a function which address
>> is put into field of subdevice structure do_cmd.
>>
>> This function can configure multiple channels of analog
>> subdevice separately. However, what should I use from
>> User Space interface to invoke this function (do_cmd)
>> in kernel space?
>>
>> I have tried using a4l_snd_command but this one
>> seems to be dedicated for digital subdevices.
>> Is there a way to do what I want to?
>>
>> Best regards,
>> Wojciech Domski
>>
>> Domski.pl
> I kindly ask you for any inside in above matter.
>


do_cmd is part of the asynchronous interface and should be called  
after invoking a4l_snd_command() on an interface that supports  
asyncronous commands (A4L_SUBD_CMD flag is set). The only examples  
I've seen are in the c code of the analogy utilities cmd_read and  
cmd_write, which are part of the xenomai source code. According to the  
examples, I would say, that a4l_snd_command() should work with analog  
subdevices.

If you only want to use the synchronous interface, then I think you  
should implement 'insn_config' for your analog subdevice and try to  
configure it with the userspace function 'a4l_config_subd' by defining  
extra Commands other than e.g. A4L_INSN_CONFIG_DIO_OUTPUT.

I'm also fairly new to the whole analogy thing. I just managed to  
implement  the synchronous and asynchronous interface for my DAQ  
hardware, which I'm now able to control with the standard analogy  
utility functions insn_read/write, cmd_read/write and insn_bits.

Hope this helps.

A.




