Message-ID: <51DE95D6.90309@xenomai.org>
Date: Thu, 11 Jul 2013 13:24:06 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <8D04C20495DBA75-794-B61A4@webmailstg-m05.sysops.aol.com>
In-Reply-To: <8D04C20495DBA75-794-B61A4@webmailstg-m05.sysops.aol.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] no kernel-patch on the boot menu
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: benehub@aol.com
Cc: xenomai@xenomai.org

On 07/11/2013 09:35 AM, benehub@aol.com wrote:

>
> Hello
>
> I installed xenomai2.6.2.1  linux-2.6.32 adeos-ipipe-2.6.32.7.x86-2.6-02.patch
> next I followed
> http://www.xenomai.org/documentation/xenomai-2.6/html/README.INSTALL/#_building_for_x86_32_64bit
>
>
>
> $ $xenomai_root/scripts/prepare-kernel.sh --arch=x86 \
>    --adeos=$xenomai_root/ksrc/arch/x86/patches/adeos-ipipe-2.6.29.4-x86-X.Y-ZZ.patch \
>    --linux=$linux_tree
> $ cd $linux_tree
> $ make [ARCH=i386] menuconfig
>
>
>
> I configured my kernel then I did a "make", waited a long time and now when I boot , I just see my previous kernel.
>
> There is not kernel patched. Why?


Because the kernel you compiled is not installed. But this question has 
nothing to do with xenomai, it is simply about compiling a custom 
kernel. So, either you find this information elsewhere, or if you find 
it compilicated to compile a custom kernel, try nstalling a pre-compiled 
kernel, such as the ones provided by the LinuxCNC project:

http://wiki.linuxcnc.org/cgi-bin/wiki.pl?XenomaiKernelPackages

-- 
                                                                 Gilles.

