Date: Mon, 12 Feb 2007 07:55:37 -0800 (PST)
From: mani bhatti <imranbashirbhatti@domain.hid>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="0-1271499515-1171295737=:52919"
Content-Transfer-Encoding: 8bit
Message-ID: <775081.52919.qm@domain.hid>
Subject: [Xenomai-help] interrupts test
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

--0-1271499515-1171295737=:52919
Content-Type: multipart/alternative; boundary="0-126260276-1171295737=:52919"

--0-126260276-1171295737=:52919
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit

Hi 
I have attached a  kernel module parint.c.When i insert parint.ko  into kernel i get the following message from kernel .

Request_irq returns 0
Interrupt generated. You should see the handler-message
Badness in enable_irq at kernel/irq/manage.c:126
 [<c012da81>] enable_irq+0x68/0xdf
 [<c80be033>] init_module+0x22/0x52 [parint]
 [<c80be000>] handler+0x0/0x11 [parint]
 [<c012c78a>] sys_init_module+0xb5/0x221
 [<c0102898>] syscall_call+0x7/0xb



Please if some one can point out the mistake i would be very helpful.
Thanks.

 
---------------------------------
 Get your own web address.
 Have a HUGE year through Yahoo! Small Business.
--0-126260276-1171295737=:52919
Content-Type: text/html; charset=iso-8859-1
Content-Transfer-Encoding: 8bit

Hi <br>I have attached a&nbsp; kernel module parint.c.When i insert parint.ko&nbsp; into kernel i get the following message from kernel .<br><br>Request_irq returns 0<br>Interrupt generated. You should see the handler-message<br>Badness in enable_irq at kernel/irq/manage.c:126<br>&nbsp;[&lt;c012da81&gt;] enable_irq+0x68/0xdf<br>&nbsp;[&lt;c80be033&gt;] init_module+0x22/0x52 [parint]<br>&nbsp;[&lt;c80be000&gt;] handler+0x0/0x11 [parint]<br>&nbsp;[&lt;c012c78a&gt;] sys_init_module+0xb5/0x221<br>&nbsp;[&lt;c0102898&gt;] syscall_call+0x7/0xb<br><br><br><br>Please if some one can point out the mistake i would be very helpful.<br>Thanks.<br><p>&#32;

<hr size=1>
<a href="http://us.rd.yahoo.com/evt=49678/*http://smallbusiness.yahoo.com/domains/?p=BESTDEAL"> Get your own web address.</a><br> Have a HUGE year through <a href="
http://us.rd.yahoo.com/evt=49678/*http://smallbusiness.yahoo.com/domains/?p=BESTDEAL">Yahoo! Small Business.</a>
--0-126260276-1171295737=:52919--

--0-1271499515-1171295737=:52919
Content-Type: text/x-csrc; name="parint.c"
Content-Description: 4109319093-parint.c
Content-Disposition: inline; filename="parint.c"

#include <linux/module.h>
#include <linux/interrupt.h>
#include <asm/io.h>

#define BASEPORT 0x378

static int handler(void)
{
	// do stuff
	printk(">>> PARALLEL PORT INT HANDLED\n");
	return IRQ_HANDLED;
}

int xinit_module(void)
{
	int ret;
	ret = request_irq(7, handler, SA_INTERRUPT, "parallelport", NULL);
	enable_irq(7);
        printk("\nRequest_irq returns %d \n",ret);

	//set port to interrupt mode; pins are output
	outb_p(0x10, BASEPORT + 2); 

//	printk("Generating interrupt now on all output pins (intr/ACK = pin 10)\n");
	
	//generate interrupt
	outb_p(0, BASEPORT);
	outb_p(255, BASEPORT);
	outb_p(0, BASEPORT);
//	printk("Interrupt generated. You should see the handler-message\n");
	return 0;
}

void xcleanup_module(void)
{
	disable_irq(7);
	free_irq(7, NULL);
}

module_init(xinit_module);
module_exit(xcleanup_module);
MODULE_LICENSE("GPL");

--0-1271499515-1171295737=:52919
Content-Type: application/octet-stream; name=Makefile
Content-Transfer-Encoding: base64
Content-Description: 402397780-Makefile
Content-Disposition: attachment; filename=Makefile

b2JqLW0JOj0gcGFyaW50Lm8KCktESVIJOj0gL2xpYi9tb2R1bGVzLyQoc2hl
bGwgdW5hbWUgLXIpL2J1aWxkClBXRAkJOj0gJChzaGVsbCBwd2QpCgpkZWZh
dWx0OgoJJChNQUtFKSAtQyAkKEtESVIpIFNVQkRJUlM9JChQV0QpIG1vZHVs
ZXMK

--0-1271499515-1171295737=:52919--

