MIME-Version: 1.0
Sender: mfornero@gmail.com
In-Reply-To: <CAKS01o=pMH3T=_QqhD4a-nm5KMma2+0cepS0tVeRnqubnJ2gBg@mail.gmail.com>
References: <CAKS01okfPOzCckUbe+NCfPT3fSqst2JaGpnGG8VaPCwbjvtE_Q@mail.gmail.com>
 <CADVgf9n6daP32wfGR+61Ko0m8q=nSD+uNe42PneJ_S5uhg7yyw@mail.gmail.com>
 <CAKS01om0rP3i3eAux+SC1Zt4-0-NdqOwLhg_8HQP4yjCiX2t2A@mail.gmail.com>
 <CADVgf9mprWu-s+1gNzhrHtXQf6d3u87P7AQ3eNd0=cdg6zWnvQ@mail.gmail.com>
 <CAKS01okXjCV9v6vJ9W8UoqJ6d57h1rQvkPSbGOUugc5gymhyjg@mail.gmail.com>
 <CADVgf9kPw+q77x30UU=bRiZ039NsKd+83Mdv2iMZvHNxKb-hAA@mail.gmail.com>
 <CAKS01oncDWRS8rfyrBw2ctRSR=WX6Jyqp4=+jyRNPgpwqq_91g@mail.gmail.com>
 <CADVgf9=fV1y=_Lb3PVswajy2jTnWDyPwZyOSVBONnPyYbtYG0w@mail.gmail.com>
 <CAKS01o=pMH3T=_QqhD4a-nm5KMma2+0cepS0tVeRnqubnJ2gBg@mail.gmail.com>
Date: Mon, 4 Nov 2013 07:26:04 -0500
Message-ID: <CADVgf9kpqkGJyyFoQCyOMy5xi2UvMLKo6DXG8jd=_f5ugZ7PSQ@mail.gmail.com>
From: Matthew Fornero <mfornero.lists@gmail.com>
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
To: Anup Kini <akini@synapticon.com>
Cc: "xenomai@xenomai.org" <xenomai@xenomai.org>

On Mon, Nov 4, 2013 at 5:47 AM, Anup Kini <akini@synapticon.com> wrote:
>
> Hi All,
>
> Currently stuck with the following error:
>
>   CC      arch/arm/kernel/setup.o
> In file included from arch/arm/kernel/setup.c:45:0:
> /home/akini/neo-linux/arch/arm/include/asm/tlbflush.h: In function 'local_flush_tlb_mm':
> /home/akini/neo-linux/arch/arm/include/asm/tlbflush.h:343:19: error: invalid operands to binary & (have 'atomic64_t' and 'long long unsigned int')
> /home/akini/neo-linux/arch/arm/include/asm/tlbflush.h: In function 'local_flush_tlb_page':
> /home/akini/neo-linux/arch/arm/include/asm/tlbflush.h:379:5: error: invalid operands to binary & (have 'atomic64_t' and 'long long unsigned int')
> make[1]: *** [arch/arm/kernel/setup.o] Error 1
> make: *** [arch/arm/kernel] Error 2
>
> I am using the 3.8.13-arm-3 patch currently, not sure where i went wrong.
> I did not face this when i used the 3.8-arm-1 patch.
> Any help / suggestion ?!! :)

I haven't tried this version yet, but you're attempting to use a patch
for 3.8.13 against at 3.8.0 kernel. The patch likely depends on some
changes between 3.8.0 and 3.8.13 in mainline.

I've got Zynq HW again, so I'm hoping to be able to post git trees for
3.8.0 and 3.8.13 shortly, but here's how I would approach it:

1) git clone from xilinx's v14.5 tag
2) apply the zynq -pre patch
3) git merge from the 3.8.arm-1 tag in the ipipe 3.8 tree
4) apply the zynq -post patch
[you now have a 3.8 patched zynq tree]
5) git merge from the head of the ipipe 3.8 tree (or the arm-3 patch tag)

You still may run into merge conflicts or compile errors, but this
will at least grab all the content required.

-Matt

