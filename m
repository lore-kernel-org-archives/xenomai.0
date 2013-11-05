Message-ID: <20131105103552.15065b908xg469yw@webmail.upv.es>
Date: Tue, 05 Nov 2013 10:35:52 +0100
From: Jose Ignacio Cazalilla Morenas <jcazalilla@ai2.upv.es>
References: <20131104101653.20482fgez8ylxblx@webmail.upv.es>
 <5277B186.7010300@xenomai.org>
 <20131104162027.62643ch6wg2u2nuj@webmail.upv.es>
 <5277C3FB.2000600@xenomai.org>
In-Reply-To: <5277C3FB.2000600@xenomai.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"; delsp="Yes"; format="flowed"
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Xenomai] "Xenomai Posix skin init: pthread_setschedparam:
 Device or resource busy" in ARM IgepV2 Orocos+Xenomai
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: xenomai@xenomai.org


Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org> escribi=F3:

> On 11/04/2013 04:20 PM, Jose Ignacio Cazalilla Morenas wrote:
>>
>> Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org> escribi=F3:
>>
>>> On 11/04/2013 10:16 AM, Jose Ignacio Cazalilla Morenas wrote:
>>>> Hi all.
>>>> I'm trying to use Xenomai+Linaro under a IGEPv2, in order to install
>>>> Orocos (with the RT_TARGET=3Dxenomai).
>>>> I've been working with the IGEPv2 and ROS+Orocos, but with the
>>>> RTT_TARGET=3Dgnulinux, instead of Xenomai.
>>>>
>>>> Now, I've downloaded from git.isee.biz the kernel patched with Xenomai:
>>>>
>>>> $git clone git://git.isee.biz/pub/scm/linux-omap-2.6.git
>>>> $cd linux-omap-2.6/
>>>> $git checkout linux-2.6.35.y-rt
>>>> $make ARCH=3Darm igep00x0_defconfig
>>>> $make ARCH=3Darm CROSS_COMPILE=3Darm-linux-gnueabi- zImage modules
>>>> $sudo make ARCH=3Darm CROSS_COMPILE=3Darm-linux-gnueabi-
>>>> INSTALL_MOD_PATH=3D/media/root modules_install
>>>>
>>>> /*Copy&Paste the zImage to the Boot partition*/
>>>>
>>>> When I run the IgepV2, the kernel informs that Xenomai have been
>>>> installed properly (dmesg).
>>>>
>>>> [ 0.108093] I-pipe: Domain Xenomai registered.
>>>> [ 0.108123] Xenomai: hal/arm started.
>>>> [ 0.109252] Xenomai: scheduling class idle registered.
>>>> [ 0.109283] Xenomai: scheduling class rt registered.
>>>> [ 0.117645] Xenomai: real-time nucleus v2.6.0 (Movin' On) loaded.
>>>> [ 0.117675] Xenomai: debug mode enabled.
>>>> [ 0.118164] Xenomai: starting native API services.
>>>> [ 0.118164] Xenomai: starting POSIX services.
>>>> [ 0.118316] Xenomai: starting RTDM services.
>>>>
>>>>
>>>> Then, I have to install Xenomai at the user-space in order to use it
>>>> with Orocos (or other application), so I did (inside the IGEPv2, an
>>>> ARM embedded board):
>>>>
>>>> wget http://download.gna.org/xenomai/stable/xenomai-2.6.0.tar.bz2
>>>> tar jxf xenomai-2.6.0.tar.bz2
>>>> cd xenomai-2.6.0
>>>> ./configure CFLAGS=3D"-march=3Darmv7-a -mfpu=3Dvfp3 -marm"
>>>> make
>>>> make install
>>>>
>>>> If I run /usr/xenomai/bin/xeno-test, it works fine (it seems).
>>>>
>>>> So, I compile Orocos. It detects the Xenomai installation and compile.
>>>> However, when I run "deployer-xenomai" in order to start Orocos, I get
>>>> this error:
>>>>
>>>> root@igep2:~/orocos/orocos-toolchain# deployer-xenomai
>>>> Xenomai Posix skin init: pthread_setschedparam: Device or resource busy
>>>>
>>>> Therefore, it doesn't work due to this error: "Xenomai Posix skin
>>>> init: pthread_setschedparam: Device or resource busy".
>>>> I think it could be related to the configuration of Xenomai at the
>>>> user-space for the IGEPv2.
>>>> Any idea?
>>>
>>> Do you have the same issue with Xenomai latest release, that is Xenomai
>>> 2.6.3?
>>>
>>>
>>> --
>>>                                                                 Gilles.
>>>
>>
>>
>> Thanks for your answer, Gilles.
>> I'm just installing Xenomai 2.6.3 for the user-space, with the kernel
>> patched with Xenomai 2.6.0 (this kernel is provided by IgepV2
>> developers). I don't know if different versions of Kernel and
>> user-space are suitable...
>
> Xenomai 2.6.3 is ABI and API compatible with 2.6.0. However a lot of
> things have been fixed since 2.6.0. Besides, I routinely test Xenomai on
> IGEPv2 board, so I am pretty sure that the vanilla kernel works on IGEP,
> you do not need to rely on a fork.
>
>
> --
>                                                                 Gilles.
>

Which vanilla kernel do you mean exactly?
Maybe this one for omap devices? =20
https://git.kernel.org/cgit/linux/kernel/git/tmlind/linux-omap.git/

Thanks.
Jose



