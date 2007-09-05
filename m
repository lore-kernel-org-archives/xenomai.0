From: =?UTF-8?Q?rtos?= <rtos@domain.hid>
Mime-Version: 1.0
Message-ID: <5edd458f.55edb3f.46deba9c.9935a@domain.hid>
Date: Wed, 05 Sep 2007 16:18:04 +0200
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: [Xenomai-help] =?utf-8?q?communication_between_kernel_and_user_sp?=
	=?utf-8?q?ace?=
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

Hello
I=20am=20new=20in=20Xenomai=20and=20I=20can't=20figure=20out=20from=20exa=
mples=20what=20is=20the=20best=20way=20to=20send=20some=20data=20from=20k=
ernel=20space=20rt=5Ftask=20to=20user=20space=20rt=5Ftask.=20I=20have=20c=
reated=20both=20tasks.=20In=20the=20kernel=20space=20task=20I've=20create=
d=20rt=5Fqueue=20and=20I=20would=20like=20bind=20to=20it=20from=20the=20u=
ser=20space=20kernel=20task=20but=20all=20I've=20got=20is=20-EPERM??=20I=20=
cannot=20figure=20out=20why=20it=20happens?
best=20regards
Marcin=20Piatek

user=20space=20code:

#=20include=20<stdio.h>
#=20include=20<stdlib.h>
#=20include=20<unistd.h>
#=20include=20<fcntl.h>
#=20include=20<sys/mman.h>
#=20include=20<sys/io.h>

#=20include=20<native/task.h>
#=20include=20<native/queue.h>

#=20define=20DISP=5FPRIO=20=20=201=20/*=20Highest=20RT=20priority=20*/
#=20define=20DISP=5FMODE=20=20=20T=5FJOINABLE=20=20/*=20No=20flags=20*/
#=20define=20DISP=5FSTKSZ=20=200=20=20/*=20Stack=20size=20(use=20default=20=
one)=20*/

RT=5FQUEUE=20my=5Fqueue;
RT=5FTASK=20my=5Fdisplay;
RT=5FTASK=20my=5Ftask;


