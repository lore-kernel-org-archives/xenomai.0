Message-ID: <4DCB82B0.1090901@domain.hid>
Date: Thu, 12 May 2011 08:48:16 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <BANLkTi=Pa6FNiSWfp6PF-39mtAU8GgJcQQ@mail.gmail.com>
In-Reply-To: <BANLkTi=Pa6FNiSWfp6PF-39mtAU8GgJcQQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-core] why does not the share memory work well ?
List-Id: Xenomai life and development <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: arethe rtai <arethe.rtai@domain.hid>
Cc: Xenomai-core@domain.hid

On 05/12/2011 06:15 AM, arethe rtai wrote:
> Hi all:
>     I wirte a share memory program, but I found the share momory does
> not work while I try to take a communication between user space and
> kernel space.
>     The task in kernel is OK, we can get the shared space. But the
> task in user space can not get the share memory.
>     The code of the task in user space as follows:

What happens when the user-space tries to get the shared space?

> 
>  #include <stdio.h>
> #include <unistd.h>
> #include <sys/types.h>
> #include <sys/mman.h>
> #include <sys/stat.h>
> #include <fcntl.h>
> #include <rtai/rtai.h>
> #include <rtai/rtai_shm.h>
> 
> 
> int main(void)
> {
> 	unsigned int *adr;
> 
> 	adr=(unsigned int *)rt_shm_alloc(0xaaaaa, sizeof(*adr), USE_VMALLOC);
> 
> 	if (adr==NULL)
> 		printf("NULL pointer find \n");
> 
> 	//rt_shm_free(0xaaaaa);
> 
> 	printf("%d    line   \n",__LINE__);
> 
> 	fflush(stdout);
> 
> 	return 0;
> 	
> }
> 
> BTW: I added some printf in file src/skins/rtai/shm.c, but they cannot
> be outputted to the console.

I doubt that very much. If printf did not work, a lot of application
would not work on your system.

-- 
                                                                Gilles.

