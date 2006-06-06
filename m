Message-ID: <44856CA7.30802@domain.hid>
Date: Tue, 06 Jun 2006 13:53:11 +0200
From: Lionel Perrin <perrin@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-help] shm_open, ftruncate
References: <4480595D.7040203@domain.hid>	<17536.29324.723709.385494@domain.hid>	<4484365A.7090007@domain.hid>
	<17540.21517.871383.751462@domain.hid>
In-Reply-To: <17540.21517.871383.751462@domain.hid>
Content-Type: multipart/mixed; boundary="------------060502090501020602070300"
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
Cc: xenomai@xenomai.org

This is a multi-part message in MIME format.
--------------060502090501020602070300
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit


>  > - Will this shared memory be accessible to non rt-task ?
>  > - What's the simplest way to share information with a non rt-task ?
>
> Shared memory are also accessible to non-rt tasks. Since user-space
> realtime and non-realtime threads from the same process reside in the
> same address space, the simplest way to share information from rt to
> non-rt tasks is to create them as threads of the same process.
>   
Ok, but I figure out that it's possible to share memory between 
processes ? (rt and non rt?)
For the moment, i focus on sharing between two rt tasks, but in vain :(
I still have a ftruncate error (EBADF) when i launch two rt processes...
I explain :
I've tried the attached program. I've added a sleep(1) between mmap and 
munmap. I launch this appli twice with
 >> shm_test &
 >> shm_test &
For the second one, I got "ftruncate: Invalid argument". Am I the only 
one to have this problem ?




--------------060502090501020602070300
Content-Type: text/plain;
 name="test_shm.c"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="test_shm.c"

#include <stdlib.h>
#include <stdio.h>
#include <errno.h>
#include <unistd.h>
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
	sleep(1);


    munmap(rptr, sizeof(struct region));
  close_and_unlink:
    close(fd);
    shm_unlink("/myregion");

    return status;
}

--------------060502090501020602070300--

