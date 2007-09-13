Message-ID: <1ce16a2c0709130238q7a839081la85d90eac14a5b1f@domain.hid>
Date: Thu, 13 Sep 2007 11:38:58 +0200
From: "Bachman Kharazmi" <bahkha@domain.hid>
In-Reply-To: <46E8D55B.3090806@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
References: <1ce16a2c0709100614u3f23fce9yd2be767406fa536a@domain.hid>
	<46E58BE4.9090109@domain.hid>
	<1ce16a2c0709101142r6cf2d624oe443807575eadcfa@domain.hid>
	<46E59235.2060506@domain.hid>
	<1ce16a2c0709110837r52eedac7vcc970d5c3b4e2d53@domain.hid>
	<46E6F290.9090901@domain.hid>
	<1ce16a2c0709120702m1d4cc503vb045f3d2e0814d67@domain.hid>
	<46E87584.9020301@domain.hid> <46E8D55B.3090806@domain.hid>
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
To: Jan Kiszka <jan.kiszka@domain.hid>
Cc: xenomai@xenomai.org

int main(int argc)
{
       int fd;
=09char* myString =3D "helloworld\n";
       fd =3D open("rtser0", O_RDWR);
       ioctl(fd, RTSER_RTIOC_SET_CONFIG, &write_config);
       write(fd, myString, strlen(myString));
       close(fd);
       return 0;
}
Is supposed to be the POSIX skin. It does compile, but nothing sent on
my serial port.


On 13/09/2007, Jan Kiszka <jan.kiszka@domain.hid> wrote:
> Jan Kiszka wrote:
> > Bachman Kharazmi wrote:
> >>> You can copy this code almost unmodified into an application and comp=
ile
> >>> it against the Xenomai POSIX skin. The serial port configuration apar=
t
> >>> (same under Linux, though), it will open "rtser<whatever>", even if
> >>> given like "/dev/rtser...", and work on that port as if it where a Li=
nux
> >>> one. Life can be simple, sometimes.
> >> Simple? ;)
> >> I've tried to write a c-program which basiclly should open the device
> >> rtser0 and write 100x to it and then close.
> >>
> >> The simple program can be found here: http://pastebin.ca/693873
> >>
> >> I've connected the serial cable to a reading terminal, but there's no
> >> data at all, when I run the binary. :/
> >>
> >
> > [Untested late-night hack after some Ma=DF of beer - please excuse
> > potential nonsense.]
> >
> > POSIX skin
> > ----------
> > (use xeno-config --posix-cflags --posix-ldflags as compiler args)
> >
> > #include bla bla bla
> >
> > static const struct rtser_config write_config =3D {
> >         .config_mask       =3D RTSER_SET_BAUD,
> >         .baud_rate         =3D 115200,
> > };
> >
> > int main(int argc, char *argv[])
> > {
> >       int fd;
> >
> >       fd =3D open("/dev/rtser0", O_RDWR);
> >       ioctl(fd, RTSER_RTIOC_SET_CONFIG, &write_config);
> >       write(fd, argv[1], strlen(argv[1]));
> >       close(fd);
> >
> >       return 0;
> > }
> >
> >
> > Native skin
> > -----------
> >
> > ...
> > int main(int argc, char *argv[])
> > {
> >       int fd;
> >       RT_TASK task;
> >
> >       fd =3D rt_dev_open("/dev/rtser0", O_RDWR);
>
> The first error, copy&paste: This must be just "rtser0".
>
> >       rt_dev_ioctl(fd, RTSER_RTIOC_SET_CONFIG, &write_config);
> >
> >       rt_task_shadow(&task, NULL, 0, 0); /* may be done earlier,
> >                                               but not later */
> >
> >       rt_dev_write(fd, argv[1], strlen(argv[1]));
> >       rt_dev_close(fd);
> >
> >       return 0;
> > }
> >
> >
> > Similar is imaginable for reading from the serial port.
> >
> > Completed and tested versions, maybe also taking the baudrate as
> > argument, will be happily accepted to the examples or tools repos.
>
> BTW, a generic serial dump tool should, of course, also take the port
> number as parameter.
>
> Jan
>
>
>

