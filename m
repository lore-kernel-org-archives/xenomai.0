Message-ID: <2ff1a98a0709130548p580e66fck40fb62e1b688eda6@domain.hid>
Date: Thu, 13 Sep 2007 14:48:34 +0200
From: "Gilles Chanteperdrix" <gilles.chanteperdrix@xenomai.org>
In-Reply-To: <1ce16a2c0709130541n22689526qc4fbbecdc541e573@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <1ce16a2c0709100614u3f23fce9yd2be767406fa536a@domain.hid>
	<46E87584.9020301@domain.hid> <46E8D55B.3090806@domain.hid>
	<1ce16a2c0709130238q7a839081la85d90eac14a5b1f@domain.hid>
	<2ff1a98a0709130245k124d5817se380b4424784d8e1@domain.hid>
	<1ce16a2c0709130251t4e8b5975rc6c68ab2d826fc2a@domain.hid>
	<2ff1a98a0709130256w71f1c6f9kd53f435fa749d942@domain.hid>
	<1ce16a2c0709130307k5e1955d4na694e90503084d0d@domain.hid>
	<2ff1a98a0709130518q673bbc78q4f7d0a6436db9cd@domain.hid>
	<1ce16a2c0709130541n22689526qc4fbbecdc541e573@domain.hid>
Subject: Re: [Xenomai-help] adding PCI support to 16550A.c
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Bachman Kharazmi <bahkha@domain.hid>
Cc: Xenomai <xenomai@xenomai.org>

On 9/13/07, Bachman Kharazmi <bahkha@domain.hid> wrote:
> #include <errno.h>
> ...
> int main(int argc){
>         int fd,err;
>         extern int errno;
>         char* myString = "helloworld\n";
>         errno=0;
>         fd = open("rtser0", O_RDWR);
>         printf("errno is : %d\n",errno);
>         if (fd < 0) {
>                 printf(MAIN_PREFIX "1 : can't open %s (write), %s\n", WRITE_FILE,
> strerror(-fd));
>                 return fd;
>         }
>
> sandbox:/home/bkw/code/driver_v4# ./simpledriver_v4
> errno is : 2
> main : 1 : can't open rtser0 (write), Operation not permitted
>
> Correct way of using errno?

No, as indicated in errno manual page, the value of errno is defined
only if a system call indicates a failure. So, the correct way of
using errno is:

fd = open("rtser0", O_RDWR)

if (fd == -1) {
    fprintf(stderr, "open(rtser0): %s\n", strerror(errno));
    exit(EXIT_FAILURE);
}

or:

if (fd == -1) {
   perror("open(rtser0)");
   exit(EXIT_FAILURE);
}

Anyway, 2 is ENOENT strerror(2) is "No such file or directory"
It probably means that you are not compiling your program with the
flags returned by xeno-config.


-- 
                                               Gilles Chanteperdrix

