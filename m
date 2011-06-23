From: Philippe Gerum <rpm@xenomai.org>
In-Reply-To: <4E02B485.8040803@domain.hid>
References: <BANLkTi=qe3CqD9U_T3nF6xBN+nZNbxF7Gg@domain.hid>
	<4E00A476.2080006@domain.hid>	<4E01977E.1080202@domain.hid>
	<4E01AB2C.4070409@domain.hid>	<1308733051.2159.12.camel@domain.hid>
	<4E02162A.9060004@domain.hid>	<1308760138.2159.92.camel@domain.hid>
	<4E022C64.3040805@domain.hid>	<4E022DB9.5020508@domain.hid>
	<4E023966.1080603@domain.hid>  <4E02B485.8040803@domain.hid>
Content-Type: text/plain; charset="UTF-8"
Date: Thu, 23 Jun 2011 08:57:11 +0200
Message-ID: <1308812231.2132.13.camel@domain.hid>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] rt_dev_ioctl
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: David Wiebe <dwiebe2@domain.hid>
Cc: xenomai@xenomai.org

On Wed, 2011-06-22 at 20:35 -0700, David Wiebe wrote:
> Hello,
> 
> The program included in this email compiles and runs on my beagleboard 
> xm. The compiler gives no warnings or anything.
> 
> Once I prepend an ioctl call with rt_dev_, I get the following
> 
> david@domain.hid$ 
> arm-none-linux-gnueabi-gcc -o xenomai-spi-eth-00002 $CFLAGS 
> xenomai-spi-eth-00002.c $LDFLAGS -I 
> /home/david/122720101858-beagleboard-working-set/kernel/linux/include/
> /tmp/cc9aLEWN.o: In function `main':
> xenomai-spi-eth-00002.c:(.text+0x334): undefined reference to `rt_dev_ioctl'
> collect2: ld returned 1 exit status
> 
> I'm perplexed because as I understand it including rtdm/rtdm.h should 
> allow the function rt_dev_ioctl to be used.
> 
> In a previous email I received, it was suggested I change the skin to 
> rtdm. I set both skin to rtdm. This gave me a different set of errors 
> referencing rt_task_set_periodic and the like.

The proper way to build a (simple) native API based foo.c application
using the ancillary RTDM library would be this one:

CFLAGS = $(shell xeno-config --skin=native --cflags)
LDFLAGS = $(shell xeno-config --skin=native --ldflags)
CC = $(shell xeno-config --cc)

all: foo

%: %.c
	$(CC) $(CFLAGS) -o $@ $< $(LDFLAGS) -lnative -lrtdm

With the POSIX API, you would have specified --skin=posix.

RTDK is not RTDM-related, it is a set of helper routines to use in
real-time context. It currently provides rt-compatible printf(3) like
services. You get these with the additional -lrtdk spec.