void=20my=5Fdisplay=5Ffunc=20(void=20*=20cookie)=20{
=20=20=20=20=20=20=20=20unsigned=20long=20overruns;
=20=20=20=20=20=20=20=20int=20err=3D0,=20hour=5Fcounter,=20second=5Fcount=
er,=20mili=5Fcounter;
=20=20=20=20=20=20=20=20int=20one=20=3D=201;

=20=20=20=20=20=20=20=20int=20real=5Fanswer=3D0;

=20=20=20=20=20=20=20=20err=20=3D=20rt=5Fqueue=5Fbind(&my=5Fqueue,=20"MyQ=
ueue",=20TM=5FINFINITE);
=20=20=20=20=20=20=20=20if=20(err!=3D0)=20{
=20=20=20=20=20=20=20=20=20=20=20=20printf("Couldn't=20bind=20to=20queue:=
=20\n");
=20=20=20=20=20=20=20=20=20=20=20=20if=20(err=20=3D=3D=20-EFAULT)
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20printf("-EFAULT\n");
=20=20=20=20=20=20=20=20=20=20=20=20else=20if=20(err=20=3D=3D=20-EINTR)
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20printf("-EINTR\n");
=20=20=20=20=20=20=20=20=20=20=20=20else=20if=20(err=20=3D=3D=20-EWOULDBL=
OCK)
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20printf("-EWOULDBLOCK\n");=

=20=20=20=20=20=20=20=20=20=20=20=20else=20if=20(err=20=3D=3D=20-ETIMEDOU=
T)
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20printf("-ETIMEDOUT\n");
=20=20=20=20=20=20=20=20=20=20=20=20else=20if=20(err=20=3D=3D=20-EPERM)
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20printf("-EPERM\n");
=20=20=20=20=20=20=20=20=20=20=20=20else=20if=20(err=20=3D=3D=20-ENOENT)
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20printf("-ENOENT\n");
=20=20=20=20=20=20=20=20=20=20=20=20return;
=20=20=20=20=20=20=20=20}
=20=20=20=20=20=20=20=20printf("Binded=20to=20queue\n");

=20=20=20=20=20=20=20=20err=20=3D=20rt=5Ftask=5Fbind(&my=5Ftask,=20"MyTas=
k",=20TM=5FINFINITE);
=20=20=20=20=20=20=20=20if=20(err!=3D0)=20{
=20=20=20=20=20=20=20=20=20=20=20=20printf("Couldn't=20bind=20to=20task:=20=
");
=20=20=20=20=20=20=20=20=20=20=20=20if=20(err=20=3D=3D=20-EFAULT)
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20printf("-EFAULT\n");
=20=20=20=20=20=20=20=20=20=20=20=20else=20if=20(err=20=3D=3D=20-EINTR)
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20printf("-EINTR\n");
=20=20=20=20=20=20=20=20=20=20=20=20else=20if=20(err=20=3D=3D=20-EWOULDBL=
OCK)
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20printf("-EWOULDBLOCK\n");=

=20=20=20=20=20=20=20=20=20=20=20=20else=20if=20(err=20=3D=3D=20-ETIMEDOU=
T)
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20printf("-ETIMEDOUT\n");
=20=20=20=20=20=20=20=20=20=20=20=20else=20if=20(err=20=3D=3D=20-EPERM)
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20printf("-EPERM\n");
=20=20=20=20=20=20=20=20=20=20=20=20return;
=20=20=20=20=20=20=20=20}
=20=20=20=20=20=20=20=20printf("Binded=20to=20task\n");

//=20=20=20=20=20=20=20=20for=20(hour=5Fcounter=3D0;=20hour=5Fcounter<10;=
=20hour=5Fcounter++)=20{
//=09=20=20=20=20=20=20=09for=20(second=5Fcounter=3D0;=20second=5Fcounter=
<3600;=20second=5Fcounter++)=20{
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20f=
or=20(mili=5Fcounter=3D0;=20mili=5Fcounter<1000;=20mili=5Fcounter++)=20{
=09=09=09=09rt=5Fqueue=5Fread(&my=5Fqueue,=20&real=5Fanswer,=20sizeof(int=
),=20TM=5FINFINITE);
=09=09=09=09printf("%d\n",=20real=5Fanswer);
=09=09=09}
//=09=09}
//=09}

=20=20=20=20=20=20=20=20rt=5Ftask=5Funbind(&my=5Ftask);
=20=20=20=20=20=20=20=20rt=5Fqueue=5Funbind(&my=5Fqueue);
}

int=20main=20(int=20argc,=20void=20*argv[])=20{
=09int=20err;

=20=20=20=20=20=20=20=20/*=20Disable=20pageing=20for=20this=20program's=20=
memory.=20*/
=09mlockall(MCL=5FCURRENT=20|=20MCL=5FFUTURE);

=09/*=20Create=20a=20real-time=20task=20*/
=09if=20((err=20=3D=20rt=5Ftask=5Fcreate(&my=5Fdisplay,=20"MyDisplay",=20=
DISP=5FSTKSZ,=20DISP=5FPRIO,=20DISP=5FMODE)))=20{
=09=09printf("Display=20creating=20error.\n");
=09=09exit(1);
=09}

=09/*=20If=20successfully=20created,=20start=20the=20task.=20*/
=09rt=5Ftask=5Fstart(&my=5Fdisplay,=20&my=5Fdisplay=5Ffunc,=20NULL);

=09rt=5Ftask=5Fjoin(&my=5Fdisplay);
=09
=09rt=5Ftask=5Fdelete(&my=5Fdisplay);
}





module=20code:

#include=20<linux/init.h>
#include=20<linux/module.h>
#include=20<linux/fs.h>
#include=20<linux/cdev.h>
#include=20<linux/pci.h>

#include=20<native/task.h>
#include=20<native/timer.h>
#include=20<native/queue.h>

#include=20"baseaddress.h"

#=20define=20TASK=5FPRIO=20=20=2099=20/*=20Highest=20RT=20priority=20*/
#=20define=20TASK=5FMODE=20=20=20T=5FCPU(0)=20=20/*=20No=20flags=20*/
#=20define=20TASK=5FSTKSZ=20=204096=20=20/*=20Stack=20size=20(use=20defau=
lt=20one)=20*/
#=20define=20TASK=5FPERIOD=201000000=20/*=201ms=20period=20*/

MODULE=5FLICENSE("Dual=20BSD/GPL");
MODULE=5FAUTHOR("Marcin=20Piatek");

RT=5FTASK=20my=5Ftask;
RT=5FQUEUE=20my=5Fqueue;

/**
*=09PCI=20device=20structs.
*/
struct=20pci=5Fdev=20*base=5Faddress=5Fpci=5Fdev;
unsigned=20long=20io=5Fbase=5Faddress=20=3D=200;=20=20=20=20=20=20/*=20RT=
DAC4=20IO=20base=20address*/

/**
*=09PCI=20device=20identification=20struct.
*/
static=20struct=20pci=5Fdevice=5Fid=20base=5Faddress=5Fids[]=20=3D=20{
=09{=20PCI=5FDEVICE(PCI=5FVENDOR=5FID=5FINTECO,=20PCI=5FDEVICE=5FID=5FINT=
ECO=5FRTDAC4)=20},
=09{0,=20},
};
MODULE=5FDEVICE=5FTABLE(pci,=20base=5Faddress=5Fids);

/**
*=09PCI=20driver=20struct.
*/
static=20struct=20pci=5Fdriver=20pci=5Fdriver=20=3D=20{
=09.name=20=3D=20"iores",
=09.id=5Ftable=20=3D=20base=5Faddress=5Fids,
=09.probe=20=3D=20base=5Faddress=5Fprobe,
=09.remove=20=3D=20base=5Faddress=5Fremove,
};

/**
*=20=20=20Task=20function
*/

void=20my=5Ftask=5Ffunc=20(void=20*=20cookie)=20{
=09unsigned=20long=20overruns;
=09int=20err,=20hour=5Fcounter,=20second=5Fcounter,=20mili=5Fcounter;

=09unsigned=20int=20value=3D0,=20prev=5Fvalue=3D0,=20msb=3D0,=20lsb=3D0,=20=
answer=3D0;
=09int=20real=5Fanswer=3D0;

=20=20=20=20=20=20=20=20DEBUG=5FMSG("After=20start.\n");

=09if=20((err=20=3D=20rt=5Ftask=5Fset=5Fperiodic(NULL,=20TM=5FNOW,=20TASK=
=5FPERIOD)))=20{
=09=09DEBUG=5FMSG("Timer=20setting=20error.\n");
=09=09return;
=09}

//=09for=20(hour=5Fcounter=3D0;=20hour=5Fcounter<10;=20hour=5Fcounter++)=20=
{
//=09=09for=20(second=5Fcounter=3D0;=20second=5Fcounter<3600;=20second=5F=
counter++)=20{
=09=09=09for=20(mili=5Fcounter=3D0;=20mili=5Fcounter<1000;=20mili=5Fcount=
er++)=20{
=09=09=09=09value=20=3D=20inw(io=5Fbase=5Faddress=20+=20172);
=09=09=09=09msb=20=3D=20inw(io=5Fbase=5Faddress=20+=20176);
=09=09=09=09lsb=20=3D=20inw(io=5Fbase=5Faddress=20+=20180);
=09=09=09=09value=20=3D=20msb=20*=200x10000=20+=20lsb;

=09=09=09=09if=20(value=20>=20prev=5Fvalue)
=09=09=09=09=09answer=20=3D=20(value=20-=20prev=5Fvalue)=20*=2025;
=09=09=09=09else
=09=09=09=09=09answer=20=3D=20((0xFFFFFFFF=20-=20prev=5Fvalue)=20+=20valu=
e=20+=201)=20*=2025;
=09=09=09=09real=5Fanswer=20=3D=20answer=20-=201000000;
=09=09=09=09prev=5Fvalue=20=3D=20value;

=09=09=09=09rt=5Fqueue=5Fwrite(&my=5Fqueue,=20&real=5Fanswer,=20sizeof(in=
t),=20Q=5FNORMAL);
//=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20DEBUG=5FMSG("answer=20=3D=20%d\n",=20real=5Fanswe=
r);
=09=09=09=09rt=5Ftask=5Fwait=5Fperiod(&overruns);
=09=09=09}
//=09=09}
//=09}
}


/**
*=09Initialization=20function.
*=09It=20register=20char=20devices.
*/
static=20int=20base=5Faddress=5Finit(void)=20{
=20=20=20=20int=20err;

=20=20=20=20if=20((err=20=3D=20pci=5Fregister=5Fdriver(&pci=5Fdriver)))
=20=20=20=20=20=20=20=20return=20err;

=20=20=20=20if=20((err=20=3D=20rt=5Fqueue=5Fcreate(&my=5Fqueue,=20"MyQueu=
e",=20sizeof(int)*1000,=201000,=20Q=5FFIFO)))=20{
=20=20=20=20=20=20=20=20DEBUG=5FMSG("Pipe=20cannot=20be=20created.\n");
=20=20=20=20}

=20=20=20=20err=20=3D=20rt=5Ftask=5Fcreate(&my=5Ftask,=20"MyTask",=20TASK=
=5FSTKSZ,=20TASK=5FPRIO,=20TASK=5FMODE);
=20=20=20=20if=20(!err)
=20=20=20=20=20=20=20=20rt=5Ftask=5Fstart(&my=5Ftask,=20&my=5Ftask=5Ffunc=
,=20NULL);

=20=20=20=20return=200;

}

/**
*=09Deinitialization=20function.
*=09Unregister=20char=20devices.
*/
static=20void=20=5F=5Fexit=20base=5Faddress=5Fexit(void)=20{

=20=20=20=20rt=5Ftask=5Fdelete(&my=5Ftask);
=20=20=20=20rt=5Fqueue=5Fdelete(&my=5Fqueue);

=20=20=20=20pci=5Funregister=5Fdriver(&pci=5Fdriver);
}


/**
*=09PCI=20device=20function=20invoked=20when=20probing=20device.
*/
int=20base=5Faddress=5Fprobe(struct=20pci=5Fdev=20*dev,=20const=20struct=20=
pci=5Fdevice=5Fid=20*id)=20{

=20=20=20=20u16=20vendor=5Fid,=20device=5Fid;
=20=20=20=20pci=5Fenable=5Fdevice(dev);
=20=20=20=20pci=5Fread=5Fconfig=5Fword(dev,=200,=20&vendor=5Fid);
=20=20=20=20DEBUG=5FMSG("vendor=20id:=20%x\n",=20vendor=5Fid);
=20=20=20=20pci=5Fread=5Fconfig=5Fword(dev,=202,=20&device=5Fid);
=20=20=20=20DEBUG=5FMSG("device=20id:=20%x\n",=20device=5Fid);

=20=20=20=20if=20(vendor=5Fid=20=3D=3D=20PCI=5FVENDOR=5FID=5FINTECO=20&&=20=
device=5Fid=20=3D=3D=20PCI=5FDEVICE=5FID=5FINTECO=5FRTDAC4)=20{
=20=20=20=20=20=20=20=20base=5Faddress=5Fpci=5Fdev=20=3D=20dev;
=20=20=20=20=20=20=20=20io=5Fbase=5Faddress=20=3D=20pci=5Fresource=5Fstar=
t(base=5Faddress=5Fpci=5Fdev,=202);
=20=20=20=20=20=20=20=20DEBUG=5FMSG("PCI=20resource=20address:=20%lx\n",=20=
io=5Fbase=5Faddress);
=20=20=20=20=20=20=20=20return=200;
=20=20=20=20}
=20=20=20=20else
=20=20=20=20=20=20=20=20return=20-1;
}

/**
*=09PCI=20device=20function=20invoked=20when=20removing=20device.
*/
void=20base=5Faddress=5Fremove(struct=20pci=5Fdev=20*dev)=20{
}

/**
*=09Register=20module=20functions.
*/
module=5Finit(base=5Faddress=5Finit);
module=5Fexit(base=5Faddress=5Fexit);



