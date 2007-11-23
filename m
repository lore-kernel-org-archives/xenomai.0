Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----_=_NextPart_001_01C82DAE.D191F5A9"
Date: Fri, 23 Nov 2007 09:57:04 +0100
Message-ID: <0456E5B751F6DB4A83688EED49C9CAF705731F4D@CHNIS191.bystronic.metal.firm>
From: "Lauener Nathan" <Nathan.Lauener@domain.hid>
Subject: [Xenomai-help] RTDM and user space task synchronisation problem
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

This is a multi-part message in MIME format.

------_=_NextPart_001_01C82DAE.D191F5A9
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Hi,=20

we have ported a largely POSIX based QNX application to Linux. It is a =
machine control application with hard real time requirements. We use the =
POSIX-skin of Xenomai and so far the user space tasks seem to run well. =
Calling pthread_set_mode_np(0,PTHREAD_PRIMARY) returns with no error.=20
But we are having some problems with the RTDM based driver. Our =
interrupt handler should wake up a user task after finishing its work. =
The IOCTL-function invoked by the user calls rtdm_event_wait() and the =
interrupt handler invokes rtdm_event_pulse(). At first we had page =
faults and the kernel printed the following message before rebooting=20

BUG: unable to handle kernel paging request<0>------------[ cut here =
]------------

The variable of type rtdm_event_t is initialised in the init function of =
the module. The documentation for rtdm_event_wait() states that it can =
only be called from a realtime environment. Checking for this condition =
with rtdm_in_rt_context() in the IOCTL-function revealed that the =
function is called in non realtime context. Without calling =
rtdm_event_wait() when in the non realtime environment we don't have any =
page faults any more (and no synchronisation). To my understanding the =
IOCTL function should be executed in the context of the caller. Any =
suggestions to what I am missing? Linux kernel version is 2.6.23.1 and =
the Xenomai version used is 2.3.94.=20

Regards,
Nathan

Heres the source code. I removed some of the cases of the IOCTL switch =
statement.

#ifndef BYSTRONIC_H_
#define BYSTRONIC_H_

#include <linux/ioctl.h>
#ifdef _cplusplus
extern "C"{
#endif

#include "../common.isrtypes.h"

struct by_ioctl_param_in
{
  int int1;
  int int2;
  int int3;
  int int4;
  char *pchar;
  struct PciRegisterDefinition regdef;
};

struct by_ioctl_param_in_ext
{
  void * obj;
  struct HwComponentIdent ident;
  enum isrInfoType type;
  struct PciRegisterDefinition regdef;
  struct by_ioctl_param_in params;
};

struct by_ioctl_path_element
{
  int int1;
  int int2;
  struct PathCtrlElement element;
};

struct by_pci_device
{
  int uid;
  struct pci_dev* dev;
  volatile unsigned int* bar_addresses_begin_kernel[6];
  volatile unsigned int* bar_addresses_end_kernel[6];
  volatile unsigned int* bar_addresses_begin_user[6];
  volatile unsigned int* bar_addresses_end_user[6];
};


/* 0xCC als 'magic-number' verwenden -> siehe =
<linux-sources>/Documentation/ioctl-number.txt*/
//#define BY_IOC_MAGIC 0xCC
#define RTDM_CLASS_BYSTRONIC    20
#define BY_IOC_MAGIC RTDM_CLASS_BYSTRONIC
#define RTDM_SUBCLASS_BYSTRONIC 1

/* Der Versions-String darf h=F6chstens 30 Zeichen lang sein*/
#define BY_IOC_GET_VERSION                     _IO(BY_IOC_MAGIC,0)
#define BY_IOC_RESET                           _IO(BY_IOC_MAGIC,1)
#define BY_IOC_SET_INTR_MASTER                 =
_IOW(BY_IOC_MAGIC,2,struct by_ioctl_param_in)
#define BY_IOC_REMOVE_INTR_MASTER              =
_IOW(BY_IOC_MAGIC,3,struct by_ioctl_param_in)
#define BY_IOC_INIT_ISR                        _IO(BY_IOC_MAGIC,4) /* =
init interrupt service routine */
#define BY_IOC_DETACH_ISR                      _IO(BY_IOC_MAGIC,5) /* =
remove interrupt service routine */
#define BY_IOC_GET_EVENT                       =
_IOR(BY_IOC_MAGIC,6,struct IsrInfo) /* get interrupt event */
#define BY_IOC_ADD_NC_CLIENT                   =
_IOW(BY_IOC_MAGIC,7,struct by_ioctl_param_in)
#define BY_IOC_ADD_ISR_OBJECT                  =
_IOWR(BY_IOC_MAGIC,8,struct by_ioctl_param_in_ext)
#define BY_IOC_REMOVE_ISR_OBJECT               =
_IOW(BY_IOC_MAGIC,9,struct by_ioctl_param_in)
#define BY_IOC_SET_IN_WRITE_REGISTER           =
_IOW(BY_IOC_MAGIC,10,struct by_ioctl_param_in)
#define BY_IOC_SET_IN_READ_REGISTER            =
_IOW(BY_IOC_MAGIC,11,struct by_ioctl_param_in)
#define BY_IOC_SET_IN_FUNCTION                 =
_IOW(BY_IOC_MAGIC,12,struct by_ioctl_param_in)
#define BY_IOC_SET_OUT_READ_VALUE              =
_IOW(BY_IOC_MAGIC,13,struct by_ioctl_param_in)
#define BY_IOC_SET_RING_BUF_ELEMENT            =
_IOW(BY_IOC_MAGIC,14,struct by_ioctl_param_in)
#define BY_IOC_SET_RING_BUF_ELEMENT_READ_VALUE =
_IOW(BY_IOC_MAGIC,15,struct by_ioctl_param_in)
#define BY_IOC_SET_RING_BUF_CLEAR              =
_IOW(BY_IOC_MAGIC,16,struct by_ioctl_param_in)
#define BY_IOC_GET_RING_BUF_TIME               =
_IOWR(BY_IOC_MAGIC,17,struct by_ioctl_param_in)
#define BY_IOC_GET_RING_BUF_FREE               =
_IOWR(BY_IOC_MAGIC,18,struct by_ioctl_param_in)
#define BY_IOC_GET_RING_BUF_INFO               =
_IOWR(BY_IOC_MAGIC,19,struct PathCtrlInfo)
#define BY_IOC_GET_RING_BUF_ELEMENT            =
_IOWR(BY_IOC_MAGIC,20,struct by_ioctl_path_element)
#define BY_IOC_READ_RING_BUF_ELEMENT           =
_IOWR(BY_IOC_MAGIC,21,struct by_ioctl_path_element)
#define BY_IOC_RING_BUF_REMOVE_TIME            =
_IOWR(BY_IOC_MAGIC,22,struct by_ioctl_param_in)
#define BY_IOC_SET_UID                         =
_IOW(BY_IOC_MAGIC,23,struct by_ioctl_param_in)

#ifdef _cplusplus
}
#endif

#endif /*BYSTRONIC_H_*/



#define _include_isrtypesVersion_
#include "bystronic.h"

#include <linux/moduleparam.h>
#include <linux/module.h>
#include <linux/init.h>
#include <linux/pci.h>
#include <linux/string.h>
#include <linux/errno.h>
#include <asm/uaccess.h>
#include <asm/io.h>

#include <rtdm/rtdm_driver.h>

#include "../common.isrtypes.h"
#include "../common.isrltcon.h"
#include "../common.isrltcon.pathctrl.h"

static const unsigned int size_dev_table =3D 12;

static struct by_pci_device* devices[12];
static int isOpen =3D 0;

MODULE_LICENSE("GPL");
MODULE_AUTHOR("nathan.lauener@domain.hid");
MODULE_VERSION("0.0.1");


#ifndef PCI_VENDOR_ID_BYSTRONIC
#define PCI_VENDOR_ID_BYSTRONIC 0x17c7
#endif

enum E_State{
  E_State_Ready,
  E_State_Intr_Master_Assigned,
  E_State_Irq_Attached
};

rtdm_event_t event; =20
rtdm_irq_t irqHandler;
static enum E_State state =3D E_State_Ready;
static int allUidsSet =3D 0;

...

int by_irq_handler(rtdm_irq_t *irq_handle)
{
  // eigentlichen Interrupt-Handler aufrufen
  if (isrLtConRunISR())
  {
    return RTDM_IRQ_HANDLED;
  }

  // Eintreffen eines Interrupt signalisieren
  rtdm_event_pulse(&event);
  return RTDM_IRQ_HANDLED;
}

