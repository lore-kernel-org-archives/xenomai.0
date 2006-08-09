Message-ID: <58356.127.0.0.1.1155128979.squirrel@domain.hid>
Date: Wed, 9 Aug 2006 13:09:39 -0000 (UTC)
From: "Jacques GANGLOFF" <jacques@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain;charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable
Subject: [Xenomai-core] -EINTR using rt_pipe_read with TM_INFINITE
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: xenomai@xenomai.org

Hi,

I did this little test :

Below I have attached two sources, one on the kernel side and one on the
user side.
I do here a very simple fifo handshaking test. I insert the kernel module
then I run the user program. When I do the test with the "THE BUG IS HERE=
"
line commented, I got :

root@domain.hid# ./user
user : j'ai envoy=E9 A
user :j'ai bien re=E7u E
root@domain.hid# dmesg
hello world
kernel : j'ai bien re=E7u A
kernel : ret =3D 1
kernel :j'ai envoy=E9 E

Now, when I uncomment the line :
root@domain.hid# ./user
user : j'ai envoy=E9 A
[CRTL-C] because the user program is blocking ...
root@domain.hid# dmesg
hello world
kernel : j'ai bien re=E7u A
kernel : ret =3D -4
kernel :j'ai envoy=E9 E


Now, ret=3D-4 is the code for -EINTR. According to the doc :
"-EINTR is returned if rt_task_unblock() has been called for the waiting
task before any data was available."

I cannot see where rt_task_unblock() could be called. What is wrong ?

Thanks for your help,
Jacques

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
Kernel module :
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

#include <native/task.h>
#include <native/pipe.h>
#include <rtdm/rtdm_driver.h>

#define TASK_PRIO 99
#define TASK_MODE T_FPU|T_CPU(0)
#define TASK_STKSZ 4096

RT_PIPE pipe1,pipe2;
RT_TASK task_desc;

void task_body (void *cookie)
{
	char buf,mesg;
	int err;

    mesg =3D 'E';
	/*lecture dans le pipe (TM_INFINITE : bloque la t=E2che s'il y a rien da=
ns
	 * le pipe)*/
	err =3D rt_pipe_read(&pipe1,&buf,sizeof(char),TM_INFINITE);


	rtdm_printk("kernel : j'ai bien re=E7u %c \n",buf);

        /* THE BUG IS HERE */
	err =3D rt_pipe_read(&pipe1,&buf,sizeof(char),TM_INFINITE);
        /* THE BUG IS HERE */

	rtdm_printk("kernel : ret =3D %d\n", err );

	/*=E9criture dans le pipe*/
	err =3D rt_pipe_write(&pipe2,&mesg,sizeof(char),P_NORMAL);

	rtdm_printk("kernel :j'ai envoy=E9 %c \n",mesg);


}


int init_module(void)
{

	int err=3D0;


	printk("hello world\n");

	/*Cr=E9ation d'un pipe pour lecture*/
	err =3D rt_pipe_create(&pipe1,"MyPipe0",0,sizeof(char));
	if(err)
	{
		rtdm_printk("pipe MyPipe0 creation failure \n");
	}

	/*Cr=E9ation d'un pipe pour =E9criture*/
	err =3D rt_pipe_create(&pipe2,"MyPipe1",1,sizeof(char));
	if(err)
	{
		rtdm_printk("pipe MyPipe1 creation failure \n");
	}

	/*Cr=E9ation de la t=E2che*/
	err =3D
rt_task_create(&task_desc,"MyTaskName",TASK_STKSZ,TASK_PRIO,TASK_MODE);

	if (!err)
	{
		/*lancement de la t=E2che*/
		rt_task_start(&task_desc,&task_body,NULL);
	}

	return 0;

}


void cleanup_module(void)

{
	rt_task_delete(&task_desc);
	rt_pipe_delete(&pipe1);
	rt_pipe_delete(&pipe2);
}

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D

User program :

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D

#include <native/task.h>
#include <native/pipe.h>
#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <fcntl.h>



int main()
{
	int pipe1,pipe2;
	char m2,m1=3D'A';

	m2 =3D 0;

	/*Ouverture du device c=F4t=E9 user pour =E9criture */
	pipe1 =3D open("/dev/rtp0",O_RDWR);

	/*Ouverture du device c=F4t=E9 user pour lecture*/
	pipe2 =3D open("/dev/rtp1",O_RDONLY);

	/*=E9criture des donn=E9es*/
	write(pipe1,&m1,sizeof(char));

	printf("user : j'ai envoy=E9 %c \n",m1);

	/* lecture des donn=E9es */
	read(pipe2,&m2,sizeof(char));

	printf("user :j'ai bien re=E7u %c \n",m2);


	close(pipe1);
	close(pipe2);
	return 0;
}
 ___________________________________________

   Prof. Jacques GANGLOFF

   Strasbourg I University
   LSIIT Laboratory, EAVR team
   Bd S. Brant
   BP 10413, 67412 ILLKIRCH cedex, FRANCE
   Tel : +33 (0)3 90 24 44 68
   Fax : +33 (0)3 90 24 44 80
   http://eavr.u-strasbg.fr
____________________________________________


