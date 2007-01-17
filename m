Message-ID: <45AE1E91.8050900@domain.hid>
Date: Wed, 17 Jan 2007 14:03:13 +0100
From: Steven Scholz <steven.scholz@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-help] special glibc support for Xenomai?
References: <45AE059C.9050605@domain.hid>	
	<1169033628.17493.35.camel@domain.hid> <45AE0C86.9080101@domain.hid>
	<1169036056.17493.43.camel@domain.hid>
In-Reply-To: <1169036056.17493.43.camel@domain.hid>
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
To: rpm@xenomai.org
Cc: xenomai@xenomai.org

Philippe,

>>> You just need to make sure to compile/link with the hardened
>>> Xenomai POSIX library, try running:
>>> $ xeno-config --posix-cflags|--posix-ldflags.
>> What does it do?
> 
> It returns the proper CFLAGS and LDFLAGS to use in order to compile a
> POSIX application using the Xenomai hardened POSIX library. In short,
> libpthread.so is partially shadowed by our libpthread_rt.so library.

xeno-config --verbose
    --version="2.3.50"
    --cc="arm-softfloat-linux-gnu-gcc"
    --arch="arm"
    --prefix="/usr/xenomai"
    --xeno-cflags="-I/usr/xenomai/include -D_GNU_SOURCE -D_REENTRANT"
    --xeno-ldflags="-L/usr/xenomai/lib -lpthread "
    --posix-cflags="-I/usr/xenomai/include -I/usr/xenomai/include/posix
-D_GNU_SOURCE -D_REENTRANT -D__XENO__"
    --posix-ldflags="-L/usr/xenomai/lib -lpthread_rt -lpthread -lrt "
    --library-dir="/usr/xenomai/lib"

Sorry. I have to ask again. What am I supposed to do with these lines?
Shell I use all of it whenn calling arm-softfloat-linux-gnu-gcc to compile
my application?

Thanks!

Steven

