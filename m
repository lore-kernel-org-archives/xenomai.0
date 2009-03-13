Message-ID: <49BA2C7D.4010307@domain.hid>
Date: Fri, 13 Mar 2009 10:50:53 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <a0ef0a9d0902260303k711d228ct82e4bdae85d5ed1f@domain.hid>	<49A69429.1090502@domain.hid>
	<49A69C93.3040402@domain.hid>
	<a0ef0a9d0903130204i66319578n7ca62912abc8ba2@domain.hid>
In-Reply-To: <a0ef0a9d0903130204i66319578n7ca62912abc8ba2@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] Xenomai uClinux issue
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Ghanem Lafi <lafi.ghanem@domain.hid>
Cc: xenomai@xenomai.org

Ghanem Lafi wrote:
> Hi all,
> 
>  In order to port uClinux (this is the first step) on LPC2292 SODIMM board,
> I tried to work with :
> 
> *  uClinux-dist20080808
> *  Linux kernel 2.6.25
> *  arm-linux-tools20070808 (arm-linux-gcc 4.3.3)

gcc 4.3 is a bad idea on ARM, you should remain with gcc 4.2

> 
>  But I met many  problems and  I cannot execute the image on the target!!
> :(

Did you try asking about these "many problems" on the uclinux mailing list ?

> 
>  Contrary, when I worked with  other  sources  basing  on Linux2.6.11.8,
> uClinux  is ported successfully  on my target. So, I have to begin with this
> point because I have not enough time  for my training course.
> 
>  Now, my problem  is to find the compatible patch adeos-Ipipe  with the
> kernel 2.6.11.8 to combine Xenomai and uClinux because the available adeos
> patchs are  > = linux2.6.15.
> 
>  I m looking forward to your response as soon as possible.

So here is your choice:
1- either get a recent version of Linux to work with your board;
2- or backport the I-pipe patch to a 4 years old kernel.

I already told you that 1 is a better idea than 2. To do 1, you will get
any support you need on the uclinux mailing list or on this list, to do
2, nobody will help you. You decided not to follow my advices, what else
can I tell you?

-- 
                                                 Gilles.

