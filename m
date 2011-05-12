MIME-Version: 1.0
In-Reply-To: <4DCB82B0.1090901@domain.hid>
References: <BANLkTi=Pa6FNiSWfp6PF-39mtAU8GgJcQQ@mail.gmail.com>
	<4DCB82B0.1090901@domain.hid>
Date: Thu, 12 May 2011 16:41:53 +0800
Message-ID: <BANLkTik1Ho+FAokaDjswwcAK5i9seUrYTA@mail.gmail.com>
From: arethe rtai <arethe.rtai@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Xenomai-core] why does not the share memory work well ?
List-Id: Xenomai life and development <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: xenomai@xenomai.org

The errno of mmap that is called in function __map_shm_heap_memory()
is 22, namely, EINVAL.
Is there someone successfully run the shared memory under rtai skins.

2011/5/12 Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>:
> On 05/12/2011 06:15 AM, arethe rtai wrote:
>> Hi all:
>> =A0 =A0 I wirte a share memory program, but I found the share momory doe=
s
>> not work while I try to take a communication between user space and
>> kernel space.
>> =A0 =A0 The task in kernel is OK, we can get the shared space. But the
>> task in user space can not get the share memory.
>> =A0 =A0 The code of the task in user space as follows:
>
> What happens when the user-space tries to get the shared space?
>
>>
>> =A0#include <stdio.h>
>> #include <unistd.h>
>> #include <sys/types.h>
>> #include <sys/mman.h>
>> #include <sys/stat.h>
>> #include <fcntl.h>
>> #include <rtai/rtai.h>
>> #include <rtai/rtai_shm.h>
>>
>>
>> int main(void)
>> {
>> =A0 =A0 =A0 unsigned int *adr;
>>
>> =A0 =A0 =A0 adr=3D(unsigned int *)rt_shm_alloc(0xaaaaa, sizeof(*adr), US=
E_VMALLOC);
>>
>> =A0 =A0 =A0 if (adr=3D=3DNULL)
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 printf("NULL pointer find \n");
>>
>> =A0 =A0 =A0 //rt_shm_free(0xaaaaa);
>>
>> =A0 =A0 =A0 printf("%d =A0 =A0line =A0 \n",__LINE__);
>>
>> =A0 =A0 =A0 fflush(stdout);
>>
>> =A0 =A0 =A0 return 0;
>>
>> }
>>
>> BTW: I added some printf in file src/skins/rtai/shm.c, but they cannot
>> be outputted to the console.
>
> I doubt that very much. If printf did not work, a lot of application
> would not work on your system.
>
> --
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0Gilles.
>