> 
> 
> Thanks for reading this,
> 
> Sincerely,
> 
> David
> 
> CFLAGS=`DESTDIR=/home/david/sdir 
> /home/david/sdir/usr/xenomai/bin/xeno-config --skin native --cflags`
> 
> LDFLAGS=`DESTDIR=/home/david/sdir 
> /home/david/sdir/usr/xenomai/bin/xeno-config --skin native --ldflags`
> 
> 
> #include <stdio.h>
> #include <stdlib.h>
> #include <fcntl.h>
> #include <unistd.h>
> #include <sys/stat.h>
> #include <sys/types.h>
> #include <sys/ioctl.h>
> #include <signal.h>
> #include <sys/mman.h>
> 
> #include <getopt.h>
> #include <linux/types.h>
> #include <linux/spi/spidev.h>
> #include <string.h>
> #include <sys/socket.h>
> #include <netinet/in.h>
> #include <netdb.h>
> 
> #include <native/task.h>
> #include <native/timer.h>
> #include <native/pipe.h>
> #include <rtdk.h>
> #include <rtdm/rtipc.h>
> #include <rtdm/rtdm.h>
> #include <rtdm/rtcan.h>
> 
> RT_TASK blink_task;
> 
> #define TIMESLEEP 1000000 /* 1 msec(ns) */
> 
> #define ARRAY_SIZE(a) (sizeof(a) / sizeof((a)[0]))
> #define PORT           8080
> #define HOST           "192.168.1.101"
> #define DIRSIZE        8192
> #define    HIGH        1
> #define    LOW        0
> 
> #define HIGH_TIME    12
> #define    LOW_TIME    1
> #define    TIME_USEC    0
> 
> static const char *device = "/dev/spidev3.0";
> static uint8_t mode;
> static uint8_t bits = 8;
> static uint32_t speed = 11000000;
> //static uint16_t delay=1;
> 
> 
> int fd;
> FILE    *fp;
> FILE    *fpx;
> char    set_value[4];
> int     state;
> int    ret = 0;
> //struct    sockaddr_in sin;
> struct    sockaddr_in pin;
> struct    hostent *hp;
> int    sd;
> char    hostname[100];
> char    return_array[400];
> int     i;
> void blink(void *arg __attribute__((__unused__)))
> {
>      uint8_t tx[] = {
> 0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,
> 0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,
> 0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,
> 0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,
> 0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,
> 0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,
> 0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,
> 0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,
> 0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,
> 0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,
> 0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,
> 0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,
> 0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,
> 0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,
> 0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,
> 0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,
> 0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,
> 0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,
> 0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,
> 0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,
> 0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,
> 0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,
> 0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,
> 0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,
> 0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,
> 0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,
> 0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,
> 0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,
> 0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,
> 0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,
> 0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,
> 0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,
> 0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,
> 0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,
> 0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,
> 0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,
>      };
>      uint8_t rx[ARRAY_SIZE(tx)] = {0, };
>      struct spi_ioc_transfer tr = {
>          .tx_buf = (unsigned long)tx,
>          .rx_buf = (unsigned long)rx,
>          .len = ARRAY_SIZE(tx),
>          .delay_usecs = TIME_USEC,
>          .speed_hz = speed,
>          .bits_per_word = bits,
>      };
>       rt_task_set_periodic(NULL, TM_NOW, TIMESLEEP);
>      if (ret == -1)
>          printf("can't set spi mode");
>      while(1)
>      {
>          rt_task_wait_period(NULL);
>      ret = ioctl(fd, SPI_IOC_MESSAGE(1), &tr);
>      for(i = 0;i < 360;i++)
>          {
>          return_array[i] = 68;
>          }
>      return_array[359] = 0;
> 
>      if (ret < 1)
>          printf("can't send spi message");
> 
>      if (send(sd, return_array, strlen(return_array), 0) == -1)
>              {
>              perror("send");
>              exit(1);
>              }
>      }
> }
> 
> void catch_signal() {}
> 
> int main(void)
> {
>      signal(SIGTERM, catch_signal);
>      signal(SIGINT, catch_signal);
> 
>      /* Avoids memory swapping for this program */
>      mlockall(MCL_CURRENT|MCL_FUTURE);
> 
>         fd = open(device, O_RDWR);
>    //     fd = rt_dev_open(device, O_RDWR);
>      if (fd < 0)
>          printf("can't open device");
> 
>      mode |= SPI_CPHA;
> /*
>       * spi mode
>       */
>      ret = ioctl(fd, SPI_IOC_WR_MODE, &mode);
>      if (ret == -1)
>          printf("can't set spi mode");
> 
>      ret = ioctl(fd, SPI_IOC_RD_MODE, &mode);
>      if (ret == -1)
>          printf("can't get spi mode");
> 
>      /*
>       * bits per word
>       */
>      ret = ioctl(fd, SPI_IOC_WR_BITS_PER_WORD, &bits);
>      if (ret == -1)
>          printf("can't set bits per word");
> 
>      ret = ioctl(fd, SPI_IOC_RD_BITS_PER_WORD, &bits);
>      if (ret == -1)
>          printf("can't get bits per word");
> 
>      /*
>       * max speed hz
>       */
>      ret = ioctl(fd, SPI_IOC_WR_MAX_SPEED_HZ, &speed);
>      if (ret == -1)
>          printf("can't set max speed hz");
> 
>      ret = ioctl(fd, SPI_IOC_RD_MAX_SPEED_HZ, &speed);
>      if (ret == -1)
>          printf("can't get max speed hz");
>      /************************************************/
>      /*    Ethernet stuff                */
>      /************************************************/
>      strcpy(hostname,"192.168.0.101");//HOST);
> 
> 
>      /* go find out about the desired host machine */
>      if ((hp = gethostbyname(hostname)) == 0)
>          {
>          perror("gethostbyname");
>          exit(1);
>          }
> 
>      /* fill in the socket structure with host information */
>      memset(&pin, 0, sizeof(pin));
>      pin.sin_family = AF_INET;
>      pin.sin_addr.s_addr = ((struct in_addr *)(hp->h_addr))->s_addr;
>      pin.sin_port = htons(PORT);
> 
>      /* grab an Internet domain socket */
>      if ((sd = socket(AF_INET, SOCK_STREAM, 0)) == -1)
>          {
>          perror("socket");
>          exit(1);
>          }
> 
>      /* connect to PORT on HOST */
>      if (connect(sd,(struct sockaddr *) &pin, sizeof(pin)) == -1)
>          {
>          perror("connect");
>          exit(1);
>          }
> 
>      /* Task Creation */
>      rt_task_create(&blink_task, "blinkLed", 0, 99, 0);
>      rt_task_start(&blink_task, &blink, NULL);
>      getchar();
>      rt_task_delete(&blink_task);
>      close(fd);
> 
>      return 0;
> }
> 
> 
> _______________________________________________
> Xenomai-help mailing list
> Xenomai-help@domain.hid
> https://mail.gna.org/listinfo/xenomai-help

-- 
Philippe.



