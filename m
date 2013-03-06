Message-ID: <5136F5E6.6090003@xenomai.org>
Date: Wed, 06 Mar 2013 08:53:10 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <1362541011.90317.YahooMailNeo@web161401.mail.bf1.yahoo.com>
	<5136F3A6.8090400@antcom.de>
In-Reply-To: <5136F3A6.8090400@antcom.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] about Xenomai in Debian and Ubuntu
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Roland Stigge <stigge@antcom.de>
Cc: "xenomai@xenomai.org" <xenomai@xenomai.org>

On 03/06/2013 08:43 AM, Roland Stigge wrote:

> Hi,
> 
> On 06/03/13 04:36, Tom Z wrote:
>> I noticed that Debian and Ubuntu desktop distro's have included Xenomai, 
>> and I can "install" Xenomai through the software center in these 
>> distro's.
> 
> I can only speak for Debian here. We deliberately don't promote it as
> "desktop distro". Rather as "Universal OS", to underline its use in the
> Server, Embedded, Realtime areas, etc.
> 
>> But after I "installed" Xenomai in Ubuntu, executing  "dmesg | grep xenomai" showed nothing, so I am wondering if I still need to 
>> patch and compile the kernels before using the Xenomai features? If so, 
>> what benefits does it have to include Xenomai in these distro's.
> 
> First, you still have to compile the Xenomai-enabled kernel yourself
> (but this might change in the future). This is supported by the
> Debian-included package linux-patch-xenomai. The file
> 
> /usr/share/doc/linux-patch-xenomai/README.Debian
> 
> gives instructions how to prepare the kernel as a Debian package.
> 
> Second, Debian ships Xenomai's userland programs and libraries, so you
> can use them directly, without compiling.
> 
> Since Debian derived distros (as you mentioned one) typically copy the
> Xenomai packages from Debian, much of this should apply there also, but
> I can't guarantee this.


As a side note, we started with 2.6.2.1 to provide pre-compiled kernel
packages for the Debian stable distribution, simply add:

deb http://www.xenomai.org/debian squeeze main

Then run:
apt-get update
apt-get install xenomai-keyring
Answer yes
apt-get update
apt-get install linux-image-3.5.7-xenomai-2.6.2.1 xenomai-runtime

Then reboot on the new kernel, and you should be able to launch:
xeno latency

The Linux CNC project also provides packages for Ubuntu Precise, Debian
Squeeze and Ubuntu Lucid, see:

http://wiki.linuxcnc.org/cgi-bin/wiki.pl?XenomaiKernelPackages

-- 
                                                                Gilles.

