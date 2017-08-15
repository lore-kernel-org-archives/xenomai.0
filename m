MIME-Version: 1.0
From: Ashwin Narayan <ashwinnarayan1994@gmail.com>
Date: Tue, 15 Aug 2017 18:49:59 +0800
Message-ID: <CAKbLDQMT2UZwCCH+-wt+H1rKRshdmoT3eqS5wTxTtutixSX9Hw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: [Xenomai] Setting up the Sensoray Model 526 with Xenomai 3.0.4
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

Hi everyone,

I'm trying to setup the Sensoray Model 526 (which is an ISA bus
device) with Xenomai 3.0.4 on a PCM3365 (a PC/104 form factor
computer). The PC/104 has a bridge from the PCI bus to the ISA bus.

First of all, the device is not automatically detected by the driver.
There are no messages on dmesg from the xeno_analogy module.

I checked the datasheet for which IRQs are free and assigned the board
to IRQ6 (which was free) using the jumpers on the board.

Now I'm suspecting that it could be the ISA address configuration
that's the issue. I think the factory default of 0x2c0 is not
available in the ioport range of my system. So I changed the jumpers
on the board to a different address. However, now I'm not sure how to
get the driver running with the new address. Are there any arguments
to the analogy_config program using which I can specify the address of
the board (and maybe the IRQ too?). Going through the source files
didn't give me any ideas about how these could be specified.

Thanks for helping out.

-Ashwin

