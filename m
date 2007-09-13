Message-ID: <2ff1a98a0709130245k124d5817se380b4424784d8e1@domain.hid>
Date: Thu, 13 Sep 2007 11:45:39 +0200
From: "Gilles Chanteperdrix" <gilles.chanteperdrix@xenomai.org>
In-Reply-To: <1ce16a2c0709130238q7a839081la85d90eac14a5b1f@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <1ce16a2c0709100614u3f23fce9yd2be767406fa536a@domain.hid>
	<46E58BE4.9090109@domain.hid>
	<1ce16a2c0709101142r6cf2d624oe443807575eadcfa@domain.hid>
	<46E59235.2060506@domain.hid>
	<1ce16a2c0709110837r52eedac7vcc970d5c3b4e2d53@domain.hid>
	<46E6F290.9090901@domain.hid>
	<1ce16a2c0709120702m1d4cc503vb045f3d2e0814d67@domain.hid>
	<46E87584.9020301@domain.hid> <46E8D55B.3090806@domain.hid>
	<1ce16a2c0709130238q7a839081la85d90eac14a5b1f@domain.hid>
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
Cc: xenomai@xenomai.org, Jan Kiszka <jan.kiszka@domain.hid>

On 9/13/07, Bachman Kharazmi <bahkha@domain.hid> wrote:
> int main(int argc)
> {
>        int fd;
>         char* myString = "helloworld\n";
>        fd = open("rtser0", O_RDWR);
>        ioctl(fd, RTSER_RTIOC_SET_CONFIG, &write_config);
>        write(fd, myString, strlen(myString));
>        close(fd);
>        return 0;
> }
> Is supposed to be the POSIX skin. It does compile, but nothing sent on
> my serial port.

This code is crappy. You do not check the return values of functions
which return a result so you have no chance to understand what
happens.

-- 
                                               Gilles Chanteperdrix

