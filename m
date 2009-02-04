Date: Wed, 4 Feb 2009 15:15:42 +0100
From: Tom Schouten <tom@domain.hid>
Message-ID: <20090204141542.GA9557@domain.hid>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="LZvS9be/3tNcYl/X"
Content-Disposition: inline
Subject: [Xenomai-help] posix shm problem
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


--LZvS9be/3tNcYl/X
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hello,

I've been getting strange behaviour with posix shared memory.  I tried both 
svn revision 4169 and release 2.4.6.1 together with a linux-2.6.25.17 kernel 
and the default adeos patch for both xenomai versions.

I'm building the attached test program with:

cc -g -Wall `xml2-config --cflags` `xeno-config --xeno-cflags \
	--posix-cflags`    -o shm_test.o -c shm_test.c \
cc shm_test.o -o shm_test.app `xml2-config --libs` `xeno-config  
	--xeno-ldflags --posix-ldflags`  -lnative -lrt -lrtdm 

Basicly, some writes don't seem to come true.
(it should be all the same values: notice the zeros at the end.)

Any ideas what this is?


# ./shm_test.app 0x16 && hd 
/tmp/shm-test
logging shm to /tmp/shm-test
filling with 16
00000000  15 15 15 15 15 15 15 15  15 15 15 15 15 15 15 15  
|................|
*
00007040  00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00  
|................|
*
00008000


# ./shm_test.app 0x17 && hd 
/tmp/shm-test
logging shm to /tmp/shm-test
filling with 17
00000000  16 16 16 16 16 16 16 16  16 16 16 16 16 16 16 16  
|................|
*
00007040  00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00  
|................|
*
00008000

--LZvS9be/3tNcYl/X
Content-Type: text/x-csrc; charset=us-ascii
Content-Disposition: attachment; filename="shm_test.c"

#include <stdlib.h>
#include <stdio.h>

#include <sys/types.h>
#include <sys/mman.h>
#include <fcntl.h>           /* For O_* constants */

#include <string.h>
#include <errno.h>

#include <unistd.h>

#define SHM_NAME "shm-test"

int main(int argc, char **argv) {
    unsigned char *image;
    unsigned char *image_endx;
    int image_fd;
    int bytes = 32 * 1024;
    if (-1 == (image_fd = shm_open(SHM_NAME,
                                   O_CREAT
                                   | O_RDWR 
                                   /* | O_EXCL */
                                   , 0))) {
        fprintf(stderr, "can't create shared memory: %s.\n",
                strerror(errno));
        return -errno;
    }

    if ((-1 == ftruncate(image_fd, bytes))) {
        fprintf(stderr, "ftruncate(): %s\n", strerror(errno));
        return -errno;
    }

    if (-1 == (int)(image =
                    mmap(NULL, bytes, PROT_READ | PROT_WRITE, 
                         MAP_SHARED, image_fd, 0))) {
        fprintf(stderr, "can't mmap shared memory: %s.\n",
                strerror(errno));
        return -1;
    }

    // OK
    image_endx = image + bytes;


    // fprintf(stderr, "got shared memory at %p\n", image);

    // dump image.
    if (1) {
        char filename[100];
        // sprintf(filename, "/tmp/" SHM_NAME ".%d.bin", getpid());
        sprintf(filename, "/tmp/" SHM_NAME);
        fprintf(stderr, "logging shm to %s\n", filename);
        FILE *f = fopen(filename, "w");
        fwrite(image, 1, bytes, f);
        fclose(f);

        double fill;
        if (argc < 2) { exit(1); };
        if (1 != sscanf(argv[1], "%lf", &fill)) exit (1);

        int ifill = fill;
        fprintf(stderr, "filling with %02x\n", ifill);
        int i;
        for(i=0; i<bytes; i++) {
            image[i] = ifill & 0xFF;
        }
        
    }
    return 0;
}

--LZvS9be/3tNcYl/X--

