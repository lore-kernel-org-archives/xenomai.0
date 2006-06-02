Message-ID: <4480595D.7040203@domain.hid>
Date: Fri, 02 Jun 2006 17:29:33 +0200
From: Lionel Perrin <perrin@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Subject: [Xenomai-help] shm_open, ftruncate
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

Hi,

I got some problems with shared memory.
I started from the shm_open example from opengroup.org.
When I compile it as non real time tasks, it works properly. But since I 
tried to compile it with
gcc $(xeno-config --posix-cflags) shm_open.c $(xeno-config 
--posix-ldflags) -o xeno_shm_open,
i get an EINVAL error from ftruncate that i can fix.

Does shm under xenomai require particular things ?

Thanks for your help...

Lionel

#include <unistd.h>
#include <sys/mman.h>
...


#define MAX_LEN 10000
struct region {        /* Defines "structure" of shared memory */
    int len;
    char buf[MAX_LEN];
};
struct region *rptr;
int fd;


/* Create shared memory object and set its size */


fd = shm_open("/myregion", O_CREAT | O_RDWR, S_IRUSR | S_IWUSR);
if (fd == -1)
    /* Handle error */;


if (ftruncate(fd, sizeof(struct region)) == -1)
    /* Handle error */;


/* Map shared memory object */


rptr = mmap(NULL, sizeof(struct region),
       PROT_READ | PROT_WRITE, MAP_SHARED, fd, 0);
if (rptr == MAP_FAILED)
    /* Handle error */;


/* Now we can refer to mapped region using fields of rptr;
   for example, rptr->len */



