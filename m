Message-ID: <49B8DDD8.9090401@domain.hid>
Date: Thu, 12 Mar 2009 11:03:04 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <f48df4840903111547x2d92c434u1e403f86a5d4159f@domain.hid>
	<49B8DD18.9020803@domain.hid>
In-Reply-To: <49B8DD18.9020803@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] [Xenosim-2.4.7] libelf configure problem
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Bruno Rouchouse <brouchouse@domain.hid>
Cc: "Xenomai-help@domain.hid" <xenomai@xenomai.org>

Gilles Chanteperdrix wrote:
> Bruno Rouchouse wrote:
>> Hi list,
>>
>> I'm trying to compile xenosim-2.4.7 on my Ubuntu-8.10 with the following
>> host configuration:
>> - autoconf 2.61
>> - automake 1.10.1
>> - gcc-4.3.2
>>
>> My configure line is shown below:
>> ../xenomai-2.4.7/xenosim-2.4.7/configure
>> --prefix=/home/bruno/xenosim_install/
>> --with-gcc-tarball=/tmp/gcc-2.95.3.tar.gz --x-includes=/usr/include/X11
>> --x-libraries=/usr/lib32/ CFLAGS=-m32
> 
> I think the problem is that you need all the libraries in their 32 bits
> version. To do this with a Debian, you need to setup a 32 bits chroot,
> http://www.debian-administration.org/articles/356

Here is the Ubuntu version:
https://wiki.ubuntu.com/DebootstrapChroot

-- 
                                                 Gilles.

