Message-ID: <4506BB98.1050109@domain.hid>
Date: Tue, 12 Sep 2006 15:52:24 +0200
From: Wolfgang Grandegger <wg@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-core] [PATCH] rtcan_mem - CAN driver for memory mapped
	SJA1000 controllers
References: <200609121330.16250.matthias.fuchs@domain.hid>
	<4506A66F.5080801@domain.hid> <4506AA48.8080304@domain.hid>
In-Reply-To: <4506AA48.8080304@domain.hid>
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
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
To: Jan Kiszka <jan.kiszka@domain.hid>
Cc: xenomai@xenomai.org

Jan Kiszka wrote:
> Wolfgang Grandegger wrote:
>> Hi Matthias,
>>
>> Matthias Fuchs wrote:
>>> Hi,
>>>
>>> attached you will find a patch that adds support for memory mapped
>>> SJA1000 CAN controllers as they often can be found on embedded boards.
>>> The driver is based on the rtmen_isa driver.
>> What about using request_mem_region()? 
> 
> (and this would also give RTCAN_DRV_NAME some sense again :))
> 
>> While looking to the driver I now
>> realize, that it's mainly duplicated code. Does it not make more sense
>> to make a combined io/mem driver. If io address < 32K it's an io driver
>> else a mem driver.
> 
> And provide two sets of readreg/writereg? What about differences in

Yes.

> chip->irq_flags, are they always like io=edge, mem=level? What about
> defaults for CDR and OCR? Are the arbitrary anyway or do they correlate
> somehow to the access type?

Another module parameter for the irq_flags makes sense, indeed. OCR and 
CDR do not affect the access type. It more defines some electrical 
characteristics.

/* Output control register */
enum SJA1000_PELI_OCR {
     SJA_OCR_MODE_BIPHASE = 0,
     SJA_OCR_MODE_TEST    = 1,
     SJA_OCR_MODE_NORMAL  = 2,
     SJA_OCR_MODE_CLOCK   = 3,
     SJA_OCR_TX0_INVERT   = 1<<2,
     SJA_OCR_TX0_PULLDOWN = 1<<3,
     SJA_OCR_TX0_PULLUP   = 2<<3,
     SJA_OCR_TX0_PUSHPULL = 3<<3,
     SJA_OCR_TX1_INVERT   = 1<<5,
     SJA_OCR_TX1_PULLDOWN = 1<<6,
     SJA_OCR_TX1_PULLUP   = 2<<6,
     SJA_OCR_TX1_PUSHPULL = 3<<6
};

enum SJA1000_PELI_CDR {
     SJA_CDR_CLK_OFF      = 1<<3, /* Clock off (CLKOUT pin) */
     SJA_CDR_CBP          = 1<<6, /* CAN input comparator bypass */
     SJA_CDR_CAN_MODE     = 1<<7  /* CAN mode: 1 = PeliCAN */
};

> When we do not find answers right now (maybe in other Linux CAN
> stacks?), we may postpone the merge and keep is separated until more
> hardware pops up with more use-cases.

No hurry, of course.

>>> The driver has been tested on esd's embedded PowerPC boards with AMCC
>>> PPC405 CPUs.
>>>
>>> Thanks to Jan for giving me some introduction to Xenomai during a
>>> nightly session last friday.
>>>
>>> There's one thing a I am not very satisfied with :-) Why passing half
>>> of the external clock frequency to the module. Because of compatiblity
>>> reasons I kept this behavior of the clock paramter from the ISA driver.
>> The attached patch fixes this and replaces the module parameter "isa"
>> with "io". I also tend to rename the driver into rtcan_io instead
>> rtcan_isa if we keep it.
>>
>> Wolfgang.
>>
> 
> Jan

Wolfgang.


