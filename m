From: Matthias Fuchs <matthias.fuchs@domain.hid>
Subject: Re: [Xenomai-core] [PATCH] rtcan_mem - CAN driver for memory mapped
	SJA1000 controllers
Date: Tue, 12 Sep 2006 15:13:40 +0200
References: <200609121330.16250.matthias.fuchs@domain.hid>
	<4506A66F.5080801@domain.hid>
In-Reply-To: <4506A66F.5080801@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200609121513.40749.matthias.fuchs@domain.hid>
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Wolfgang Grandegger <wg@domain.hid>
Cc: xenomai@xenomai.org

Hi Wolfgang,

On Tuesday 12 September 2006 14:22, Wolfgang Grandegger wrote:
> What about using request_mem_region()? While looking to the driver I now 
... will be added, of course.
> realize, that it's mainly duplicated code. Does it not make more sense 
> to make a combined io/mem driver. If io address < 32K it's an io driver
> else a mem driver.
Yes, that's possible. We can also decide on the used module parameter (mem or 
io) what is to do. Passing both results in an error.

You are right that its duplicated code. But the driver is very simple. It 
nearly does nothing but mapping, implementing register access callbacks, 
registering and cleanup when unloading. But the driver differs in all these 
points from the isa/io colleague. I like shot an simple drivers, so that you 
do not have to care about breaking the isa/io part when modifying the mem 
part.

> 
> > There's one thing a I am not very satisfied with :-) Why passing half of 
the 
> > external clock frequency to the module. Because of compatiblity reasons I 
> > kept this behavior of the clock paramter from the ISA driver.
> 
> The attached patch fixes this and replaces the module parameter "isa" 
> with "io". I also tend to rename the driver into rtcan_io instead 
> rtcan_isa if we keep it.
Sounds good.

Matthias

