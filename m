MIME-Version: 1.0
From: adilkaraoz <adilkaraoz@domain.hid>
Date: Sat, 4 Dec 2010 09:16:21 +0200
Message-ID: <AANLkTinAGmVQDLOho-9vniRgcsu3rFmRuX4Ft=p7uK=i@domain.hid>
Content-Type: multipart/alternative; boundary=90e6ba53a884cb298f0496906f76
Subject: [Xenomai-help] How to Obtaining Pci Device Private Data ( base
	Address ) with RTDM
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: xenomai@xenomai.org

--90e6ba53a884cb298f0496906f76
Content-Type: text/plain; charset=ISO-8859-9
Content-Transfer-Encoding: quoted-printable

Hi,

I want to obtain private data of my PLX pci device but I don't understand
anything what I do. Starting of my code below please help me.

/**
* define devices our driver supports
*/
static struct pci_device_id pic1711_ids[]=3D{ { PCI_DEVICE(PCI_VENDOR_ID_PL=
X,
PCI_DEVICE_ID_1711) },{0,}, };

/**
* export pci_device_id structure to user space, allowing hotplug
*/
MODULE_DEVICE_TABLE (pci, pic1711_ids);

/**
* create pci_driver structure,
* and register it in cpci_ea221_driver_init_module,
* unregister in cpci_ea221_driver_exit_module
*/
static struct pci_driver pci1711_driver =3D {

.name     =3D DRV_NAME,
.id_table =3D pic1711_ids,
 .probe    =3D pci1711_probe,
.remove  =3D __devexit_p(pci1711_remove),
};

/**
* Init module function
*/
static int xeno_pic1711_driver_init_module(void){

static int ret_val;
 printk( KERN_DEBUG "Module xenoPci1711_driver init\n" );

ret_val =3D pci_register_driver(&pci1711_driver);
 return ret_val;
}

And I found this code for obtain private data.

struct pci_dev *pcidev;

printk("PCI-1711 DETECT PCI \n");
  pcidev=3DNULL;
  pcidev =3Dpci_get_device (PCI_VENDOR_ID_PLX, PCI_DEVICE_ID_1711, pcidev )=
