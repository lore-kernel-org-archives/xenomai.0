Message-ID: <d6c8ef150805260959p3f7326bfmd73e97671773dba9@domain.hid>
Date: Mon, 26 May 2008 18:59:55 +0200
From: "Bosko Radivojevic" <bosko.radivojevic@domain.hid>
In-Reply-To: <2ff1a98a0805260947q4587700era0e5af4527a26cfc@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <d6c8ef150805231056n3a9ea030jada65bd5a7c2a2c0@domain.hid>
	<18489.30774.304777.148110@domain.hid>
	<d6c8ef150805260626o3ba03d42sce1100bab89540a5@domain.hid>
	<d6c8ef150805260929yeb4e263o618c446cdd96856b@domain.hid>
	<2ff1a98a0805260947q4587700era0e5af4527a26cfc@domain.hid>
Subject: Re: [Xenomai-help] Interrupt priorities and handling problems
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: xenomai-help <xenomai@xenomai.org>

On Mon, May 26, 2008 at 6:47 PM, Gilles Chanteperdrix
<gilles.chanteperdrix@xenomai.org> wrote:

> Which is a second gpio interrupt. I am afraid from this sequence, it
> appears that the two interrupt are generated at hardware level. Did
> you try setting up the irq with at91_set_gpio_input ?

Yes, I'm sure two interrupts are generated at the hardware level. It
looks on SAM9260 default is Level triggered interrupts, which brings
two interrupts for the pin 1-to-0 change. Actually, I've tried to
change SRCTYPE to Rising edge for PB:
at91_sys_write(AT91_AIC_SMR(3), AT91_AIC_SRCTYPE_RISING);

But then I see no interrupts at all. :)

