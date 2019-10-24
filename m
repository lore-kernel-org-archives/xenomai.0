Message-ID: <86e02eb5015e1b4754b8dbe367e62497.squirrel@mail.ige-grenoble.fr>
Date: Thu, 24 Oct 2019 10:41:14 +0200
Subject: problem with sessions in xenomai 3.1
From: davy.regneau@univ-grenoble-alpes.fr
Reply-To: davy.regneau@univ-grenoble-alpes.fr
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

Hi,

Shared sessions do not seem to work with Xenomai 3.1.
I made this simple code to test it :


RT_TASK task;

void foo(){
	while(1){
		printf("Hello !\n");
		rt_task_sleep(2000000000);
	}
}

int main(int argc, char *argv[]){
	int n;
  	if (mlockall( MCL_CURRENT | MCL_FUTURE )!=3D0)
    		return 1;
	if ((n=3Drt_task_spawn( &task, NULL, 0, 99, T_JOINABLE, &foo, NULL))!=3D0){
    		rt_printf("rt_task_spawn error %d\n",n);
    		return 1;
  	}
  	rt_task_join(&task);
}


When I try to start 2 instance of this program with the same session
label, the second give me a segmentaion fault:
$ sudo ./foo --session=3Ds
Erreur de segmentation

And this error appears in the kernel logs:
foo[11885]: segfault at 3387c25020 ip 00007fee025a73f9 sp 00007ffe2611cbd8
error 4 in libcopperplate.so.0.0.0[7fee0259c000+11000]
Code: 00 48 89 f8 48 03 47 18 74 51 4c 8b 4e 20 eb 17 90 44 89 c6 49 89 fa
83 c6 01 4c 03 54 f0 08 4c 89 d6 74 33 48 89 f0 4c 89 ce <48> 2b 70 20 45
31 c0 48 85 f6 41 0f 9f c0 48 c1 ee 3f 41 29 f0 75


I tested it with the kernel 4.19.66 patched with xenomai 3.1-rc1 and the
kernel 4.19.75 with the next branch and observed the same issue.

I also tried kernel 4.14.134 with xenomai 3.0.9 and it works. So I will
stay in this version for the moment.


My build :
$ /usr/xenomai/bin/xeno-config --info
Xenomai version: Xenomai/cobalt v3.1-rc2
Linux XportNew 4.19.75-xenomai-3.1 #2 SMP PREEMPT Wed Oct 23 14:34:21 CEST
2019 x86_64 GNU/Linux
Kernel parameters: BOOT_IMAGE=3D/boot/vmlinuz-4.19.75-xenomai-3.1
root=3D/dev/mapper/isw_bdaaiafbje_Volume11 ro dmraid=3Dtrue quiet splash no=
pat
crashkernel=3D384M-:128M
I-pipe release #7 detected
Cobalt core 3.1-rc2 detected
Compiler: gcc version 4.9.2 (Debian 4.9.2-10+deb8u1)
Build args: --with-core=3Dcobalt --enable-smp --enable-pshared


regards,
Davy


-------------- next part --------------
A non-text attachment was scrubbed...
Name: config-4.19.75-xenomai-3.1
Type: application/octet-stream
Size: 201615 bytes
Desc: not available
URL: <http://xenomai.org/pipermail/xenomai/attachments/20191024/269f9137/at=
tachment.obj>
