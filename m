Message-ID: <4E0478F7.40706@domain.hid>
Date: Fri, 24 Jun 2011 13:45:59 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <BANLkTimFiO9JAdvYjpnx9bpvFo2W1zYX3g@domain.hid>
In-Reply-To: <BANLkTimFiO9JAdvYjpnx9bpvFo2W1zYX3g@domain.hid>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] Regarding booting
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: suresh reddy <sureshreddy.balijepalli@domain.hid>
Cc: Xenomai help <xenomai@xenomai.org>

On 06/24/2011 11:57 AM, suresh reddy wrote:
> Hi all,
> 
> my booting process getting freezed after the message
> 
> uncompressing the kernel.

Ah, you mean it freezes right after the message:
 "[    0.645019] Xenomai: debug mode enabled."

Ok. Let us start from the beginning. Please try to follow exactly this 
procedure, and tell me if you get a working uImage:

mkdir /tmp/xeno
cd /tmp/xeno
wget http://www.codesourcery.com/sgpp/lite/arm/portal/package7851/public/arm-none-linux-gnueabi/arm-2010.09-50-arm-none-linux-gnueabi-i686-pc-linux-gnu.tar.bz2
tar -xvjf arm-2010.09-50-arm-none-linux-gnueabi-i686-pc-linux-gnu.tar.bz2
export PATH=/tmp/xeno/arm-2010.09/bin:$PATH
git clone --depth 1 git://git.xenomai.org/xenomai-2.5.git
git clone --depth 1 --branch for-ipipe-2.6.37-arm git://git.xenomai.org/ipipe-gch.git
cd ipipe-gch
../xenomai-2.5/scripts/prepare-kernel.sh --arch=arm --linux=.
wget -O .config http://sisyphus.hd.free.fr/~gilles/omap4_panda_config
yes "" | make ARCH=arm oldconfig
make -j 8 ARCH=arm CROSS_COMPILE=arm-none-linux-gnueabi- uImage

The uImage will be found in /tmp/xeno/ipipe-gch/arch/arm/boot/uImage
The result of this compilation works for me. If it does not work for
you, please download it here:
http://sisyphus.hd.free.fr/~gilles/uImage-panda

And tell me if it still does not work.

> (Sourcery G++ Lite 2009q1-203)

I thought we found out that you could not compile with this version? 

> [    0.000000] Kernel command line: ro elevator=noop vram=32M
> mem=460M@0x80000000 mem=256M@0xA0000000 root=/dev/mmcblk0p2
> console=ttyO2,115200n8 fixrtc earlyprintk bootm 0x80000000

You have some problem here: bootm is a u-boot command it should not
end up on the kernel command line. Also, in a first step, please remove
the "mem" arguments.

-- 
                                                                Gilles.

