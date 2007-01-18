Message-ID: <45AF44A1.6060509@domain.hid>
Date: Thu, 18 Jan 2007 10:57:53 +0100
From: Steven Scholz <steven.scholz@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-help] special glibc support for Xenomai?
References: <45AE059C.9050605@domain.hid>		<1169033628.17493.35.camel@domain.hid>
	<45AE0C86.9080101@domain.hid>	<1169036056.17493.43.camel@domain.hid>
	<45AE1E91.8050900@domain.hid> <45AE25D2.5070706@domain.hid>
In-Reply-To: <45AE25D2.5070706@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
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
Cc: xenomai@xenomai.org

Gilles,

>> Sorry. I have to ask again. What am I supposed to do with these lines?
>> Shell I use all of it whenn calling arm-softfloat-linux-gnu-gcc to compile
>> my application?
> 
> Yes, you should pass the result of xeno-config --posix-cflags and
> xeno-config --posix-ldflags to arm-softfloat-linux-gnu-gcc. When running
> xeno-config --posix-ldflags here, I get:
> 
> -Wl,--wrap,pthread_create -Wl,--wrap,pthread_setschedparam
> ...

Ah. Thanks! Passing these flags seems to work now.
But I had to copy and paste it from your mail since when I run ./xeno-config
--posix-ldflags I get

POSIX support is not available

???

How is that?

Steven