int by_open(struct rtdm_dev_context *context,
      rtdm_user_info_t * user_info, int oflags)
{ =20
  if(isOpen)
    return -EBUSY;
  =20
  isOpen =3D 1;
  state =3D E_State_Ready;
  return 0;
}

int by_ioctl_common(struct rtdm_dev_context *context, rtdm_user_info_t * =
user_info,
    unsigned int request, void *arg)
{
  int iRet =3D 0;
  switch (request)
  {
    ...

  case BY_IOC_GET_EVENT:
  {
    struct IsrInfo ret;
    int iRet;
    rtdm_printk("Command: BY_IOC_GET_EVENT.\n");
    ret =3D isrLtConGetEvent();
    rtdm_printk("Command: BY_IOC_GET_EVENT: Called =
isrLtConGetEvent().\n");
    if (!ret.obj)
    {
      rtdm_printk("Command: BY_IOC_GET_EVENT: Waiting for event.\n");
      /* Rueckgabewert ignorieren; immer pruefen, ob Daten verarbeitet =
werden muessen. */
      if(rtdm_in_rt_context() !=3D 0)
      {
        rtdm_printk("Command: BY_IOC_GET_EVENT: Caller is in realtime =
context.\n");
        rtdm_event_wait(&event);
        ret =3D isrLtConGetEvent();
      }
      else
      {
        rtdm_printk("Command: BY_IOC_GET_EVENT: Caller is not in =
realtime context.\n");
        return -1;
      }
    }
    iRet =3D rtdm_safe_copy_to_user(user_info,arg, &ret, sizeof(struct =
IsrInfo));
    return iRet;
  }
    break;
  ...
  default:
    rtdm_printk("by_ioctl: Command not implemented\n");
    return -EPERM;
  }
  return -ENOTTY; =20
}

int by_ioctl(struct rtdm_dev_context *context, rtdm_user_info_t * =
user_info,
    unsigned int request, void *arg)
{
  int iRet =3D 0;
  if(!isOpen)
  {
    rtdm_printk("by_ioctl: Called without driver beeing open.\n");
    return -1;
  }
 =20
//  rtdm_printk("by_ioctl called: request %u\n",request);
  switch (request)
  {
    ...
  }
 =20
//  rtdm_printk("by_ioctl(): state is %i\n",state);
  switch (state)
  {
  case E_State_Ready:
  {
    if( request =3D=3D BY_IOC_SET_INTR_MASTER)
    {
      struct by_ioctl_param_in params;
      int iDevice;
      iRet =3D rtdm_safe_copy_from_user(user_info,&params, (struct =
by_ioctl_param_in*)arg,
          sizeof(struct by_ioctl_param_in));
      if (iRet < 0)
        return -iRet;

      rtdm_printk("Command: BY_IOC_SET_INTR_MASTER.\n");
      rtdm_printk(" uid:%i,bar:%i,tabOffset:%x,maskOffset:%x\n", =
params.int1,
          params.int2, params.int3, params.int4);

      iDevice =3D by_get_device_by_uid(params.int1);
      if (iDevice < 0)
        return -ENODEV;

      rtdm_printk(" irq:%i,tab-addr:%p,mask-addr:%p\n", =
devices[iDevice]->dev->irq,
          devices[iDevice]->bar_addresses_begin_kernel[params.int2] + =
params.int3,
          devices[iDevice]->bar_addresses_begin_kernel[params.int2] + =
params.int4);

      iRet =3D isrLtConSetIntrMaster(devices[iDevice]->dev->irq,
          devices[iDevice]->bar_addresses_begin_kernel[params.int2]+ =
params.int3,
          devices[iDevice]->bar_addresses_begin_kernel[params.int2]+ =
params.int4);
      state =3D E_State_Intr_Master_Assigned;
      return iRet;
    }
    else
      return -EPERM;
  }
    break;
  case E_State_Intr_Master_Assigned:
  {
    switch (request)
    {
    case BY_IOC_REMOVE_INTR_MASTER:
    {
      int iDevice;
      struct by_ioctl_param_in params;
      iRet =3D rtdm_safe_copy_from_user(user_info,&params, (struct =
by_ioctl_param_in*)arg,
          sizeof(struct by_ioctl_param_in));
      if (iRet < 0)
        return -iRet;

      iDevice =3D by_get_device_by_uid(params.int1);
      if (iDevice < 0)
        return -ENODEV;

      rtdm_printk("Command: BY_IOC_REMOVE_INTR_MASTER. =
uid:%i,Device:%i\n",
          params.int1, iDevice);
      isrLtConRemoveIntrMaster(iDevice);
      state =3D E_State_Ready;
      return 0;
    }
      break;
    case BY_IOC_INIT_ISR:
    {
      int iRet;
      rtdm_printk("Command: BY_IOC_INIT_ISR. irq:%i\n", =
isrLtConGetIRQNo());

      iRet =3D rtdm_irq_request(&irqHandler,isrLtConGetIRQNo(), =
by_irq_handler, 0, "bystronic", NULL);
      if (iRet < 0)
        return iRet;
 =20
      state =3D E_State_Irq_Attached;
      return 0;
    }
      break;
    default:
      return by_ioctl_common(context,user_info,request,arg);
    }
  }
    break;
  case E_State_Irq_Attached:
  {
    switch(request)
    {
      ...
    case BY_IOC_REMOVE_INTR_MASTER:
    {
      int iDevice;
      struct by_ioctl_param_in params;
      iRet =3D rtdm_safe_copy_from_user(user_info,&params, (struct =
by_ioctl_param_in*)arg,
          sizeof(struct by_ioctl_param_in));
      if (iRet < 0)
        return -iRet;

      iDevice =3D by_get_device_by_uid(params.int1);
      if (iDevice < 0)
        return -ENODEV;

      rtdm_printk("Command: BY_IOC_REMOVE_INTR_MASTER. =
uid:%i,Device:%i\n",
          params.int1, iDevice);
      rtdm_irq_free(&irqHandler);
      rtdm_event_pulse(&event);
      isrLtConRemoveIntrMaster(iDevice);
      state =3D E_State_Ready;
      return 0;
    }
      break;
    case BY_IOC_DETACH_ISR:
    {
      rtdm_printk("Command: BY_IOC_DETACH_ISR.\n");
      rtdm_irq_free(&irqHandler);
      rtdm_event_pulse(&event);
      state =3D E_State_Intr_Master_Assigned;
      return 0;
    }
      break;
    default:
      return by_ioctl_common(context,user_info,request,arg);
    }
  }
    break;
  default:
    return -EPERM;
  }
}=20

int by_release(struct rtdm_dev_context *context, rtdm_user_info_t * =
user_info)
{
  if (state =3D=3D E_State_Irq_Attached)
  {
    rtdm_irq_free(&irqHandler);
    rtdm_event_pulse(&event);
  }
  isrLtConReset();
  by_clear_all_uids();
  state =3D E_State_Ready;
  isOpen =3D 0;
  return 0;
}

static struct rtdm_device device =3D {
    struct_version:     RTDM_DEVICE_STRUCT_VER,

    device_flags:       RTDM_NAMED_DEVICE | RTDM_EXCLUSIVE,
    context_size:       0,
    device_name:        "bystronic0",
    device_id:          0,
    proc_name:          "bystronic",

    open_rt:            by_open,
    open_nrt:           by_open,

    ops: {
        close_rt:       by_release,=20
        close_nrt:      by_release,

        ioctl_rt:       by_ioctl,
        ioctl_nrt:      by_ioctl,=20
    },

    device_class:       RTDM_CLASS_BYSTRONIC,
    device_sub_class:   RTDM_SUBCLASS_BYSTRONIC,
    driver_name:        "bystronic_xeno",
    driver_version:     RTDM_DRIVER_VER(0, 1, 0),
    peripheral_name:    "Bystronic CNC",
    provider_name:      "Nathan Lauener",
};


static struct pci_dev *dev=3D0;

static int __init by_init(void)
{
	int iRet=3D0, iCount=3D0, iLoop=3D0;
=09
	rtdm_printk("by_init called.\n");
=09
	//Variablen initialisieren
	memset(devices,0,sizeof(devices));
=09
	//PCI Geraete auflisten	und initialisieren
	while ((dev=3Dpci_get_device(PCI_VENDOR_ID_BYSTRONIC,PCI_ANY_ID,dev)) =
!=3D NULL)
	{
		iRet =3D pci_enable_device(dev);
		if(iRet < 0)
		{
			pci_dev_put(dev);
			rtdm_printk("bystronic: Could not enable device.\n");
			continue;
		}
=09
		devices[iCount] =3D (struct by_pci_device*)kmalloc(sizeof(struct =
by_pci_device),GFP_KERNEL);
		memset(devices[iCount],0,sizeof(struct by_pci_device));
		devices[iCount]->uid =3D -1;=20
		devices[iCount]->dev =3D dev;
	=09
		rtdm_printk("device id:%i\n",dev->device);
	=09
		for(iLoop=3D0;iLoop < 6;++iLoop)
		{
		  devices[iCount]->bar_addresses_begin_kernel[iLoop] =3D (volatile =
unsigned int*)pci_resource_start(dev,iLoop);
		 =20
		  /* remap PCI-memory */
		  switch (iLoop)
      {
        case 0:
        case 1:
        case 2:
          devices[iCount]->bar_addresses_begin_kernel[iLoop] =3D=20
                (volatile unsigned int*)ioremap_nocache((unsigned =
long)devices[iCount]->bar_addresses_begin_kernel[iLoop],pci_resource_len(=
dev,iLoop));
          devices[iCount]->bar_addresses_end_kernel[iLoop] =3D=20
                devices[iCount]->bar_addresses_begin_kernel[iLoop] + =
pci_resource_len(dev,iLoop);
         =20
          rtdm_printk("Bar =
%i:%p-%p\n",iLoop,devices[iCount]->bar_addresses_begin_kernel[iLoop],devi=
ces[iCount]->bar_addresses_end_kernel[iLoop]);
      }
		}
				 =20
		if(dev->device =3D=3D 2)
		{
		  rtdm_irq_free(&irqHandler);
		  rtdm_printk("LtCon device ID is %i\n",iCount);
		}
	=09
		++iCount;
	}
=09
	if(iCount =3D=3D 0)
	{
	  rtdm_printk("bystronic_init: No devices found.\n");
	  return -ENODEV;
	}
=09
	//rtdm-Device registrieren
	rtdm_event_init(&event,0);=20
	rtdm_dev_register(&device);
	if(iRet < 0)
	{
    //PCI deaktivieren und Speicher frei geben
    for(iLoop =3D 0;iLoop < size_dev_table;++iLoop)
    {
      if(devices[iLoop] > 0)
      {
        iounmap(devices[iLoop]->bar_addresses_begin_kernel[0]);
        iounmap(devices[iLoop]->bar_addresses_begin_kernel[1]);
        iounmap(devices[iLoop]->bar_addresses_begin_kernel[2]);
        pci_disable_device(devices[iLoop]->dev);
        pci_dev_put(devices[iLoop]->dev);
        kfree(devices[iLoop]);
      }
    }
    memset(devices,0,sizeof(devices));
    rtdm_printk("Registration of rtdm-device failed.Error:%i\n",iRet);
    return iRet;
	}
=09
	rtdm_printk("by_init: habe %i Bystronic-Geraete gefunden.\n",iCount);
	return 0;
}

static void __exit by_exit(void)
{
	int iLoop =3D 0;
=09
	rtdm_printk("by_exit called.\n");
=09
	//RTDM-Device abmelden
	rtdm_event_destroy(&event);
	rtdm_dev_unregister(&device,0);
	 =20
	//PCI deaktivieren und Speicher frei geben
	for(iLoop =3D 0;iLoop < size_dev_table;++iLoop)
	{
		if(devices[iLoop] > 0)
		{
//		  pci_release_region(devices[iLoop]->dev,1);
		  iounmap(devices[iLoop]->bar_addresses_begin_kernel[0]);
		  iounmap(devices[iLoop]->bar_addresses_begin_kernel[1]);
		  iounmap(devices[iLoop]->bar_addresses_begin_kernel[2]);
			pci_disable_device(devices[iLoop]->dev);
			pci_dev_put(devices[iLoop]->dev);
			kfree(devices[iLoop]);
		}
	}
	memset(devices,0,sizeof(devices));
}

module_init(by_init);
module_exit(by_exit); =20

------_=_NextPart_001_01C82DAE.D191F5A9
Content-Type: text/html;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 3.2//EN">
<HTML>
<HEAD>
<META HTTP-EQUIV=3D"Content-Type" CONTENT=3D"text/html; =
charset=3Diso-8859-1">
<META NAME=3D"Generator" CONTENT=3D"MS Exchange Server version =
6.5.7638.1">
<TITLE>RTDM and user space task synchronisation problem</TITLE>
</HEAD>
<BODY>
<!-- Converted from text/rtf format -->

<P><FONT SIZE=3D2 FACE=3D"Verdana">Hi, </FONT>
</P>

<P><FONT SIZE=3D2 FACE=3D"Verdana">we have ported a largely POSIX based =
QNX application to Linux. It is a machine control application with hard =
real time requirements. We use the POSIX-skin of Xenomai and so far the =
user space tasks seem to run well. Calling =
pthread_set_mode_np(0,PTHREAD_PRIMARY) returns with no error. =
</FONT></P>

<P><FONT SIZE=3D2 FACE=3D"Verdana">But we are having some problems with =
the RTDM based driver. Our interrupt handler should wake up a user task =
after finishing its work. The IOCTL-function invoked by the user calls =
rtdm_event_wait() and the interrupt handler invokes rtdm_event_pulse(). =
At first we had page faults and the kernel printed the following message =
before rebooting </FONT></P>

<P><FONT SIZE=3D2 FACE=3D"Verdana">BUG: unable to handle kernel paging =
request&lt;0&gt;------------[ cut here ]------------</FONT>
</P>

<P><FONT SIZE=3D2 FACE=3D"Verdana">The variable of type rtdm_event_t is =
initialised in the init function of the module. The documentation for =
rtdm_event_wait() states that it can only be called from a realtime =
environment. Checking for this condition with rtdm_in_rt_context() in =
the IOCTL-function revealed that the function is called in non realtime =
context. Without calling rtdm_event_wait() when in the non realtime =
environment we don't have any page faults any more (and no =
synchronisation). To my understanding the IOCTL function should be =
executed in the context of the caller. Any suggestions to what I am =
missing? Linux kernel version is 2.6.23.1 and the Xenomai version used =
is 2.3.94. </FONT></P>

<P><FONT SIZE=3D2 FACE=3D"Verdana">Regards,</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Verdana">Nathan</FONT>
</P>

<P><FONT SIZE=3D2 FACE=3D"Verdana">Heres the source code. I removed some =
of the cases of the IOCTL switch statement.</FONT>
</P>

<P><FONT SIZE=3D2 FACE=3D"Verdana">#ifndef BYSTRONIC_H_</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Verdana">#define BYSTRONIC_H_</FONT>
</P>

<P><FONT SIZE=3D2 FACE=3D"Verdana">#include &lt;linux/ioctl.h&gt;</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Verdana">#ifdef _cplusplus</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Verdana">extern &quot;C&quot;{</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Verdana">#endif</FONT>
</P>

<P><FONT SIZE=3D2 FACE=3D"Verdana">#include =
&quot;../common.isrtypes.h&quot;</FONT>
</P>

<P><FONT SIZE=3D2 FACE=3D"Verdana">struct by_ioctl_param_in</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Verdana">{</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Verdana">&nbsp; int int1;</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Verdana">&nbsp; int int2;</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Verdana">&nbsp; int int3;</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Verdana">&nbsp; int int4;</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Verdana">&nbsp; char *pchar;</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Verdana">&nbsp; struct PciRegisterDefinition =
regdef;</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Verdana">};</FONT>
</P>

<P><FONT SIZE=3D2 FACE=3D"Verdana">struct by_ioctl_param_in_ext</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Verdana">{</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Verdana">&nbsp; void * obj;</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Verdana">&nbsp; struct HwComponentIdent =
ident;</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Verdana">&nbsp; enum isrInfoType type;</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Verdana">&nbsp; struct PciRegisterDefinition =
regdef;</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Verdana">&nbsp; struct by_ioctl_param_in =
params;</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Verdana">};</FONT>
</P>

<P><FONT SIZE=3D2 FACE=3D"Verdana">struct by_ioctl_path_element</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Verdana">{</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Verdana">&nbsp; int int1;</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Verdana">&nbsp; int int2;</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Verdana">&nbsp; struct PathCtrlElement =
element;</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Verdana">};</FONT>
</P>

<P><FONT SIZE=3D2 FACE=3D"Verdana">struct by_pci_device</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Verdana">{</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Verdana">&nbsp; int uid;</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Verdana">&nbsp; struct pci_dev* dev;</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Verdana">&nbsp; volatile unsigned int* =
bar_addresses_begin_kernel[6];</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Verdana">&nbsp; volatile unsigned int* =
bar_addresses_end_kernel[6];</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Verdana">&nbsp; volatile unsigned int* =
bar_addresses_begin_user[6];</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Verdana">&nbsp; volatile unsigned int* =
bar_addresses_end_user[6];</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Verdana">};</FONT>
</P>
<BR>

<P><FONT SIZE=3D2 FACE=3D"Verdana">/* 0xCC als 'magic-number' verwenden =
-&gt; siehe =
&lt;linux-sources&gt;/Documentation/ioctl-number.txt*/</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Verdana">//#define BY_IOC_MAGIC 0xCC</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Verdana">#define =
RTDM_CLASS_BYSTRONIC&nbsp;&nbsp;&nbsp; 20</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Verdana">#define BY_IOC_MAGIC =
RTDM_CLASS_BYSTRONIC</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Verdana">#define RTDM_SUBCLASS_BYSTRONIC =
1</FONT>
</P>

<P><FONT SIZE=3D2 FACE=3D"Verdana">/* Der Versions-String darf =
h=F6chstens 30 Zeichen lang sein*/</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Verdana">#define =
BY_IOC_GET_VERSION&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
_IO(BY_IOC_MAGIC,0)</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Verdana">#define =
BY_IOC_RESET&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp; _IO(BY_IOC_MAGIC,1)</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Verdana">#define =
BY_IOC_SET_INTR_MASTER&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; _IOW(BY_IOC_MAGIC,2,struct =
by_ioctl_param_in)</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Verdana">#define =
BY_IOC_REMOVE_INTR_MASTER&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; _IOW(BY_IOC_MAGIC,3,struct =
by_ioctl_param_in)</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Verdana">#define =
BY_IOC_INIT_ISR&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; _IO(BY_IOC_MAGIC,4) /* init interrupt service routine */</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Verdana">#define =
BY_IOC_DETACH_ISR&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
_IO(BY_IOC_MAGIC,5) /* remove interrupt service routine */</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Verdana">#define =
BY_IOC_GET_EVENT&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p; _IOR(BY_IOC_MAGIC,6,struct IsrInfo) /* get interrupt event */</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Verdana">#define =
BY_IOC_ADD_NC_CLIENT&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
_IOW(BY_IOC_MAGIC,7,struct by_ioctl_param_in)</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Verdana">#define =
BY_IOC_ADD_ISR_OBJECT&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
_IOWR(BY_IOC_MAGIC,8,struct by_ioctl_param_in_ext)</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Verdana">#define =
BY_IOC_REMOVE_ISR_OBJECT&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; _IOW(BY_IOC_MAGIC,9,struct =
by_ioctl_param_in)</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Verdana">#define =
BY_IOC_SET_IN_WRITE_REGISTER&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; _IOW(BY_IOC_MAGIC,10,struct by_ioctl_param_in)</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Verdana">#define =
BY_IOC_SET_IN_READ_REGISTER&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp; _IOW(BY_IOC_MAGIC,11,struct =
by_ioctl_param_in)</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Verdana">#define =
BY_IOC_SET_IN_FUNCTION&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
_IOW(BY_IOC_MAGIC,12,struct by_ioctl_param_in)</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Verdana">#define =
BY_IOC_SET_OUT_READ_VALUE&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; _IOW(BY_IOC_MAGIC,13,struct =
by_ioctl_param_in)</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Verdana">#define =
BY_IOC_SET_RING_BUF_ELEMENT&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp; _IOW(BY_IOC_MAGIC,14,struct =
by_ioctl_param_in)</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Verdana">#define =
BY_IOC_SET_RING_BUF_ELEMENT_READ_VALUE _IOW(BY_IOC_MAGIC,15,struct =
by_ioctl_param_in)</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Verdana">#define =
BY_IOC_SET_RING_BUF_CLEAR&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; _IOW(BY_IOC_MAGIC,16,struct =
by_ioctl_param_in)</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Verdana">#define =
BY_IOC_GET_RING_BUF_TIME&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; _IOWR(BY_IOC_MAGIC,17,struct =
by_ioctl_param_in)</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Verdana">#define =
BY_IOC_GET_RING_BUF_FREE&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; _IOWR(BY_IOC_MAGIC,18,struct =
by_ioctl_param_in)</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Verdana">#define =
BY_IOC_GET_RING_BUF_INFO&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; _IOWR(BY_IOC_MAGIC,19,struct =
PathCtrlInfo)</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Verdana">#define =
BY_IOC_GET_RING_BUF_ELEMENT&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp; _IOWR(BY_IOC_MAGIC,20,struct =
by_ioctl_path_element)</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Verdana">#define =
BY_IOC_READ_RING_BUF_ELEMENT&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; _IOWR(BY_IOC_MAGIC,21,struct =
by_ioctl_path_element)</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Verdana">#define =
BY_IOC_RING_BUF_REMOVE_TIME&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp; _IOWR(BY_IOC_MAGIC,22,struct =
by_ioctl_param_in)</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Verdana">#define =
BY_IOC_SET_UID&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp; _IOW(BY_IOC_MAGIC,23,struct by_ioctl_param_in)</FONT>
</P>

<P><FONT SIZE=3D2 FACE=3D"Verdana">#ifdef _cplusplus</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Verdana">}</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Verdana">#endif</FONT>
</P>

<P><FONT SIZE=3D2 FACE=3D"Verdana">#endif /*BYSTRONIC_H_*/</FONT>
</P>
<BR>
<BR>

<P><FONT SIZE=3D2 FACE=3D"Verdana">#define =
_include_isrtypesVersion_</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Verdana">#include =
&quot;bystronic.h&quot;</FONT>
</P>

<P><FONT SIZE=3D2 FACE=3D"Verdana">#include =
&lt;linux/moduleparam.h&gt;</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Verdana">#include =
&lt;linux/module.h&gt;</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Verdana">#include &lt;linux/init.h&gt;</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Verdana">#include &lt;linux/pci.h&gt;</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Verdana">#include =
&lt;linux/string.h&gt;</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Verdana">#include =
&lt;linux/errno.h&gt;</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Verdana">#include =
&lt;asm/uaccess.h&gt;</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Verdana">#include &lt;asm/io.h&gt;</FONT>
</P>

<P><FONT SIZE=3D2 FACE=3D"Verdana">#include =
&lt;rtdm/rtdm_driver.h&gt;</FONT>
</P>

<P><FONT SIZE=3D2 FACE=3D"Verdana">#include =
&quot;../common.isrtypes.h&quot;</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Verdana">#include =
&quot;../common.isrltcon.h&quot;</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Verdana">#include =
&quot;../common.isrltcon.pathctrl.h&quot;</FONT>
</P>

<P><FONT SIZE=3D2 FACE=3D"Verdana">static const unsigned int =
size_dev_table =3D 12;</FONT>
</P>

<P><FONT SIZE=3D2 FACE=3D"Verdana">static struct by_pci_device* =
devices[12];</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Verdana">static int isOpen =3D 0;</FONT>
</P>

<P><FONT SIZE=3D2 =
FACE=3D"Verdana">MODULE_LICENSE(&quot;GPL&quot;);</FONT>

<BR><FONT SIZE=3D2 =
FACE=3D"Verdana">MODULE_AUTHOR(&quot;nathan.lauener@domain.hid&quot;);=
</FONT>

<BR><FONT SIZE=3D2 =
FACE=3D"Verdana">MODULE_VERSION(&quot;0.0.1&quot;);</FONT>
</P>
<BR>

<P><FONT SIZE=3D2 FACE=3D"Verdana">#ifndef =
PCI_VENDOR_ID_BYSTRONIC</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Verdana">#define PCI_VENDOR_ID_BYSTRONIC =
0x17c7</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Verdana">#endif</FONT>
</P>

<P><FONT SIZE=3D2 FACE=3D"Verdana">enum E_State{</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Verdana">&nbsp; E_State_Ready,</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Verdana">&nbsp; =
E_State_Intr_Master_Assigned,</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Verdana">&nbsp; E_State_Irq_Attached</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Verdana">};</FONT>
</P>

<P><FONT SIZE=3D2 FACE=3D"Verdana">rtdm_event_t event;&nbsp; </FONT>

<BR><FONT SIZE=3D2 FACE=3D"Verdana">rtdm_irq_t irqHandler;</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Verdana">static enum E_State state =3D =
E_State_Ready;</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Verdana">static int allUidsSet =3D 0;</FONT>
</P>

<P><FONT SIZE=3D2 FACE=3D"Verdana">...</FONT>
</P>

<P><FONT SIZE=3D2 FACE=3D"Verdana">int by_irq_handler(rtdm_irq_t =
*irq_handle)</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Verdana">{</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Verdana">&nbsp; // eigentlichen =
Interrupt-Handler aufrufen</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Verdana">&nbsp; if (isrLtConRunISR())</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Verdana">&nbsp; {</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Verdana">&nbsp;&nbsp;&nbsp; return =
RTDM_IRQ_HANDLED;</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Verdana">&nbsp; }</FONT>
</P>

<P><FONT SIZE=3D2 FACE=3D"Verdana">&nbsp; // Eintreffen eines Interrupt =
signalisieren</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Verdana">&nbsp; =
rtdm_event_pulse(&amp;event);</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Verdana">&nbsp; return =
RTDM_IRQ_HANDLED;</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Verdana">}</FONT>
</P>

<P><FONT SIZE=3D2 FACE=3D"Verdana">int by_open(struct rtdm_dev_context =
*context,</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Verdana">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
rtdm_user_info_t * user_info, int oflags)</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Verdana">{&nbsp; </FONT>

<BR><FONT SIZE=3D2 FACE=3D"Verdana">&nbsp; if(isOpen)</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Verdana">&nbsp;&nbsp;&nbsp; return =
-EBUSY;</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Verdana">&nbsp;&nbsp; </FONT>

<BR><FONT SIZE=3D2 FACE=3D"Verdana">&nbsp; isOpen =3D 1;</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Verdana">&nbsp; state =3D =
E_State_Ready;</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Verdana">&nbsp; return 0;</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Verdana">}</FONT>
</P>

<P><FONT SIZE=3D2 FACE=3D"Verdana">int by_ioctl_common(struct =
rtdm_dev_context *context, rtdm_user_info_t * user_info,</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Verdana">&nbsp;&nbsp;&nbsp; unsigned int =
request, void *arg)</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Verdana">{</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Verdana">&nbsp; int iRet =3D 0;</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Verdana">&nbsp; switch (request)</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Verdana">&nbsp; {</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Verdana">&nbsp;&nbsp;&nbsp; ...</FONT>
</P>

<P><FONT SIZE=3D2 FACE=3D"Verdana">&nbsp; case BY_IOC_GET_EVENT:</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Verdana">&nbsp; {</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Verdana">&nbsp;&nbsp;&nbsp; struct IsrInfo =
ret;</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Verdana">&nbsp;&nbsp;&nbsp; int iRet;</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Verdana">&nbsp;&nbsp;&nbsp; =
rtdm_printk(&quot;Command: BY_IOC_GET_EVENT.\n&quot;);</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Verdana">&nbsp;&nbsp;&nbsp; ret =3D =
isrLtConGetEvent();</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Verdana">&nbsp;&nbsp;&nbsp; =
rtdm_printk(&quot;Command: BY_IOC_GET_EVENT: Called =
isrLtConGetEvent().\n&quot;);</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Verdana">&nbsp;&nbsp;&nbsp; if =
(!ret.obj)</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Verdana">&nbsp;&nbsp;&nbsp; {</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Verdana">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
rtdm_printk(&quot;Command: BY_IOC_GET_EVENT: Waiting for =
event.\n&quot;);</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Verdana">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* =
Rueckgabewert ignorieren; immer pruefen, ob Daten verarbeitet werden =
muessen. */</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Verdana">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
if(rtdm_in_rt_context() !=3D 0)</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Verdana">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
{</FONT>

<BR><FONT SIZE=3D2 =
FACE=3D"Verdana">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
rtdm_printk(&quot;Command: BY_IOC_GET_EVENT: Caller is in realtime =
context.\n&quot;);</FONT>

<BR><FONT SIZE=3D2 =
FACE=3D"Verdana">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
rtdm_event_wait(&amp;event);</FONT>

<BR><FONT SIZE=3D2 =
FACE=3D"Verdana">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ret =3D =
isrLtConGetEvent();</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Verdana">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
}</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Verdana">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
else</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Verdana">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
{</FONT>

<BR><FONT SIZE=3D2 =
FACE=3D"Verdana">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
rtdm_printk(&quot;Command: BY_IOC_GET_EVENT: Caller is not in realtime =
context.\n&quot;);</FONT>

<BR><FONT SIZE=3D2 =
FACE=3D"Verdana">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return =
-1;</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Verdana">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
}</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Verdana">&nbsp;&nbsp;&nbsp; }</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Verdana">&nbsp;&nbsp;&nbsp; iRet =3D =
rtdm_safe_copy_to_user(user_info,arg, &amp;ret, sizeof(struct =
IsrInfo));</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Verdana">&nbsp;&nbsp;&nbsp; return =
iRet;</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Verdana">&nbsp; }</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Verdana">&nbsp;&nbsp;&nbsp; break;</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Verdana">&nbsp; ...</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Verdana">&nbsp; default:</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Verdana">&nbsp;&nbsp;&nbsp; =
rtdm_printk(&quot;by_ioctl: Command not implemented\n&quot;);</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Verdana">&nbsp;&nbsp;&nbsp; return =
-EPERM;</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Verdana">&nbsp; }</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Verdana">&nbsp; return -ENOTTY;&nbsp; </FONT>

<BR><FONT SIZE=3D2 FACE=3D"Verdana">}</FONT>
</P>

<P><FONT SIZE=3D2 FACE=3D"Verdana">int by_ioctl(struct rtdm_dev_context =
*context, rtdm_user_info_t * user_info,</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Verdana">&nbsp;&nbsp;&nbsp; unsigned int =
request, void *arg)</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Verdana">{</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Verdana">&nbsp; int iRet =3D 0;</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Verdana">&nbsp; if(!isOpen)</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Verdana">&nbsp; {</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Verdana">&nbsp;&nbsp;&nbsp; =
rtdm_printk(&quot;by_ioctl: Called without driver beeing =
open.\n&quot;);</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Verdana">&nbsp;&nbsp;&nbsp; return -1;</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Verdana">&nbsp; }</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Verdana">&nbsp; </FONT>

<BR><FONT SIZE=3D2 FACE=3D"Verdana">//&nbsp; rtdm_printk(&quot;by_ioctl =
called: request %u\n&quot;,request);</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Verdana">&nbsp; switch (request)</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Verdana">&nbsp; {</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Verdana">&nbsp;&nbsp;&nbsp; ...</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Verdana">&nbsp; }</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Verdana">&nbsp; </FONT>

<BR><FONT SIZE=3D2 FACE=3D"Verdana">//&nbsp; =
rtdm_printk(&quot;by_ioctl(): state is %i\n&quot;,state);</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Verdana">&nbsp; switch (state)</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Verdana">&nbsp; {</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Verdana">&nbsp; case E_State_Ready:</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Verdana">&nbsp; {</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Verdana">&nbsp;&nbsp;&nbsp; if( request =
=3D=3D BY_IOC_SET_INTR_MASTER)</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Verdana">&nbsp;&nbsp;&nbsp; {</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Verdana">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
struct by_ioctl_param_in params;</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Verdana">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int =
iDevice;</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Verdana">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; iRet =
=3D rtdm_safe_copy_from_user(user_info,&amp;params, (struct =
by_ioctl_param_in*)arg,</FONT>

<BR><FONT SIZE=3D2 =
FACE=3D"Verdana">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
sizeof(struct by_ioctl_param_in));</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Verdana">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if =
(iRet &lt; 0)</FONT>

<BR><FONT SIZE=3D2 =
FACE=3D"Verdana">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return =
-iRet;</FONT>
</P>

<P><FONT SIZE=3D2 FACE=3D"Verdana">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
rtdm_printk(&quot;Command: BY_IOC_SET_INTR_MASTER.\n&quot;);</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Verdana">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
rtdm_printk(&quot; uid:%i,bar:%i,tabOffset:%x,maskOffset:%x\n&quot;, =
params.int1,</FONT>

<BR><FONT SIZE=3D2 =
FACE=3D"Verdana">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
params.int2, params.int3, params.int4);</FONT>
</P>

<P><FONT SIZE=3D2 FACE=3D"Verdana">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
iDevice =3D by_get_device_by_uid(params.int1);</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Verdana">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if =
(iDevice &lt; 0)</FONT>

<BR><FONT SIZE=3D2 =
FACE=3D"Verdana">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return =
-ENODEV;</FONT>
</P>

<P><FONT SIZE=3D2 FACE=3D"Verdana">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
rtdm_printk(&quot; irq:%i,tab-addr:%p,mask-addr:%p\n&quot;, =
devices[iDevice]-&gt;dev-&gt;irq,</FONT>

<BR><FONT SIZE=3D2 =
FACE=3D"Verdana">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
devices[iDevice]-&gt;bar_addresses_begin_kernel[params.int2] + =
params.int3,</FONT>

<BR><FONT SIZE=3D2 =
FACE=3D"Verdana">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
devices[iDevice]-&gt;bar_addresses_begin_kernel[params.int2] + =
params.int4);</FONT>
</P>

<P><FONT SIZE=3D2 FACE=3D"Verdana">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; iRet =
=3D isrLtConSetIntrMaster(devices[iDevice]-&gt;dev-&gt;irq,</FONT>

<BR><FONT SIZE=3D2 =
FACE=3D"Verdana">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
devices[iDevice]-&gt;bar_addresses_begin_kernel[params.int2]+ =
params.int3,</FONT>

<BR><FONT SIZE=3D2 =
FACE=3D"Verdana">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
devices[iDevice]-&gt;bar_addresses_begin_kernel[params.int2]+ =
params.int4);</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Verdana">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; state =
=3D E_State_Intr_Master_Assigned;</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Verdana">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
return iRet;</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Verdana">&nbsp;&nbsp;&nbsp; }</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Verdana">&nbsp;&nbsp;&nbsp; else</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Verdana">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
return -EPERM;</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Verdana">&nbsp; }</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Verdana">&nbsp;&nbsp;&nbsp; break;</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Verdana">&nbsp; case =
E_State_Intr_Master_Assigned:</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Verdana">&nbsp; {</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Verdana">&nbsp;&nbsp;&nbsp; switch =
(request)</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Verdana">&nbsp;&nbsp;&nbsp; {</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Verdana">&nbsp;&nbsp;&nbsp; case =
BY_IOC_REMOVE_INTR_MASTER:</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Verdana">&nbsp;&nbsp;&nbsp; {</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Verdana">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int =
iDevice;</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Verdana">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
struct by_ioctl_param_in params;</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Verdana">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; iRet =
=3D rtdm_safe_copy_from_user(user_info,&amp;params, (struct =
by_ioctl_param_in*)arg,</FONT>

<BR><FONT SIZE=3D2 =
FACE=3D"Verdana">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
sizeof(struct by_ioctl_param_in));</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Verdana">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if =
(iRet &lt; 0)</FONT>

<BR><FONT SIZE=3D2 =
FACE=3D"Verdana">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return =
-iRet;</FONT>
</P>

<P><FONT SIZE=3D2 FACE=3D"Verdana">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
iDevice =3D by_get_device_by_uid(params.int1);</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Verdana">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if =
(iDevice &lt; 0)</FONT>

<BR><FONT SIZE=3D2 =
FACE=3D"Verdana">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return =
-ENODEV;</FONT>
</P>

<P><FONT SIZE=3D2 FACE=3D"Verdana">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
rtdm_printk(&quot;Command: BY_IOC_REMOVE_INTR_MASTER. =
uid:%i,Device:%i\n&quot;,</FONT>

<BR><FONT SIZE=3D2 =
FACE=3D"Verdana">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
params.int1, iDevice);</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Verdana">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
isrLtConRemoveIntrMaster(iDevice);</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Verdana">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; state =
=3D E_State_Ready;</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Verdana">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
return 0;</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Verdana">&nbsp;&nbsp;&nbsp; }</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Verdana">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
break;</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Verdana">&nbsp;&nbsp;&nbsp; case =
BY_IOC_INIT_ISR:</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Verdana">&nbsp;&nbsp;&nbsp; {</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Verdana">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int =
iRet;</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Verdana">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
rtdm_printk(&quot;Command: BY_IOC_INIT_ISR. irq:%i\n&quot;, =
isrLtConGetIRQNo());</FONT>
</P>

<P><FONT SIZE=3D2 FACE=3D"Verdana">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; iRet =
=3D rtdm_irq_request(&amp;irqHandler,isrLtConGetIRQNo(), by_irq_handler, =
0, &quot;bystronic&quot;, NULL);</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Verdana">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if =
(iRet &lt; 0)</FONT>

<BR><FONT SIZE=3D2 =
FACE=3D"Verdana">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return =
iRet;</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Verdana">&nbsp; </FONT>

<BR><FONT SIZE=3D2 FACE=3D"Verdana">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; state =
=3D E_State_Irq_Attached;</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Verdana">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
return 0;</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Verdana">&nbsp;&nbsp;&nbsp; }</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Verdana">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
break;</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Verdana">&nbsp;&nbsp;&nbsp; default:</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Verdana">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
return by_ioctl_common(context,user_info,request,arg);</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Verdana">&nbsp;&nbsp;&nbsp; }</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Verdana">&nbsp; }</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Verdana">&nbsp;&nbsp;&nbsp; break;</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Verdana">&nbsp; case =
E_State_Irq_Attached:</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Verdana">&nbsp; {</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Verdana">&nbsp;&nbsp;&nbsp; =
switch(request)</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Verdana">&nbsp;&nbsp;&nbsp; {</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Verdana">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
...</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Verdana">&nbsp;&nbsp;&nbsp; case =
BY_IOC_REMOVE_INTR_MASTER:</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Verdana">&nbsp;&nbsp;&nbsp; {</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Verdana">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int =
iDevice;</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Verdana">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
struct by_ioctl_param_in params;</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Verdana">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; iRet =
=3D rtdm_safe_copy_from_user(user_info,&amp;params, (struct =
by_ioctl_param_in*)arg,</FONT>

<BR><FONT SIZE=3D2 =
FACE=3D"Verdana">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
sizeof(struct by_ioctl_param_in));</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Verdana">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if =
(iRet &lt; 0)</FONT>

<BR><FONT SIZE=3D2 =
FACE=3D"Verdana">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return =
-iRet;</FONT>
</P>

<P><FONT SIZE=3D2 FACE=3D"Verdana">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
iDevice =3D by_get_device_by_uid(params.int1);</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Verdana">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if =
(iDevice &lt; 0)</FONT>

<BR><FONT SIZE=3D2 =
FACE=3D"Verdana">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return =
-ENODEV;</FONT>
</P>

<P><FONT SIZE=3D2 FACE=3D"Verdana">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
rtdm_printk(&quot;Command: BY_IOC_REMOVE_INTR_MASTER. =
uid:%i,Device:%i\n&quot;,</FONT>

<BR><FONT SIZE=3D2 =
FACE=3D"Verdana">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
params.int1, iDevice);</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Verdana">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
rtdm_irq_free(&amp;irqHandler);</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Verdana">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
rtdm_event_pulse(&amp;event);</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Verdana">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
isrLtConRemoveIntrMaster(iDevice);</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Verdana">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; state =
=3D E_State_Ready;</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Verdana">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
return 0;</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Verdana">&nbsp;&nbsp;&nbsp; }</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Verdana">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
break;</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Verdana">&nbsp;&nbsp;&nbsp; case =
BY_IOC_DETACH_ISR:</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Verdana">&nbsp;&nbsp;&nbsp; {</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Verdana">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
rtdm_printk(&quot;Command: BY_IOC_DETACH_ISR.\n&quot;);</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Verdana">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
rtdm_irq_free(&amp;irqHandler);</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Verdana">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
rtdm_event_pulse(&amp;event);</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Verdana">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; state =
=3D E_State_Intr_Master_Assigned;</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Verdana">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
return 0;</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Verdana">&nbsp;&nbsp;&nbsp; }</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Verdana">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
break;</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Verdana">&nbsp;&nbsp;&nbsp; default:</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Verdana">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
return by_ioctl_common(context,user_info,request,arg);</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Verdana">&nbsp;&nbsp;&nbsp; }</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Verdana">&nbsp; }</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Verdana">&nbsp;&nbsp;&nbsp; break;</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Verdana">&nbsp; default:</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Verdana">&nbsp;&nbsp;&nbsp; return =
-EPERM;</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Verdana">&nbsp; }</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Verdana">} </FONT>
</P>

