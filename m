Message-ID: <51DDB5C3.7010307@xenomai.org>
Date: Wed, 10 Jul 2013 21:28:03 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <A46EF8CF1BBB8E4B8A27B73E177C466402463ADE@MAIL-SINTERS-01.sinters-int.fr>,
	<51DBF250.9070804@xenomai.org>
	<A46EF8CF1BBB8E4B8A27B73E177C466402464B37@MAIL-SINTERS-01.sinters-int.fr>,
	<51DC560F.90805@xenomai.org>
	<A46EF8CF1BBB8E4B8A27B73E177C4664033EC616@MAIL-SINTERS-01.sinters-int.fr>
In-Reply-To: <A46EF8CF1BBB8E4B8A27B73E177C4664033EC616@MAIL-SINTERS-01.sinters-int.fr>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] RE : RE : No boot kernel with xenomai on i.MX6Q
	Sabrelite
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Younes CHALABI <y.chalabi@sinters.fr>
Cc: "xenomai@xenomai.org" <xenomai@xenomai.org>

On 07/10/2013 03:00 PM, Younes CHALABI wrote:

> Hi Gilles,
>
> I followed your advice, using the xenomai-master, but now the kernel not boot also. It stops at :
>
> ## Booting kernel from Legacy Image at 10800000 ...
>     Image Name:   Linux-3.0.15
>     Image Type:   ARM Linux Kernel Image (uncompressed)
>     Data Size:    3825732 Bytes =  3.6 MB
>     Load Address: 10008000
>     Entry Point:  10008000
>     Verifying Checksum ... OK
>     Loading Kernel Image ... OK
> OK
>
> Starting kernel ...
>
> Uncompressing Linux... done, booting the kernel.


You already asked this question, it was answered here:
http://www.xenomai.org/pipermail/xenomai/2013-June/028760.html

>
> Sorry for disturbing you, but it's been a month since I still can not run xenomai on the Sabrelite board. Now I need concise answers :




>
> 1- Did you already used Xenomai on the Sabrelite board ?

 >

> 2- Which kernel | xenomai version and patches for the Sabrelite board ?


You already asked these questions, they were answered here:
http://www.xenomai.org/pipermail/xenomai/2013-April/028137.html


>
> 3- After the build I've got two folders :
>
>       1) build_root contains  : linux and xenomai
>
>       2) staging_dir contains : dev and usr
>
> All I do to transfer the images is :
>
>       1) Take U-BOOT from LTIB
>
>       2) Take ROOTFS from LTIB
>
>       3) Take KERNEL (uImage) from build_root/linux/arch/arm/boot
>
> Are these files all I need to have, to run Xenomai on the Sabrelite board ?

 >

> Or I still have to do something ?


You manage how you want, but if you want to run examples on the board, 
they have to find the xenomai libraries and device nodes. As already 
answered, there is more than one way to do it.
http://www.xenomai.org/pipermail/xenomai/2013-June/028749.html


-- 
                                                                 Gilles.

