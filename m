From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="uJktI+ciP0"
Content-Transfer-Encoding: 7bit
Message-ID: <17536.29324.723709.385494@domain.hid>
Date: Fri, 2 Jun 2006 19:17:00 +0200
Subject: Re: [Xenomai-help] shm_open, ftruncate
In-Reply-To: <4480595D.7040203@domain.hid>
References: <4480595D.7040203@domain.hid>
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Lionel Perrin <perrin@domain.hid>
Cc: xenomai@xenomai.org


--uJktI+ciP0
Content-Type: text/plain; charset=us-ascii
Content-Description: message body and .signature
Content-Transfer-Encoding: 7bit

Lionel Perrin wrote:
 > Hi,
 > 
 > I got some problems with shared memory.
 > I started from the shm_open example from opengroup.org.
 > When I compile it as non real time tasks, it works properly. But since I 
 > tried to compile it with
 > gcc $(xeno-config --posix-cflags) shm_open.c $(xeno-config 
 > --posix-ldflags) -o xeno_shm_open,
 > i get an EINVAL error from ftruncate that i can fix.
 > 
 > Does shm under xenomai require particular things ?

When applying the attached patch to xenomai (do not forget to rebuild
the kernel), the attached program compiled with the attached Makefile
works here.

-- 


					    Gilles Chanteperdrix.

--uJktI+ciP0
Content-Type: text/plain
Content-Disposition: inline;
	filename="xeno-posix-shm.diff"
Content-Transfer-Encoding: 7bit

Index: ksrc/skins/posix/shm.c
===================================================================
--- ksrc/skins/posix/shm.c	(revision 1143)
+++ ksrc/skins/posix/shm.c	(working copy)
@@ -516,10 +516,8 @@
        is aligned). */
     if (len)
         {
-        len += PAGE_SIZE + xnheap_overhead(len, PAGE_SIZE);
+        len += PAGE_SIZE + PAGE_ALIGN(xnheap_overhead(len, PAGE_SIZE));
         len = PAGE_ALIGN(len);
-        if (len == 2 * PAGE_SIZE)
-            len = 3 * PAGE_SIZE;
         }
 
     err = 0;

--uJktI+ciP0
Content-Type: text/plain
Content-Disposition: inline;
	filename="test_shm.c"
Content-Transfer-Encoding: 7bit

#include <stdlib.h>
#include <stdio.h>
#include <errno.h>

#include <fcntl.h>
#include <unistd.h>
#include <sys/mman.h>

#define MAX_LEN 10000
struct region {        /* Defines "structure" of shared memory */
    int len;
    char buf[MAX_LEN];
};
struct region *rptr;
int fd;



int main(int argc, const char *argv[])
{
    int fd, status;

    mlockall(MCL_CURRENT|MCL_FUTURE);

/* Create shared memory object and set its size */

    fd = shm_open("/myregion", O_CREAT | O_RDWR, S_IRUSR | S_IWUSR);
    if (fd == -1) {
        perror("shm_open");
        exit(EXIT_FAILURE);
    }
    
    if ((status = ftruncate(fd, sizeof(struct region))) == -1) {
        /* Handle error */;
        perror("ftruncate");
        close(fd);
        status = EXIT_FAILURE;
        goto close_and_unlink;
    }


/* Map shared memory object */
    rptr = (struct region *) mmap(NULL,
                                  sizeof(struct region),
                                  PROT_READ | PROT_WRITE,
                                  MAP_SHARED,
                                  fd,
                                  0);
    if (rptr == MAP_FAILED) {
        /* Handle error */;
        perror("mmap");
        status = EXIT_FAILURE;
        goto close_and_unlink;
    }
    
/* Now we can refer to mapped region using fields of rptr;
   for example, rptr->len */

    munmap(rptr, sizeof(struct region));
  close_and_unlink:
    close(fd);
    shm_unlink("/myregion");

    return status;
}

--uJktI+ciP0
Content-Type: text/plain
Content-Disposition: inline;
	filename="Makefile"
Content-Transfer-Encoding: 7bit

DESTDIR=/home/gilles/files/perso/dev/build/nestor/inst
XENO_CONFIG=$(DESTDIR)/usr/xenomai/bin/xeno-config

CFLAGS:=$(shell DESTDIR=$(DESTDIR) $(XENO_CONFIG) --posix-cflags) -g -O2 -Wall -W -Werror-implicit-function-declaration
LDFLAGS:=$(shell DESTDIR=$(DESTDIR) $(XENO_CONFIG) --posix-ldflags)
LOADLIBES=-lpthread_rt

all: test_shm

test_shm: test_shm.o

clean:
	$(RM) foo foo.o test_shm.o test_shm

--uJktI+ciP0--