<P><FONT SIZE=3D2 FACE=3D"Verdana">int by_release(struct =
rtdm_dev_context *context, rtdm_user_info_t * user_info)</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Verdana">{</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Verdana">&nbsp; if (state =3D=3D =
E_State_Irq_Attached)</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Verdana">&nbsp; {</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Verdana">&nbsp;&nbsp;&nbsp; =
rtdm_irq_free(&amp;irqHandler);</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Verdana">&nbsp;&nbsp;&nbsp; =
rtdm_event_pulse(&amp;event);</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Verdana">&nbsp; }</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Verdana">&nbsp; isrLtConReset();</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Verdana">&nbsp; by_clear_all_uids();</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Verdana">&nbsp; state =3D =
E_State_Ready;</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Verdana">&nbsp; isOpen =3D 0;</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Verdana">&nbsp; return 0;</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Verdana">}</FONT>
</P>

<P><FONT SIZE=3D2 FACE=3D"Verdana">static struct rtdm_device device =3D =
{</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Verdana">&nbsp;&nbsp;&nbsp; =
struct_version:&nbsp;&nbsp;&nbsp;&nbsp; RTDM_DEVICE_STRUCT_VER,</FONT>
</P>

<P><FONT SIZE=3D2 FACE=3D"Verdana">&nbsp;&nbsp;&nbsp; =
device_flags:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; RTDM_NAMED_DEVICE | =
RTDM_EXCLUSIVE,</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Verdana">&nbsp;&nbsp;&nbsp; =
context_size:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0,</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Verdana">&nbsp;&nbsp;&nbsp; =
device_name:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&quot;bystronic0&quot;,</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Verdana">&nbsp;&nbsp;&nbsp; =
device_id:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
0,</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Verdana">&nbsp;&nbsp;&nbsp; =
proc_name:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&quot;bystronic&quot;,</FONT>
</P>

<P><FONT SIZE=3D2 FACE=3D"Verdana">&nbsp;&nbsp;&nbsp; =
open_rt:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
; by_open,</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Verdana">&nbsp;&nbsp;&nbsp; =
open_nrt:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
by_open,</FONT>
</P>

<P><FONT SIZE=3D2 FACE=3D"Verdana">&nbsp;&nbsp;&nbsp; ops: {</FONT>

<BR><FONT SIZE=3D2 =
FACE=3D"Verdana">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
close_rt:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; by_release, </FONT>

<BR><FONT SIZE=3D2 =
FACE=3D"Verdana">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
close_nrt:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; by_release,</FONT>
</P>

<P><FONT SIZE=3D2 =
FACE=3D"Verdana">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
ioctl_rt:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; by_ioctl,</FONT>

<BR><FONT SIZE=3D2 =
FACE=3D"Verdana">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
ioctl_nrt:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; by_ioctl, </FONT>

<BR><FONT SIZE=3D2 FACE=3D"Verdana">&nbsp;&nbsp;&nbsp; },</FONT>
</P>

<P><FONT SIZE=3D2 FACE=3D"Verdana">&nbsp;&nbsp;&nbsp; =
device_class:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
RTDM_CLASS_BYSTRONIC,</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Verdana">&nbsp;&nbsp;&nbsp; =
device_sub_class:&nbsp;&nbsp; RTDM_SUBCLASS_BYSTRONIC,</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Verdana">&nbsp;&nbsp;&nbsp; =
driver_name:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&quot;bystronic_xeno&quot;,</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Verdana">&nbsp;&nbsp;&nbsp; =
driver_version:&nbsp;&nbsp;&nbsp;&nbsp; RTDM_DRIVER_VER(0, 1, 0),</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Verdana">&nbsp;&nbsp;&nbsp; =
peripheral_name:&nbsp;&nbsp;&nbsp; &quot;Bystronic CNC&quot;,</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Verdana">&nbsp;&nbsp;&nbsp; =
provider_name:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &quot;Nathan =
Lauener&quot;,</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Verdana">};</FONT>
</P>
<BR>

<P><FONT SIZE=3D2 FACE=3D"Verdana">static struct pci_dev =
*dev=3D0;</FONT>
</P>

<P><FONT SIZE=3D2 FACE=3D"Verdana">static int __init =
by_init(void)</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Verdana">{</FONT>

<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <FONT SIZE=3D2 =
FACE=3D"Verdana">int iRet=3D0, iCount=3D0, iLoop=3D0;</FONT>

<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=20

<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <FONT SIZE=3D2 =
FACE=3D"Verdana">rtdm_printk(&quot;by_init called.\n&quot;);</FONT>

<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=20

<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <FONT SIZE=3D2 =
FACE=3D"Verdana">//Variablen initialisieren</FONT>

<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <FONT SIZE=3D2 =
FACE=3D"Verdana">memset(devices,0,sizeof(devices));</FONT>

<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=20

<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <FONT SIZE=3D2 =
FACE=3D"Verdana">//PCI Geraete auflisten und initialisieren</FONT>

<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <FONT SIZE=3D2 =
FACE=3D"Verdana">while =
((dev=3Dpci_get_device(PCI_VENDOR_ID_BYSTRONIC,PCI_ANY_ID,dev)) !=3D =
NULL)</FONT>

<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <FONT SIZE=3D2 =
FACE=3D"Verdana">{</FONT>

<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <FONT SIZE=3D2 =
FACE=3D"Verdana">iRet =3D pci_enable_device(dev);</FONT>

<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <FONT SIZE=3D2 =
FACE=3D"Verdana">if(iRet &lt; 0)</FONT>

<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <FONT SIZE=3D2 =
FACE=3D"Verdana">{</FONT>

<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <FONT SIZE=3D2 =
FACE=3D"Verdana">pci_dev_put(dev);</FONT>

<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <FONT SIZE=3D2 =
FACE=3D"Verdana">rtdm_printk(&quot;bystronic: Could not enable =
device.\n&quot;);</FONT>

<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <FONT SIZE=3D2 =
FACE=3D"Verdana">continue;</FONT>

<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <FONT SIZE=3D2 =
FACE=3D"Verdana">}</FONT>

<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=20

<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <FONT SIZE=3D2 =
FACE=3D"Verdana">devices[iCount] =3D (struct =
by_pci_device*)kmalloc(sizeof(struct by_pci_device),GFP_KERNEL);</FONT>

<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <FONT SIZE=3D2 =
FACE=3D"Verdana">memset(devices[iCount],0,sizeof(struct =
by_pci_device));</FONT>

<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <FONT SIZE=3D2 =
FACE=3D"Verdana">devices[iCount]-&gt;uid =3D -1; </FONT>

<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <FONT SIZE=3D2 =
FACE=3D"Verdana">devices[iCount]-&gt;dev =3D dev;</FONT>

<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=20

<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <FONT SIZE=3D2 =
FACE=3D"Verdana">rtdm_printk(&quot;device =
id:%i\n&quot;,dev-&gt;device);</FONT>

<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=20

<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <FONT SIZE=3D2 =
FACE=3D"Verdana">for(iLoop=3D0;iLoop &lt; 6;++iLoop)</FONT>

<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <FONT SIZE=3D2 =
FACE=3D"Verdana">{</FONT>

<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <FONT SIZE=3D2 =
FACE=3D"Verdana">&nbsp; =
devices[iCount]-&gt;bar_addresses_begin_kernel[iLoop] =3D (volatile =
unsigned int*)pci_resource_start(dev,iLoop);</FONT></P>

<P>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <FONT SIZE=3D2 =
FACE=3D"Verdana">&nbsp; </FONT>

<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <FONT SIZE=3D2 =
FACE=3D"Verdana">&nbsp; /* remap PCI-memory */</FONT>

<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <FONT SIZE=3D2 =
FACE=3D"Verdana">&nbsp; switch (iLoop)</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Verdana">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
{</FONT>

<BR><FONT SIZE=3D2 =
FACE=3D"Verdana">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case =
0:</FONT>

<BR><FONT SIZE=3D2 =
FACE=3D"Verdana">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case =
1:</FONT>

<BR><FONT SIZE=3D2 =
FACE=3D"Verdana">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case =
2:</FONT>

<BR><FONT SIZE=3D2 =
FACE=3D"Verdana">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
devices[iCount]-&gt;bar_addresses_begin_kernel[iLoop] =3D </FONT>

<BR><FONT SIZE=3D2 =
FACE=3D"Verdana">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (volatile unsigned =
int*)ioremap_nocache((unsigned =
long)devices[iCount]-&gt;bar_addresses_begin_kernel[iLoop],pci_resource_l=
en(dev,iLoop));</FONT></P>

<P><FONT SIZE=3D2 =
FACE=3D"Verdana">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
devices[iCount]-&gt;bar_addresses_end_kernel[iLoop] =3D </FONT>

<BR><FONT SIZE=3D2 =
FACE=3D"Verdana">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
devices[iCount]-&gt;bar_addresses_begin_kernel[iLoop] + =
pci_resource_len(dev,iLoop);</FONT>

<BR><FONT SIZE=3D2 =
FACE=3D"Verdana">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
</FONT>

<BR><FONT SIZE=3D2 =
FACE=3D"Verdana">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
rtdm_printk(&quot;Bar =
%i:%p-%p\n&quot;,iLoop,devices[iCount]-&gt;bar_addresses_begin_kernel[iLo=
op],devices[iCount]-&gt;bar_addresses_end_kernel[iLoop]);</FONT></P>

<P><FONT SIZE=3D2 FACE=3D"Verdana">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
}</FONT>

<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <FONT SIZE=3D2 =
FACE=3D"Verdana">}</FONT>

<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <FONT SIZE=3D2 =
FACE=3D"Verdana">&nbsp; </FONT>

<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <FONT SIZE=3D2 =
FACE=3D"Verdana">if(dev-&gt;device =3D=3D 2)</FONT>

<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <FONT SIZE=3D2 =
FACE=3D"Verdana">{</FONT>

<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <FONT SIZE=3D2 =
FACE=3D"Verdana">&nbsp; rtdm_irq_free(&amp;irqHandler);</FONT>

<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <FONT SIZE=3D2 =
FACE=3D"Verdana">&nbsp; rtdm_printk(&quot;LtCon device ID is =
%i\n&quot;,iCount);</FONT>

<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <FONT SIZE=3D2 =
FACE=3D"Verdana">}</FONT>

<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=20

<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <FONT SIZE=3D2 =
FACE=3D"Verdana">++iCount;</FONT>

<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <FONT SIZE=3D2 =
FACE=3D"Verdana">}</FONT>

<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=20

<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <FONT SIZE=3D2 =
FACE=3D"Verdana">if(iCount =3D=3D 0)</FONT>

<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <FONT SIZE=3D2 =
FACE=3D"Verdana">{</FONT>

<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <FONT SIZE=3D2 =
FACE=3D"Verdana">&nbsp; rtdm_printk(&quot;bystronic_init: No devices =
found.\n&quot;);</FONT>

<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <FONT SIZE=3D2 =
FACE=3D"Verdana">&nbsp; return -ENODEV;</FONT>

<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <FONT SIZE=3D2 =
FACE=3D"Verdana">}</FONT>

<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=20

<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <FONT SIZE=3D2 =
FACE=3D"Verdana">//rtdm-Device registrieren</FONT>

<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <FONT SIZE=3D2 =
FACE=3D"Verdana">rtdm_event_init(&amp;event,0); </FONT>

<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <FONT SIZE=3D2 =
FACE=3D"Verdana">rtdm_dev_register(&amp;device);</FONT>

<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <FONT SIZE=3D2 =
FACE=3D"Verdana">if(iRet &lt; 0)</FONT>

<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <FONT SIZE=3D2 =
FACE=3D"Verdana">{</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Verdana">&nbsp;&nbsp;&nbsp; //PCI =
deaktivieren und Speicher frei geben</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Verdana">&nbsp;&nbsp;&nbsp; for(iLoop =3D =
0;iLoop &lt; size_dev_table;++iLoop)</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Verdana">&nbsp;&nbsp;&nbsp; {</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Verdana">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
if(devices[iLoop] &gt; 0)</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Verdana">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
{</FONT>

<BR><FONT SIZE=3D2 =
FACE=3D"Verdana">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
iounmap(devices[iLoop]-&gt;bar_addresses_begin_kernel[0]);</FONT>

<BR><FONT SIZE=3D2 =
FACE=3D"Verdana">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
iounmap(devices[iLoop]-&gt;bar_addresses_begin_kernel[1]);</FONT>

<BR><FONT SIZE=3D2 =
FACE=3D"Verdana">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
iounmap(devices[iLoop]-&gt;bar_addresses_begin_kernel[2]);</FONT>

<BR><FONT SIZE=3D2 =
FACE=3D"Verdana">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
pci_disable_device(devices[iLoop]-&gt;dev);</FONT>

<BR><FONT SIZE=3D2 =
FACE=3D"Verdana">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
pci_dev_put(devices[iLoop]-&gt;dev);</FONT>

<BR><FONT SIZE=3D2 =
FACE=3D"Verdana">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
kfree(devices[iLoop]);</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Verdana">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
}</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Verdana">&nbsp;&nbsp;&nbsp; }</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Verdana">&nbsp;&nbsp;&nbsp; =
memset(devices,0,sizeof(devices));</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Verdana">&nbsp;&nbsp;&nbsp; =
rtdm_printk(&quot;Registration of rtdm-device =
failed.Error:%i\n&quot;,iRet);</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Verdana">&nbsp;&nbsp;&nbsp; return =
iRet;</FONT>

<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <FONT SIZE=3D2 =
FACE=3D"Verdana">}</FONT>

