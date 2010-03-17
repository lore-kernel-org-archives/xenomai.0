From: Peter Breuer <peter.breuer@domain.hid>
Content-Type: text/plain; charset="UTF-8"
Date: Wed, 17 Mar 2010 23:35:53 +0100
Message-ID: <1268865353.2396.0.camel@domain.hid>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: [Xenomai-help] gpio-keys with xenomai
Reply-To: peter.breuer@domain.hid
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: xenomai@xenomai.org

Hello everyone,
I am new to xenomai, so please be patient.
I am working with an AT91SAM9621S (Board SBC6000X) and I successfully
patched my linux 2.6.24 with xenomai 2.4.9.1. I also have a signal on on
of the GPIOs and I want a program to react, every time the signal
arrives (~10Hz).
Before compiling I added some lines to the board description file
(arch/arm/mach-at91/board-sbc9621.c):
...
static struct gpio_keys_button sbc9261_buttons[] = {
...
//begin changes
    {
        .gpio        = AT91_PIN_PC4,
        .code        = BTN_2,
        .desc        = "GPIO 1",
        .active_low    = 1,
    },
//end changes
};
...
static void __init sbc9261_add_device_buttons(void)
{
...
//begin changes
    at91_set_gpio_input(AT91_PIN_PC4, 1);    /* btn1 */
    at91_set_deglitch(AT91_PIN_PC4, 1);
//end changes

    platform_device_register(&sbc9261_button_device);
}

Now a new event showed up in /dev/input/
Without the xenomai patch there was an interrupt, that I could listen to
with a program (open(/dev/input/event2) and select for listening) and
react to the signal.
With the xenomai patch nothing is coming trough, and even though GPIO 1
still shows up in /proc/interrupts, it doesnt show up
in /proc/xenomai/irq.
I tried to use the native API (I used the usr_irq.c) to create and wait
for the signal, but nothin happend (rt_intr_wait() returned -1).
I would be very happy about every hint in the right direction.
greetings,
Peter 



