Date: Wed, 15 Feb 2012 14:28:54 +0100
Message-Id: <LZFS46$E4D3AD646781469BE1BDA8BC305EABA1@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From: "giuseppe" <giuseppe@domain.hid>
Subject: [Adeos-main] Crash calling ipipe_register_domain on Atom
	architecture
List-Id: General discussion about Adeos <adeos-main.gna.org>
List-Unsubscribe: <https://mail.gna.org/options/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
List-Archive: </public/adeos-main>
List-Post: <mailto:adeos-main@gna.org>
List-Help: <mailto:adeos-main-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
To: adeos-main@gna.org

Hi,=0A=0Ai need to use adeos-ipipe just at the interrupt level. In trying=
 to =0Aachieve my goal I've been able both to succeed and fail, somewhat =
randomly.=0A=0ASo I decided to play it in steps starting from the very ba=
sic one, i.e. =0Aregistering the HEAD domain and doing nothing with it.=0A=
=0AHere is the simple module I used.=0A=0A-------------------------------=
-------------------------------------=0A#include <linux/module.h>=0A=0A#i=
nclude <linux/ipipe.h>=0A=0AMODULE_LICENSE("GPL");=0A=0Astatic struct ipi=
pe_domain head_domain;=0A=0Astatic void head_domain_entry(void)=0A{=0A   =
     printk("\n***** HEAD_DOMAIN_ENTRY has been called *****\n");=0A}=0A=0A=
int domain_init(void)=0A{=0A        struct ipipe_domain_attr attr;=0A    =
    int retval;=0A=0A        ipipe_init_attr(&attr);=0A        attr.name =
    =3D "MYHEAD";=0A        attr.domid    =3D 0xabcdef;=0A        attr.en=
try    =3D head_domain_entry;=0A        attr.priority =3D IPIPE_HEAD_PRIO=
RITY;=0A        retval =3D ipipe_register_domain(&head_domain, &attr);=0A=
        printk("***** IPIPE_REGISTER_DOMAIN returned %d *****\n", retval)=
;=0A        return 0;=0A}=0A=0Avoid domain_exit(void)=0A{=0A        ipipe=
_unregister_domain(&head_domain);=0A        return;=0A}=0A=0Amodule_init(=
domain_init);=0Amodule_exit(domain_exit);=0A-----------------------------=
---------------------------------------=0A=0AThe above module works with =
2.6.32.11 patched with =0Aadeos-ipipe-2.6.32.11-x86-2.6-03.patch but when=
 used with 2.6.35.9 and =0Aadeos-ipipe-2.6.35.9-x86-2.8-04.patch it simpl=
y locks the machine.=0A=0A(For your information it works also with kernel=
 2.6.32.20 with=0Aadeos-ipipe-2.6.32.20-x86-2.7-03.patch)=0A=0A=0AFollowi=
ng those locks I tried a silly brute force debugging by =0Aanticipating t=
he exiting from ipipe_register_domain at various points.=0A=0ABy so doing=
 I found that the following:=0A		 .=0A		 .=0A		 .=0A         /*=0A       =
   * Finally, allow the new domain to perform its initialization=0A      =
    * duties.=0A          */=0A         local_irq_save_hw_smp(flags);=0A =
        __ipipe_current_domain =3D ipd;=0A         local_irq_restore_hw_s=
mp(flags);=0A         attr->entry();=0A		 return 123456;=0A		 .=0A		 .=0A=
		 .=0Aavoids the locking and let me read the following with dmesg:=0A=0A=
-----------------------------------------------------------------------=0A=
I-pipe: Domain MYHEAD registered.=0ABUG: Unhandled exception over domain =
MYHEAD at 0x805d1df - switching to ROOT=0A=0A***** HEAD_DOMAIN_ENTRY has =
been called *****=0A***** IPIPE_REGISTER_DOMAIN returned 123456 *****=0AP=
id: 751, comm: udevd Not tainted 2.6.35.9-adeos #3=0ACall Trace:=0A [<c10=
15dbb>] __ipipe_handle_exception+0x165/0x1af=0A [<c13f7b6b>] error_code+0=
x63/0x70=0A--------------------------------------------------------------=
---------=0A=0AFollowing it I discovered that the fault can be avoided by=
 commenting a =0Asingle instruction as for:=0A		 .=0A		 .=0A		 .=0A      =
   /*=0A          * Finally, allow the new domain to perform its initiali=
zation=0A          * duties.=0A          */=0A         local_irq_save_hw_=
smp(flags);=0A//        __ipipe_current_domain =3D ipd;=0A         local_=
irq_restore_hw_smp(flags);=0A         attr->entry();=0A		 .=0A		 .=0A		 .=
=0Aand letting the function finish normally.=0A=0AI've been unable to und=
erstand why such an assignment causes the =0Areported trap.=0A=0ASo: what=
 am I doing wrong?=0A=0AMy hardware is based on an AXIOM industrial grade=
 CPU SHB212 with an Intel Atom D425 CPU @1.8GHz.=0AThe system chipset is =
an Intel ICH8M.=0AThe kernel is compiled without SMP support configurated=
 for a Pentium III CPU.=0AI tried also defining an Atom CPU but I had the=
 same result.=0ALocal APIC and IO-APIC support enabled.=0AHPET Timer disa=
bled.=0A=0AI tried also to put some barrier() and wmb() calls in the ipip=
e_register_domain=0Ain many points around the critical parts without succ=
ess.=0A=0AGiuseppe.


