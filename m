From: "Reitinger, Peter" <preitinger@carl-valentin.de>
Date: Tue, 26 Aug 2014 14:24:59 +0000
Message-ID: <c5ed31c30d6a4dcb92fb91e183b38db0@CVEX13.valentin-carl.de>
Content-Language: de-DE
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: [Xenomai] SPI tx underflow interrupt not available
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: "xenomai@xenomai.org" <xenomai@xenomai.org>

Dear Xenomai people,=0A=
=0A=
=0A=
I am currently trying to=A0write=A0an SPI slave rtdm driver with fifo and d=
ma support. I would like to receive an interrupt if there is an underflow i=
n the tx fifo.=0A=
=0A=
Therefore I try to request the related hardware interrupt (which is irq 125=
 at my emtrion board which has EDMA and 2=A0McSPI interfaces where I am try=
ing McSPI1).=0A=
=0A=
Unfortunately it seems that interrupt 125 is reserved by another linux driv=
er because a list of /proc/irq/125 shows:=0A=
=0A=
root@dimm-am335x:/proc# ls /proc/irq/125=0A=
53100000.sham =A0spurious=0A=
=0A=
I am not very experienced in the configuration of a linux kernel so I have =
no idea how I can check which driver or kernel configuration I have to swit=
ch off to make the hardware interrupt 125 available for my own driver (at l=
east as a shared interrupt).=0A=
=0A=
BTW, I try to request the interrupt as follows which is executed directly i=
n my module init function:=0A=
=0A=
------------------------------------------------=0A=
	printk("before rtdm_dev_register[2]\n");=0A=
	code =3D rtdm_dev_register(&devTemplate);=0A=
	printk("after rtdm_dev_register: code=3D%d\n", code);=0A=
=0A=
	if (code) {=0A=
=0A=
		printk("rtdm_dev_register failed: code=3D%i\n", code);=0A=
	}=0A=
=0A=
	// TODO begin for testing interrupt handling=0A=
=0A=
	// begin rtdm=0A=
//	printk("try to request irq 125...\n");=0A=
//	code =3D rtdm_irq_request(&irq_handle, irq_no, &irq_handler, 0, "my125",=
 NULL);=0A=
//	printk("rtdm_irq_request: code=3D%d\n", code);=0A=
//	code =3D rtdm_irq_enable(&irq_handle);=0A=
//	printk("rtdm_irq_enable: code=3D%d\n", code);=0A=
	// end rtdm=0A=
=0A=
	// begin linux=0A=
	// TODO Warum ist 125 fuer McSpi1 blockiert aber 65 nicht? Liegt wohl an /=
proc/irq/125-Eintrag und dass dieser interrupt exklusiv von anderem Treiber=
 requested wurde!=0A=
	code =3D request_irq(125, myLinuxHandler, 0, "meins", NULL);=0A=
	pr_info("request_irq: code=3D%d\n", code);=0A=
	// end linux=0A=
	// TODO end for testing interrupt handling=0A=
------------------------------------------------=0A=
The output of the code above is:=0A=
=0A=
------------------------------------------------=0A=
[ 1120.658471] before rtdm_dev_register[2]=0A=
[ 1120.665603] after rtdm_dev_register: code=3D0=0A=
[ 1120.670294] genirq: Flags mismatch irq 125. 00000000 (meins) vs. 0000000=
0 (53100000.sham)=0A=
[ 1120.679580] request_irq: code=3D-16=0A=
------------------------------------------------=0A=
 =0A=