;

  if (pcidev=3D=3DNULL){
       printk("PCI-1711 CANNOT BE FOUND \n");
  }
  else{

     printk("PCI-1711 LOCATED \n");
     if (pci_enable_device(pcidev)){

         printk("PCI-1711 NOT ENABLED \n");

         return(-EIO);

       }
       else{
         printk("PCI-1711 ENABLED \n");
       }

     //PCI_BASE_ADRESS_1711=3D pci_resource_start(pcidev, 1)&
  //PCI_BASE_ADDRESS_MEM_MASK; printk("PCI-1711 DETECT PCI %x
\n",PCI_BASE_ADRESS_1711);

With this code pci_dev used but my code has pci_driver I don't understand
relation between pci_dev and pci_driver.

--=20
Adil Kara=F6z
C TECH Yaz=FDl=FDm Geli=FEtiricisi
GYTE Bilgisayar M=FChendisli=F0i

--90e6ba53a884cb298f0496906f76
Content-Type: text/html; charset=ISO-8859-9
Content-Transfer-Encoding: quoted-printable

Hi,<div><br></div><div>I want to obtain private data of my PLX pci device b=
ut I don&#39;t understand anything what I do. Starting of my code below ple=
ase help me.</div><div><br></div><div><div>/**</div><div>* define devices o=
ur driver supports</div>

<div>*/</div><div>static struct pci_device_id pic1711_ids[]=3D{ { PCI_DEVIC=
E(PCI_VENDOR_ID_PLX, PCI_DEVICE_ID_1711) },{0,}, };</div><div><br></div><di=
v>/**</div><div>* export pci_device_id structure to user space, allowing ho=
tplug</div>

<div>*/</div><div>MODULE_DEVICE_TABLE (pci, pic1711_ids);</div><div><br></d=
iv><div>/**</div><div>* create pci_driver structure,</div><div>* and regist=
er it in cpci_ea221_driver_init_module,</div><div>* unregister in cpci_ea22=
1_driver_exit_module</div>

<div>*/</div><div>static struct pci_driver pci1711_driver =3D {</div><div><=
br></div><div><span class=3D"Apple-tab-span" style=3D"white-space:pre">	</s=
pan>.name =A0 =A0 =3D DRV_NAME,</div><div><span class=3D"Apple-tab-span" st=
yle=3D"white-space:pre">	</span>.id_table =3D pic1711_ids,</div>

<div><span class=3D"Apple-tab-span" style=3D"white-space:pre">	</span>.prob=
e =A0 =A0=3D pci1711_probe,</div><div><span class=3D"Apple-tab-span" style=
=3D"white-space:pre">	</span>.remove<span class=3D"Apple-tab-span" style=3D=
"white-space:pre">	</span> =A0=3D __devexit_p(pci1711_remove),</div>

<div>};</div><div><br></div><div><div>/**</div><div>* Init module function<=
/div><div>*/</div><div>static int xeno_pic1711_driver_init_module(void){</d=
iv><div><br></div><div><span class=3D"Apple-tab-span" style=3D"white-space:=
pre">	</span>static int ret_val;</div>

<div><span class=3D"Apple-tab-span" style=3D"white-space:pre">	</span>print=
k( KERN_DEBUG &quot;Module xenoPci1711_driver init\n&quot; );</div><div><br=
></div><div><span class=3D"Apple-tab-span" style=3D"white-space:pre">	</spa=
n>ret_val =3D pci_register_driver(&amp;pci1711_driver);</div>

<div><span class=3D"Apple-tab-span" style=3D"white-space:pre">	</span></div=
><div><span class=3D"Apple-tab-span" style=3D"white-space:pre">	</span>retu=
rn ret_val;</div><div>}</div></div><div><br></div><div>And I found this cod=
e for obtain private data.</div>

<div><br></div><div><div>struct pci_dev *pcidev;</div><div><br></div><div>p=
rintk(&quot;PCI-1711 DETECT PCI \n&quot;);</div><div>=A0<span class=3D"Appl=
e-tab-span" style=3D"white-space:pre">	</span>pcidev=3DNULL;</div><div>=A0<=
span class=3D"Apple-tab-span" style=3D"white-space:pre">	</span>pcidev =3Dp=
ci_get_device (PCI_VENDOR_ID_PLX, PCI_DEVICE_ID_1711, pcidev );</div>

<div>=A0<span class=3D"Apple-tab-span" style=3D"white-space:pre">	</span></=
div><div>=A0<span class=3D"Apple-tab-span" style=3D"white-space:pre">	</spa=
n>if (pcidev=3D=3DNULL){</div><div>=A0=A0 =A0 =A0 printk(&quot;PCI-1711 CAN=
NOT BE FOUND \n&quot;);</div>

<div>=A0<span class=3D"Apple-tab-span" style=3D"white-space:pre">	</span>}<=
/div><div>=A0<span class=3D"Apple-tab-span" style=3D"white-space:pre">	</sp=
an>else{</div><div>=A0<span class=3D"Apple-tab-span" style=3D"white-space:p=
re">	</span></div>

<div>=A0=A0 =A0<span class=3D"Apple-tab-span" style=3D"white-space:pre">	</=
span>printk(&quot;PCI-1711 LOCATED \n&quot;);</div><div>=A0=A0 =A0<span cla=
ss=3D"Apple-tab-span" style=3D"white-space:pre">	</span>if (pci_enable_devi=
ce(pcidev)){</div>

<div>=A0=A0 =A0<span class=3D"Apple-tab-span" style=3D"white-space:pre">	</=
span></div><div>=A0=A0 =A0 =A0 =A0<span class=3D"Apple-tab-span" style=3D"w=
hite-space:pre">	</span>printk(&quot;PCI-1711 NOT ENABLED \n&quot;);</div><=
div>=A0=A0 =A0 =A0 =A0</div><div>

=A0=A0 =A0 =A0 =A0<span class=3D"Apple-tab-span" style=3D"white-space:pre">=
	</span>return(-EIO);</div><div>=A0=A0 =A0 =A0 =A0</div><div>=A0=A0 =A0 =A0=
<span class=3D"Apple-tab-span" style=3D"white-space:pre">		</span>}</div><d=
iv>=A0=A0 =A0 =A0<span class=3D"Apple-tab-span" style=3D"white-space:pre">	=
</span>else{</div>

<div>=A0=A0 =A0 =A0 =A0<span class=3D"Apple-tab-span" style=3D"white-space:=
pre">	</span>printk(&quot;PCI-1711 ENABLED \n&quot;);</div><div>=A0=A0 =A0 =
=A0<span class=3D"Apple-tab-span" style=3D"white-space:pre">	</span>}</div>=
<div>=A0=A0 =A0 =A0=A0</div><div>

=A0=A0 =A0<span class=3D"Apple-tab-span" style=3D"white-space:pre">	</span>=
//PCI_BASE_ADRESS_1711=3D pci_resource_start(pcidev, 1)&amp; =A0=A0</div><d=
iv>=A0<span class=3D"Apple-tab-span" style=3D"white-space:pre">		</span>//P=
CI_BASE_ADDRESS_MEM_MASK; printk(&quot;PCI-1711 DETECT PCI %x \n&quot;,PCI_=
BASE_ADRESS_1711);</div>

</div><div><br></div><div>With this code pci_dev used but my code has pci_d=
river I don&#39;t understand relation between pci_dev and pci_driver.</div>=
<br>-- <br>Adil Kara=F6z<div>C TECH Yaz=FDl=FDm Geli=FEtiricisi</div><div>G=
YTE Bilgisayar M=FChendisli=F0i</div>

<br>
</div>

--90e6ba53a884cb298f0496906f76--

