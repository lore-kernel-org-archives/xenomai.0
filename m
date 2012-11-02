Message-ID: <5094066F.80501@gmail.com>
Date: Fri, 02 Nov 2012 17:44:15 +0000
From: Stefan Videv <videvstefan@gmail.com>
MIME-Version: 1.0
References: <a81ced276a31df626d584233b83aeb10.squirrel@www.xenomai.org>
	<5092AEB3.2070009@gmail.com>
	<4b27818deb6c26a74a2ab839cb07f718.squirrel@www.xenomai.org>
	<5093F975.9060807@gmail.com>
	<d0e366dc91d7b37cd45f8b3a550ea2fd.squirrel@www.xenomai.org>
In-Reply-To: <d0e366dc91d7b37cd45f8b3a550ea2fd.squirrel@www.xenomai.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] Compiling the Xenomai examples
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: xenomai@xenomai.org

On 11/02/2012 05:13 PM, Gilles Chanteperdrix wrote:
> Stefan Videv wrote:
>> make XENO=/media/rootfs/usr/xenomai/ ARCH=arm-linux-gnueabi-
>> KSRC=/media/rootfs/usr/include DESTDIR=/media/rootfs
> Should be ARCH=arm CROSS_COMPILE=arm-none-linux-gnueabi
> and KSRC should be the path to the kernel sources.
>
Running the above (with the correction) produces the following:

sed: can't read /media/rootfs/usr/include/Makefile: No such file or 
directory

make -C /media/rootfs/usr/include 
SUBDIRS=/home/stefan/xenomai-2.6.1/examples/rtdm/driver-api modules
make[2]: Entering directory `/media/rootfs/usr/include'
make[2]: *** No rule to make target `modules'. Stop.
make[2]: Leaving directory `/media/rootfs/usr/include'
make[1]: *** [all] Error 2
make[1]: Leaving directory 
`/home/stefan/xenomai-2.6.1/examples/rtdm/driver-api'
sed: can't read /media/rootfs/usr/include/Makefile: No such file or 
directory
make[1]: Entering directory `/home/stefan/xenomai-2.6.1/examples/posix'
make -C /media/rootfs/usr/include ARCH=arm 
CROSS_COMPILE=arm-linux-gnueabi 
SUBDIRS=/home/stefan/roosenXenomaiBone/xenomai-2.6.1/examples/posix modules
make[2]: Entering directory `/media/rootfs/usr/include'
make[2]: *** No rule to make target `modules'. Stop.
make[2]: Leaving directory `/media/rootfs/usr/include'
make[1]: *** [all] Error 2

