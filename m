MIME-Version: 1.0
In-Reply-To: <CADVgf9=fV1y=_Lb3PVswajy2jTnWDyPwZyOSVBONnPyYbtYG0w@mail.gmail.com>
References: <CAKS01okfPOzCckUbe+NCfPT3fSqst2JaGpnGG8VaPCwbjvtE_Q@mail.gmail.com>
 <CADVgf9n6daP32wfGR+61Ko0m8q=nSD+uNe42PneJ_S5uhg7yyw@mail.gmail.com>
 <CAKS01om0rP3i3eAux+SC1Zt4-0-NdqOwLhg_8HQP4yjCiX2t2A@mail.gmail.com>
 <CADVgf9mprWu-s+1gNzhrHtXQf6d3u87P7AQ3eNd0=cdg6zWnvQ@mail.gmail.com>
 <CAKS01okXjCV9v6vJ9W8UoqJ6d57h1rQvkPSbGOUugc5gymhyjg@mail.gmail.com>
 <CADVgf9kPw+q77x30UU=bRiZ039NsKd+83Mdv2iMZvHNxKb-hAA@mail.gmail.com>
 <CAKS01oncDWRS8rfyrBw2ctRSR=WX6Jyqp4=+jyRNPgpwqq_91g@mail.gmail.com>
 <CADVgf9=fV1y=_Lb3PVswajy2jTnWDyPwZyOSVBONnPyYbtYG0w@mail.gmail.com>
Date: Mon, 4 Nov 2013 11:47:30 +0100
Message-ID: <CAKS01o=pMH3T=_QqhD4a-nm5KMma2+0cepS0tVeRnqubnJ2gBg@mail.gmail.com>
From: Anup Kini <akini@synapticon.com>
Content-Type: text/plain; charset=ISO-8859-1
Subject: Re: [Xenomai] xenomai - zynq - linux-xlxn14.5 - booting halted !
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Matthew Fornero <mfornero.lists@gmail.com>
Cc: "xenomai@xenomai.org" <xenomai@xenomai.org>

Hi All,

Currently stuck with the following error:

  CC      arch/arm/kernel/setup.o
In file included from arch/arm/kernel/setup.c:45:0:
/home/akini/neo-linux/arch/arm/include/asm/tlbflush.h: In function
'local_flush_tlb_mm':
/home/akini/neo-linux/arch/arm/include/asm/tlbflush.h:343:19: error:
invalid operands to binary & (have 'atomic64_t' and 'long long unsigned
int')
/home/akini/neo-linux/arch/arm/include/asm/tlbflush.h: In function
'local_flush_tlb_page':
/home/akini/neo-linux/arch/arm/include/asm/tlbflush.h:379:5: error: invalid
operands to binary & (have 'atomic64_t' and 'long long unsigned int')
make[1]: *** [arch/arm/kernel/setup.o] Error 1
make: *** [arch/arm/kernel] Error 2

I am using the 3.8.13-arm-3 patch currently, not sure where i went wrong.
I did not face this when i used the 3.8-arm-1 patch.
Any help / suggestion ?!! :)

Will update once i have successfully built the kernel.




On 31 October 2013 19:54, Matthew Fornero <mfornero.lists@gmail.com> wrote:

> On Thu, Oct 31, 2013 at 9:36 AM, Anup Kini <akini@synapticon.com> wrote:
> > Thanks a lot for correcting me Matt.
> >
> > I would like to confirm one more thing regarding the ipipe xenomai patch.
> > which ipipe patch should i use ?
> > 1 - ipipe-core-3.8.13-arm-3.patch - this is availabe in the xenomai
> patches
> > folder.
> > 2 - ipipe-core-3.8-arm-1.patch - this is availabe from
> > http://download.gna.org/adeos/patches/v3.x/arm/
> >
> > I cross checked the two patches and there are many additions in [1]
> related
> > to debug and other things i could not understand.
>
> In case anyone else reading this runs into something similar-- did
> removing CONFIG_CPU_FREQ solve your problem?
>
> 3.8-arm-1 is (I believe) the 3.8[.0] patch, which is what I worked
> against when I last worked with Xenomai on Zynq.
> 3.8.13-arm-3 is what was released with Xenomai 2.6.3 (I believe), and
> it may contain general ipipe related bug fixes, but I've never tested
> it on Zynq so YMMV
>



-- 


*Anup Kini*Systems Engineer
*------------------------------*

*Synapticon*  |  Cyber-Physical System Solutions

Mobile:

Direct:

+49 151 / 638 646 73

+49 7335 / 186 999 21

Fax:
+49 7335 / 186 999 1






synapticon.com <http://www.synapticon.com/>  |
@synapticon_co<https://twitter.com/#!/synapticon_co>

Synapticon GmbH  |  Hohlbachweg 2  |  73344 Gruibingen, DE
Secretary +49 7335 / 186 999 0  |  General Manager: Nikolai Ensslen
Registry Court Ulm HRB 725114  |  USt-ID DE271647127

This message and any files transmitted with it are confidential and
intended
solely for the use of the individual or entity to whom they are addressed.
Please notify the sender immediately if you have received this e-mail by
mistake and delete it from your system.
