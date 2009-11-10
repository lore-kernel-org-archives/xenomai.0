Message-ID: <4AF95898.6050806@domain.hid>
Date: Tue, 10 Nov 2009 13:12:08 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <200911101311.12900.anisha.kaul@domain.hid>	<200911101343.09183.anisha.kaul@domain.hid>	<4AF9260E.2020805@domain.hid>
	<200911101454.52764.anisha.kaul@domain.hid>
In-Reply-To: <200911101454.52764.anisha.kaul@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-core] tasklet using Xenomai
List-Id: Xenomai life and development <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Anisha Kaul <anisha.kaul@domain.hid>
Cc: xenomai@xenomai.org

Anisha Kaul wrote:
>>> Thanks for the prompt reply !
>>>
>>> The tasklet I am talking about is supposed to re-set the registers of the
>>> serial port each time an interrupt occurs ! We can do this the following
>>> way in using Linux system calls :
>>>
>>> void resetRegisters (unsigned long currentlyUnused);
>>>
>>> DECLARE_TASKLET  (rs232Tasklet, resetRegisters, 0);
>>>
>>> void resetRegisters (unsigned long currentlyUnused)
>>> {
>>>         outb (0x83, PORT + 3);
>>>         outb (0x01, PORT + 0);
>>>         outb (0x00, PORT + 1);
>>>         outb (0x03, PORT + 3);
>>>         outb (0x01, PORT + 1);
>>>         outb (0x63, PORT + 2);
>>>         outb (0x08, PORT + 4);
>>> }
>> This looks like a weird use of tasklets under mainline. Moreover, they
>> are practically deprecated there.
>>
>>> How am I supposed to do this using Xenomai ?
>> Have you considered simply using the rt_16550A driver for your purpose?
>> You didn't told us your use case from an application POV, so it's hard
>> to say if the driver meets your requirements. But it does not require
>> you fiddling with hardware directly.
>>
>> Jan
> 
> 
> " This looks like a weird use of tasklets under mainline. Moreover, they are 
> practically deprecated there."
> 
> Why do you say this ?

The function you defer from interrupt context into a tasklet is
comparably cheap, specifically on modern systems. So the management
overhead is expect to be in the same dimension as the workload (you do
not gain noticeably shorter IRQ-off times this way).

> 
> " Have you considered simply using the rt_16550A driver for your purpose? "
> 
> I was not aware that a serial port driver for real time does exist ! 
> Secondly, here we are writing a robotic application where we want to stop the 
> robot if we receive data 'x' or move the robot if we receive data 'y'. 
> Can you tell me how can we achieve this functionality with rt_16550A driver.

Check existing examples and the RTDM serial profile documentation.

> Is rt_16550A driver fully stable ?

Yes, it's used, among other things, in robotics for many years.

Jan

-- 
Siemens AG, Corporate Technology, CT SE 2
Corporate Competence Center Embedded Linux

