Message-ID: <1ce16a2c0709130541n22689526qc4fbbecdc541e573@domain.hid>
Date: Thu, 13 Sep 2007 14:41:04 +0200
From: "Bachman Kharazmi" <bahkha@domain.hid>
In-Reply-To: <2ff1a98a0709130518q673bbc78q4f7d0a6436db9cd@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <1ce16a2c0709100614u3f23fce9yd2be767406fa536a@domain.hid>
	<1ce16a2c0709120702m1d4cc503vb045f3d2e0814d67@domain.hid>
	<46E87584.9020301@domain.hid> <46E8D55B.3090806@domain.hid>
	<1ce16a2c0709130238q7a839081la85d90eac14a5b1f@domain.hid>
	<2ff1a98a0709130245k124d5817se380b4424784d8e1@domain.hid>
	<1ce16a2c0709130251t4e8b5975rc6c68ab2d826fc2a@domain.hid>
	<2ff1a98a0709130256w71f1c6f9kd53f435fa749d942@domain.hid>
	<1ce16a2c0709130307k5e1955d4na694e90503084d0d@domain.hid>
	<2ff1a98a0709130518q673bbc78q4f7d0a6436db9cd@domain.hid>
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
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: Xenomai <xenomai@xenomai.org>

#include <errno.h>
...
int main(int argc){
        int fd,err;
        extern int errno;
	char* myString = "helloworld\n";
        errno=0;
	fd = open("rtser0", O_RDWR);
	printf("errno is : %d\n",errno);
	if (fd < 0) {
		printf(MAIN_PREFIX "1 : can't open %s (write), %s\n", WRITE_FILE,
strerror(-fd));
		return fd;
	}

sandbox:/home/bkw/code/driver_v4# ./simpledriver_v4
errno is : 2
main : 1 : can't open rtser0 (write), Operation not permitted

Correct way of using errno?
Hope so..
/Bachman
On 13/09/2007, Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org> wrote:
> On 9/13/07, Bachman Kharazmi <bahkha@domain.hid> wrote:
> > int main(int argc){
> >         int fd,err;
> >          char* myString = "helloworld\n";
> >         fd = open("rtser0", O_RDWR);
> >         if (fd < 0) {
> >                 printf(MAIN_PREFIX "1 : can't open %s (write), %s\n", WRITE_FILE,
> > strerror(-fd));
> >                 return fd;
> >         }
> >         err=ioctl(fd, RTSER_RTIOC_SET_CONFIG, &write_config);
> >         if (err < 0) {
> >                 printf(MAIN_PREFIX "2 : error %s (write), %s\n", WRITE_FILE, strerror(-fd));
> >                 return err;
> >         }
> >         err=write(fd, myString, strlen(myString));
> >         if (err < 0) {
> >                 printf(MAIN_PREFIX "3 : error %s (write), %s\n", WRITE_FILE, strerror(-fd));
> >                 return err;
> >         }
> >         printf("err is %d\n", err);
> >         close(fd);
> >         return 0;
> > }
> >
> > sandbox:/home/bkw/code/driver_v4# ./simpledriver_v4
> > main : 1 : can't open rtser0 (write), Operation not permitted
> >
> > why that, I'm running as root? :/
> > /BK
>
> When a posix function returns -1, the reason for the failure is stored
> in errno. You are not checking errno.
> If you do not know what errno is, type simply "man errno".
>
> --
>                                                Gilles Chanteperdrix
>

