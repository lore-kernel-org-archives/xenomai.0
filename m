MIME-Version: 1.0
Date: Thu, 12 May 2011 12:15:35 +0800
Message-ID: <BANLkTi=Pa6FNiSWfp6PF-39mtAU8GgJcQQ@mail.gmail.com>
From: arethe rtai <arethe.rtai@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Subject: [Xenomai-core] why does not the share memory work well ?
List-Id: Xenomai life and development <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Xenomai-core@domain.hid

Hi all:
    I wirte a share memory program, but I found the share momory does
not work while I try to take a communication between user space and
kernel space.
    The task in kernel is OK, we can get the shared space. But the
task in user space can not get the share memory.
    The code of the task in user space as follows:

 #include <stdio.h>
#include <unistd.h>
#include <sys/types.h>
#include <sys/mman.h>
#include <sys/stat.h>
#include <fcntl.h>
#include <rtai/rtai.h>
#include <rtai/rtai_shm.h>


int main(void)
{
	unsigned int *adr;

	adr=(unsigned int *)rt_shm_alloc(0xaaaaa, sizeof(*adr), USE_VMALLOC);

	if (adr==NULL)
		printf("NULL pointer find \n");

	//rt_shm_free(0xaaaaa);

	printf("%d    line   \n",__LINE__);

	fflush(stdout);

	return 0;
	
}

BTW: I added some printf in file src/skins/rtai/shm.c, but they cannot
be outputted to the console.

Regards Arethe