<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=20

<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <FONT SIZE=3D2 =
FACE=3D"Verdana">rtdm_printk(&quot;by_init: habe %i Bystronic-Geraete =
gefunden.\n&quot;,iCount);</FONT>

<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <FONT SIZE=3D2 =
FACE=3D"Verdana">return 0;</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Verdana">}</FONT>
</P>

<P><FONT SIZE=3D2 FACE=3D"Verdana">static void __exit =
by_exit(void)</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Verdana">{</FONT>

<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <FONT SIZE=3D2 =
FACE=3D"Verdana">int iLoop =3D 0;</FONT>

<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=20

<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <FONT SIZE=3D2 =
FACE=3D"Verdana">rtdm_printk(&quot;by_exit called.\n&quot;);</FONT>

<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=20

<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <FONT SIZE=3D2 =
FACE=3D"Verdana">//RTDM-Device abmelden</FONT>

<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <FONT SIZE=3D2 =
FACE=3D"Verdana">rtdm_event_destroy(&amp;event);</FONT>

<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <FONT SIZE=3D2 =
FACE=3D"Verdana">rtdm_dev_unregister(&amp;device,0);</FONT>

<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <FONT SIZE=3D2 =
FACE=3D"Verdana">&nbsp; </FONT>

<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <FONT SIZE=3D2 =
FACE=3D"Verdana">//PCI deaktivieren und Speicher frei geben</FONT>

