Message-ID: <4506BCCB.9010105@domain.hid>
Date: Tue, 12 Sep 2006 15:57:31 +0200
From: Wolfgang Grandegger <wg@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-core] [PATCH] rtcan_mem - CAN driver for memory mapped
	SJA1000 controllers
References: <200609121330.16250.matthias.fuchs@domain.hid>
	<4506A66F.5080801@domain.hid>
	<200609121513.40749.matthias.fuchs@domain.hid>
In-Reply-To: <200609121513.40749.matthias.fuchs@domain.hid>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Matthias Fuchs <matthias.fuchs@domain.hid>
Cc: xenomai@xenomai.org

Matthias Fuchs wrote:
> Hi Wolfgang,
> 
> On Tuesday 12 September 2006 14:22, Wolfgang Grandegger wrote:
>> What about using request_mem_region()? While looking to the driver I now 
> ... will be added, of course.
>> realize, that it's mainly duplicated code. Does it not make more sense 
>> to make a combined io/mem driver. If io address < 32K it's an io driver
>> else a mem driver.
> Yes, that's possible. We can also decide on the used module parameter (mem or 
> io) what is to do. Passing both results in an error.
> 
> You are right that its duplicated code. But the driver is very simple. It 
> nearly does nothing but mapping, implementing register access callbacks, 
> registering and cleanup when unloading. But the driver differs in all these 
> points from the isa/io colleague. I like shot an simple drivers, so that you 
> do not have to care about breaking the isa/io part when modifying the mem 
> part.
> 
>>> There's one thing a I am not very satisfied with :-) Why passing half of 
> the 
>>> external clock frequency to the module. Because of compatiblity reasons I 
>>> kept this behavior of the clock paramter from the ISA driver.
>> The attached patch fixes this and replaces the module parameter "isa" 
>> with "io". I also tend to rename the driver into rtcan_io instead 
>> rtcan_isa if we keep it.
> Sounds good.

Jan, could you apply this patch to avoid further confusion? The real CAN 
clock frequency listed also in the proc file system is half of the 
oscillator clock. Some more doc might help to avoid further confusion.

Wolfgang.


