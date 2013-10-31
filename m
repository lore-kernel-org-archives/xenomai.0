MIME-Version: 1.0
Sender: mfornero@gmail.com
In-Reply-To: <CAKS01oncDWRS8rfyrBw2ctRSR=WX6Jyqp4=+jyRNPgpwqq_91g@mail.gmail.com>
References: <CAKS01okfPOzCckUbe+NCfPT3fSqst2JaGpnGG8VaPCwbjvtE_Q@mail.gmail.com>
 <CADVgf9n6daP32wfGR+61Ko0m8q=nSD+uNe42PneJ_S5uhg7yyw@mail.gmail.com>
 <CAKS01om0rP3i3eAux+SC1Zt4-0-NdqOwLhg_8HQP4yjCiX2t2A@mail.gmail.com>
 <CADVgf9mprWu-s+1gNzhrHtXQf6d3u87P7AQ3eNd0=cdg6zWnvQ@mail.gmail.com>
 <CAKS01okXjCV9v6vJ9W8UoqJ6d57h1rQvkPSbGOUugc5gymhyjg@mail.gmail.com>
 <CADVgf9kPw+q77x30UU=bRiZ039NsKd+83Mdv2iMZvHNxKb-hAA@mail.gmail.com>
 <CAKS01oncDWRS8rfyrBw2ctRSR=WX6Jyqp4=+jyRNPgpwqq_91g@mail.gmail.com>
Date: Thu, 31 Oct 2013 14:54:19 -0400
Message-ID: <CADVgf9=fV1y=_Lb3PVswajy2jTnWDyPwZyOSVBONnPyYbtYG0w@mail.gmail.com>
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

On Thu, Oct 31, 2013 at 9:36 AM, Anup Kini <akini@synapticon.com> wrote:
> Thanks a lot for correcting me Matt.
>
> I would like to confirm one more thing regarding the ipipe xenomai patch.
> which ipipe patch should i use ?
> 1 - ipipe-core-3.8.13-arm-3.patch - this is availabe in the xenomai patches
> folder.
> 2 - ipipe-core-3.8-arm-1.patch - this is availabe from
> http://download.gna.org/adeos/patches/v3.x/arm/
>
> I cross checked the two patches and there are many additions in [1] related
> to debug and other things i could not understand.

In case anyone else reading this runs into something similar-- did
removing CONFIG_CPU_FREQ solve your problem?

3.8-arm-1 is (I believe) the 3.8[.0] patch, which is what I worked
against when I last worked with Xenomai on Zynq.
3.8.13-arm-3 is what was released with Xenomai 2.6.3 (I believe), and
it may contain general ipipe related bug fixes, but I've never tested
it on Zynq so YMMV