<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <FONT SIZE=3D2 =
FACE=3D"Verdana">for(iLoop =3D 0;iLoop &lt; =
size_dev_table;++iLoop)</FONT>

<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <FONT SIZE=3D2 =
FACE=3D"Verdana">{</FONT>

<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <FONT SIZE=3D2 =
FACE=3D"Verdana">if(devices[iLoop] &gt; 0)</FONT>

<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <FONT SIZE=3D2 =
FACE=3D"Verdana">{</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Verdana">//&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp; =
pci_release_region(devices[iLoop]-&gt;dev,1);</FONT>

<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <FONT SIZE=3D2 =
FACE=3D"Verdana">&nbsp; =
iounmap(devices[iLoop]-&gt;bar_addresses_begin_kernel[0]);</FONT>

<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <FONT SIZE=3D2 =
FACE=3D"Verdana">&nbsp; =
iounmap(devices[iLoop]-&gt;bar_addresses_begin_kernel[1]);</FONT>

<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <FONT SIZE=3D2 =
FACE=3D"Verdana">&nbsp; =
iounmap(devices[iLoop]-&gt;bar_addresses_begin_kernel[2]);</FONT>

<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <FONT SIZE=3D2 =
FACE=3D"Verdana">pci_disable_device(devices[iLoop]-&gt;dev);</FONT>

<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <FONT SIZE=3D2 =
FACE=3D"Verdana">pci_dev_put(devices[iLoop]-&gt;dev);</FONT>

<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <FONT SIZE=3D2 =
FACE=3D"Verdana">kfree(devices[iLoop]);</FONT>

<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <FONT SIZE=3D2 =
FACE=3D"Verdana">}</FONT>

<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <FONT SIZE=3D2 =
FACE=3D"Verdana">}</FONT>

<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <FONT SIZE=3D2 =
FACE=3D"Verdana">memset(devices,0,sizeof(devices));</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Verdana">}</FONT>
</P>

<P><FONT SIZE=3D2 FACE=3D"Verdana">module_init(by_init);</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Verdana">module_exit(by_exit);&nbsp; </FONT>
</P>

</BODY>
</HTML>
------_=_NextPart_001_01C82DAE.D191F5A9--

