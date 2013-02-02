Message-ID: <510D288B.60305@grandegger.com>
Date: Sat, 02 Feb 2013 15:54:03 +0100
From: Wolfgang Grandegger <wg@grandegger.com>
MIME-Version: 1.0
References: <CADyNBOrR0TRA_ejnb4LJMGZ-WmHwomBS+-YGhS1LOc1ekRf04A@mail.gmail.com>
In-Reply-To: <CADyNBOrR0TRA_ejnb4LJMGZ-WmHwomBS+-YGhS1LOc1ekRf04A@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] (-_-)
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Amit Bhaira <a.hearthacker.b@gmail.com>
Cc: Xenomai@xenomai.org

On 02/02/2013 09:43 AM, Amit Bhaira wrote:
> Hey guys suppose I am having 5 same kind of devices, and i am writing
> a driver for them. Then where is should i register my
> device(rtdm_dev_regisger())?? in probe(once) or in init(5 times) ..
> and i will use it in probe all of them will be having same name so how
> would rt_dev_open() differentiate them ??

This is not much different to a normal Linux driver. In your platform,
pci or whatever probe function you call rtdm_dev_register(), where  you
also provide a name for that device (rtdm_dev->device_name). Have a look
for example to:

http://www.rts.uni-hannover.de/xenomai/lxr/source/ksrc/drivers/serial/rt_mpc52xx_uart.c#1276

Wolfgang.