=0A=
I do not understand what "Flags mismatch irq 125" exactly means. I could im=
agine it has to do with the fact that irq 125 has been requested by this so=
-called "53100000.sham" (no idea what this is) in some exclusive way so tha=
t my rtdm driver cannot request it as well?=0A=
=0A=
When I switch on "CONFIG_XENO_OPT_NATIVE_INTR=3Dy" in the kernel and use th=
e user interface function by calling the following function:=0A=
=0A=
------------------------------------------------=0A=
static int try_rt_intr() {=0A=
	int code;=0A=
=0A=
	code =3D rt_intr_create(&intr_desc, "tx_underflow", txUnderflowIrq, 0);=0A=
	rt_printf("After rt_intr_create:\n");=0A=
=0A=
	switch (code) {=0A=
	case 0:=0A=
		break; // ok=0A=
	case -ENOMEM:=0A=
		rt_printf("ENOMEM\n");=0A=
		rt_print_flush_buffers();=0A=
		return 1;=0A=
	case -EBUSY:=0A=
		rt_printf("EBUSY\n");=0A=
		rt_print_flush_buffers();=0A=
		return 1;=0A=
	default:=0A=
		rt_printf("other error: %d\n", code);=0A=
		rt_print_flush_buffers();=0A=
		return 1;=0A=
	}=0A=
=0A=
	code =3D rt_intr_inquire(&intr_desc, &intr_info);=0A=
	rt_printf("rt_intr_inquire: code=3D%d\n", code);=0A=
	rt_printf("irq=3D%d, hits=3D%d, name=3D%s\n", intr_info.irq, intr_info.hit=
s, intr_info.name);=0A=
=0A=
=0A=
	code =3D rt_intr_enable(&intr_desc);=0A=
	rt_printf("After rt_intr_enable:\n");=0A=
=0A=
	switch (code) {=0A=
	case 0: // ok=0A=
		break;=0A=
	case -EINVAL:=0A=
		rt_printf("EINVAL\n");=0A=
		rt_print_flush_buffers();=0A=
		return 1;=0A=
	case -EIDRM:=0A=
		rt_printf("EIDRM\n");=0A=
		rt_print_flush_buffers();=0A=
		return 1;=0A=
	}=0A=
=0A=
	rt_printf("Waiting for interrupt...\n");=0A=
	rt_print_flush_buffers();=0A=
	code =3D rt_intr_wait(&intr_desc, TM_INFINITE);=0A=
	rt_printf("After rt_intr_wait:\n");=0A=
=0A=
	switch (code) {=0A=
	case 0: //ok=0A=
		break;=0A=
	case -ETIMEDOUT:=0A=
		rt_printf("ETIMEDOUT\n");=0A=
		rt_print_flush_buffers();=0A=
		rt_intr_delete(&intr_desc);=0A=
		return 1;=0A=
	case -EINVAL:=0A=
		rt_printf("EINVAL\n");=0A=
		rt_print_flush_buffers();=0A=
		rt_intr_delete(&intr_desc);=0A=
		return 1;=0A=
	case -EIDRM:=0A=
		rt_printf("EIDRM\n");=0A=
		rt_print_flush_buffers();=0A=
		rt_intr_delete(&intr_desc);=0A=
		return 1;=0A=
	case -EINTR:=0A=
		rt_printf("EINTR\n");=0A=
		rt_print_flush_buffers();=0A=
		return 1;=0A=
	default:=0A=
		rt_printf("other error: %d\n", code);=0A=
		rt_print_flush_buffers();=0A=
		rt_intr_delete(&intr_desc);=0A=
		return 1;=0A=
	}=0A=
=0A=
	rt_printf("Interrupt arrived!\n");=0A=
	rt_print_flush_buffers();=0A=
	rt_intr_delete(&intr_desc);=0A=
=0A=
	return 0;=0A=
}=0A=
------------------------------------------------=0A=
=0A=
... I get the following output:=0A=
=0A=
------------------------------------------------=0A=
After rt_intr_create:=0A=
rt_intr_inquire: code=3D0=0A=
irq=3D125, hits=3D0, name=3Dtx_underflow=0A=
After rt_intr_enable:=0A=
Waiting for interrupt...=0A=
------------------------------------------------=0A=
=0A=
which means that rt_intr_inquire returns 0, but the following rt_intr_wait =
never returns even though I produce an underflow with a parallel program ca=
ll and which is also shown to be successful because the status bits in the =
related tx underflow register are set. Just the interrupt never occurs.=0A=
=0A=
BTW it is Texas Instruments McSPI as described in SPI__spruh73k.pdf=0A=
=0A=
I am really puzzled and cannot see a way how to move on and handling this i=
nterrupt... :-(=0A=
=0A=
Any help would be highly appreciated.=0A=
=0A=
Kind regards=0A=
Peter Reitinger=

