MIME-Version: 1.0
In-Reply-To: <50D099E2.3080503@xenomai.org>
References: <CAPpP=rMVEY5_Ris9_HGPpsUFht-CdvPdWhPm7jtJ4qfZoyVjKw@mail.gmail.com>
	<50CC65AF.6040102@xenomai.org>
	<CAPpP=rPn8k2LTwrYQ_XkKE4vaiazfREnfCJEE5nbY0iD7Apofw@mail.gmail.com>
	<50CD3563.2070400@xenomai.org>
	<CAPpP=rMyDyfzLr=85+=KF-kMn1mYkGmd=ykRj71d40+35BOzdg@mail.gmail.com>
	<50CF00C4.7030701@xenomai.org>
	<CAPpP=rPhXs54eQMX_2L2an-t86LBc0ChTbkbTOTbUzTbDpunCg@mail.gmail.com>
	<50D099E2.3080503@xenomai.org>
Date: Wed, 19 Dec 2012 10:39:46 +0100
Message-ID: <CAPpP=rOF5ghUQb6Z5Se-C_rPpX-BWxCYx4bYzF3SCJj57rPFWA@mail.gmail.com>
From: alex alex <duch.alexandre@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Subject: Re: [Xenomai] RTDM - Dynamic linking of device
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: Xenomai <xenomai@xenomai.org>

Infact I thought "rtdm_dev_register" worked exclusively in the _init
function as indicated by the documentation. Following your advice I have
tested  "rtdm_dev_register" in another function of my RTDM driver (ioctl)
and it works well.

I think you might change the doc of rtdm_dev_register to :

This service can be called from:

   - Kernel module initialization/cleanup code
   - Kernel-based task

Same for rtdm_dev_unregister

Alex.
2012/12/18 Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>

> On 12/18/2012 03:38 PM, alex alex wrote:
>
>> Thanks for your answer, I have corrected the example program.
>>
>> What I would like to do is add x devices after that the module be loaded
>> and without naming these devices statically in the module, so am I forced
>> to call x times rtdm_dev_register with x declarations of the rtdm_device
>> structure in test.c?
>> If there is an other way, please tell me what it is.
>>
>
> What about creating a first static device with an ioctl allowing to create
> other devices?
>
> --
>                                             Gilles.
>
> ______________________________**_________________
> Xenomai mailing list
> Xenomai@xenomai.org
> http://www.xenomai.org/**mailman/listinfo/xenomai<http://www.xenomai.org/mailman/listinfo/xenomai>
>
