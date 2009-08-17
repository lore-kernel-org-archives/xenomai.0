From: Henry Bausley <hbausley@domain.hid>
In-Reply-To: <4A8808BA.4080504@domain.hid>
References: <1250186541.23699.8.camel@domain.hid>
	<4A845C93.4060302@domain.hid> <1250200537.28789.8.camel@domain.hid>
	<4A8808BA.4080504@domain.hid>
Content-Type: text/plain
Date: Mon, 17 Aug 2009 14:17:53 -0700
Message-Id: <1250543873.14029.5.camel@domain.hid>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] pthread_setschedparam: Resource
	temporarily	unavailable
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: Xenomai help <xenomai@xenomai.org>

I used the defaults that came up for my 2.6.28.8 kernel I-pipe 2.4-05.
I'll rebuild the kernel with 2.6


root@domain.hid# dmesg | grep pipe ; dmesg | grep 2.4.8 ;
uname -a ; /opt/ppmac/tune/test ;
cat /proc/xenomai/heap ; /opt/ppmac/tune/test ; cat /proc/xenomai/heap
I-pipe 2.4-05: pipeline enabled.
I-pipe: Domain Xenomai registered.
Xenomai: real-time nucleus v2.4.8 (Lords Of Karma) loaded.
Linux powerpmac 2.6.28.8 #1 Mon Aug 17 11:51:01 PDT 2009 ppc GNU/Linux
size=4161536:used=23120:pagesz=512  (main heap)
size=32256:used=0:pagesz=512  (stack pool)
size=4161536:used=23152:pagesz=512  (main heap)
size=32256:used=0:pagesz=512  (stack pool)
root@domain.hid# 

scripts/prepare-kernel.sh --linux=../linux-2.6.28.8/ --arch=powerpc





On Sun, 2009-08-16 at 15:25 +0200, Gilles Chanteperdrix wrote:
> wrote:
> > Yes I can reproduce this on  xenomai 2.4.8.  Every time I call the
> > functions below I lose 32 bytes.
> > In my real application I actually have 6 different shared memory
> > segments so I lose 192 bytes every time
> > the app runs. 
> 
> There is no such leak on my test platforms, and it reminds me of a
> problem with automatic process cleanup which was fixed in the powerpc
> I-pipe patch some time ago. So, are you sure you are indeed running the
> latest I-pipe patch for powerpc which comes with xenomai 2.4.8?
> 
> My test program is the following:
> 
> #include <stdio.h>
> #include <stdlib.h>
> 
> #include <unistd.h>
> #include <sys/mman.h>
> #include <sys/fcntl.h>
> 
> #define SHM_NAME "/foo"
> #define SIZE 128 * 1024
> 
> int main(void)
> {
> 	int shmfd = shm_open(SHM_NAME, O_CREAT | O_RDWR, 0777);
> 	void *pshm;
> 	int rc;
> 
> 	if (shmfd == -1) {
> 		perror("shm_open");
> 		exit(EXIT_FAILURE);
> 	}
> 
> 	rc = ftruncate(shmfd, SIZE);
> 	if (rc == 1) {
> 		perror("ftruncate");
> 		exit(EXIT_FAILURE);
> 	}
> 
> 	pshm = mmap(NULL, SIZE,
> 		    PROT_READ | PROT_WRITE, MAP_SHARED, shmfd, 0);
> 	if (pshm == MAP_FAILED) {
> 		perror("mmap");
> 		exit(EXIT_FAILURE);
> 	}
> 		
> 	rc = munmap(pshm, SIZE);
> 	if (rc == -1) {
> 		perror("munmap");
> 		exit(EXIT_FAILURE);
> 	}
> 		
> 	rc = close(shmfd);
> 	if (rc == -1) {
> 		perror("close");
> 		exit(EXIT_FAILURE);
> 	}
> 		
> 	rc = shm_unlink(SHM_NAME);
> 	if (rc == -1) {
> 		perror("shm_unlink");
> 		exit(EXIT_FAILURE);
> 	}
> }
> 



**********************************************************
Outbound scan for Spam or Virus by Barracuda at Delta Tau
**********************************************************

