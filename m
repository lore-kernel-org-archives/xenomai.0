MIME-Version: 1.0
Sender: mfornero@gmail.com
In-Reply-To: <CAKS01o=wnSbj655XshMKCmiSL4xD=Zm7FeD7j7qn9M5_YD4j6g@mail.gmail.com>
References: <CAKS01okfPOzCckUbe+NCfPT3fSqst2JaGpnGG8VaPCwbjvtE_Q@mail.gmail.com>
 <CADVgf9n6daP32wfGR+61Ko0m8q=nSD+uNe42PneJ_S5uhg7yyw@mail.gmail.com>
 <CAKS01om0rP3i3eAux+SC1Zt4-0-NdqOwLhg_8HQP4yjCiX2t2A@mail.gmail.com>
 <CADVgf9mprWu-s+1gNzhrHtXQf6d3u87P7AQ3eNd0=cdg6zWnvQ@mail.gmail.com>
 <CAKS01okXjCV9v6vJ9W8UoqJ6d57h1rQvkPSbGOUugc5gymhyjg@mail.gmail.com>
 <CADVgf9kPw+q77x30UU=bRiZ039NsKd+83Mdv2iMZvHNxKb-hAA@mail.gmail.com>
 <CAKS01oncDWRS8rfyrBw2ctRSR=WX6Jyqp4=+jyRNPgpwqq_91g@mail.gmail.com>
 <CADVgf9=fV1y=_Lb3PVswajy2jTnWDyPwZyOSVBONnPyYbtYG0w@mail.gmail.com>
 <CAKS01o=pMH3T=_QqhD4a-nm5KMma2+0cepS0tVeRnqubnJ2gBg@mail.gmail.com>
 <CADVgf9kpqkGJyyFoQCyOMy5xi2UvMLKo6DXG8jd=_f5ugZ7PSQ@mail.gmail.com>
 <CAKS01o=wnSbj655XshMKCmiSL4xD=Zm7FeD7j7qn9M5_YD4j6g@mail.gmail.com>
Date: Tue, 12 Nov 2013 15:43:27 -0500
Message-ID: <CADVgf9mHcA+sf=qg4XuuWEzNQLeXhKv-Jf0grmYBOg8k1V9rPg@mail.gmail.com>
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

On Mon, Nov 4, 2013 at 9:53 AM, Anup Kini <akini@synapticon.com> wrote:
>
> Hi All,
>
> I was able to fix the issues and build a kernel successfully.
> I have created a github repository with the patches, including ipipe_zynq_pre, ipipe_arm_3.8.13, ipipe_zynq_post and the xilinx_zynq_defconfig related CPU_HOTPLUG and REMOTEPROC.
>
> Repository: https://github.com/synapticon/linux-xlnx.git
> branch: xlnx_3.8
>
> Steps i followed to build:
> - clone the repository, checkout the branch- xlnx_3.8
> - Download and extract Xenomai 2.6.3.
> - prepare_kernel.sh --arch=arm --linux=/patch/to/above/repo
> ---- specific to ZYNQ board ----
> - Change to above repo, make xilinx_zynq_defconfig
> - make uImage LOADADDR=0x00008000
> - make modules
>

Hi All,

I updated my github repo in a similar way, but used git merge to pull
in the changes from the ipipe tree. This should maintain the history,
and allow for easy merging of future changes

https://github.com/mfornero/ipipe.git

the zynq-ipipe-3.8 branch contains the ipipe-core-3.8 code.
this branch includes a xenomai_zynq_defconfig for use

I tagged the state of Xilinx v14.5 + Zynq Pre + ipipe-core-3.8-arm-1 +
Zynq Post as "ipipe-core-3.8-zynq-1"
I tagged the state of  ipipe-core-3.8-zynq-1 + a merge of
ipipe-core-3.8-arm-3 as "ipipe-core-3.8-zynq-3"

I've done some lite testing (latency and xeno-test) of
ipipe-core-3.8-zynq-3 on ZC702, and found no issues thus far.
I'll try to find some time shortly to regenerate the -pre and -post patches.

-Matt

