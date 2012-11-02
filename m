Message-ID: <d0e366dc91d7b37cd45f8b3a550ea2fd.squirrel@www.xenomai.org>
In-Reply-To: <5093F975.9060807@gmail.com>
References: <a81ced276a31df626d584233b83aeb10.squirrel@www.xenomai.org>
	<5092AEB3.2070009@gmail.com>
	<4b27818deb6c26a74a2ab839cb07f718.squirrel@www.xenomai.org>
	<5093F975.9060807@gmail.com>
Date: Fri, 2 Nov 2012 18:13:50 +0100
From: "Gilles Chanteperdrix" <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
Content-Type: text/plain;charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Subject: Re: [Xenomai] Compiling the Xenomai examples
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Stefan Videv <videvstefan@gmail.com>
Cc: xenomai@xenomai.org


Stefan Videv wrote:
> make XENO=/media/rootfs/usr/xenomai/ ARCH=arm-linux-gnueabi-
> KSRC=/media/rootfs/usr/include DESTDIR=/media/rootfs

Should be ARCH=arm CROSS_COMPILE=arm-none-linux-gnueabi
and KSRC should be the path to the kernel sources.

-- 
                    Gilles.


