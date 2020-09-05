From: Giulio Moro <g.moro@qmul.ac.uk>
Subject: Re: Assigning Interrupt Handlers
Date: Sat, 5 Sep 2020 20:54:03 +0000
Message-ID: <AM5PR0701MB23881C6C87F96F6DEF4E51DBB52A0@AM5PR0701MB2388.eurprd07.prod.outlook.com>
References: <MN2PR12MB37578739EBA7AF56D003253FF22D0@MN2PR12MB3757.namprd12.prod.outlook.com>
In-Reply-To: <MN2PR12MB37578739EBA7AF56D003253FF22D0@MN2PR12MB3757.namprd12.prod.outlook.com>
Content-Language: en-GB
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: "xenomai@xenomai.org" <xenomai@xenomai.org>, "Frey, Fred (ext ???)" <f.frey@qvii.com>

Hi Fred,
See here for an example of a rtdm driver that receives interrupts from the =
PRU: https://github.com/BelaPlatform/rtdm_pruss_irq/blob/master/rtdm_pruss_=
irq.c   with ioctl you can set up the interrupts and route them through the=
 interrupt channels and export them to the ARM interrupt controller. The PR=
U interrupt controller is fairly confusing to me so I tried to reference th=
e am335x TRM in the comments where appropriate.
Best,
Giulio
________________________________
From: Xenomai <xenomai-bounces@xenomai.org> on behalf of Frey, Fred (ext ??=
?) via Xenomai <xenomai@xenomai.org>
Sent: Friday, September 4, 2020 10:49:23 PM
To: xenomai@xenomai.org <xenomai@xenomai.org>
Subject: Assigning Interrupt Handlers

Hello all,

I'd like some guidance on the topic of setting up interrupt handlers to wor=
k with Xenomai.

Platform: Debian Buster on AM335x Arm (Beaglebone Black)
Xenomai version: 3.0.10
`uname -r` : 4.14.108-ti-xenomai-r135

Specifically, I'd like to set up a function to run every time the PRU gener=
ates an interrupt that I've defined.
I'm a little confused on what functionality is actually provided here. Read=
ing the docs I easily can find the 'rtdm_irq_request()' function which look=
s like exactly what I need.
However, when looking through the header files I have, I can't find any men=
tion of this function. Looking through some old mailing list posts, I gathe=
red that this function was
actually only callable from the kernel context. So I guess my question is t=
hree-fold:


  1.  Is it possible for me to register an interrupt handler from userspace=
?
  2.  If not, is the prescribed method of doing this to write a device driv=
er?
  3.  If I have to write a device driver for the PRU, would my  interrupt h=
andler have to live inside of my device driver, or would I be able to regis=
ter

a function inside of my client program to be an interrupt handler?

Thanks  in advance,
Fred
