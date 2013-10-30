MIME-Version: 1.0
Sender: mfornero@gmail.com
In-Reply-To: <CAKS01om0rP3i3eAux+SC1Zt4-0-NdqOwLhg_8HQP4yjCiX2t2A@mail.gmail.com>
References: <CAKS01okfPOzCckUbe+NCfPT3fSqst2JaGpnGG8VaPCwbjvtE_Q@mail.gmail.com>
 <CADVgf9n6daP32wfGR+61Ko0m8q=nSD+uNe42PneJ_S5uhg7yyw@mail.gmail.com>
 <CAKS01om0rP3i3eAux+SC1Zt4-0-NdqOwLhg_8HQP4yjCiX2t2A@mail.gmail.com>
Date: Wed, 30 Oct 2013 18:15:58 -0400
Message-ID: <CADVgf9mprWu-s+1gNzhrHtXQf6d3u87P7AQ3eNd0=cdg6zWnvQ@mail.gmail.com>
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

On Wed, Oct 30, 2013 at 5:25 AM, Anup Kini <akini@synapticon.com> wrote:
>
> Hi Matthew,
>
> System: Xilinx ZC702 evaluation Kit, SDK 14.5, linux-xlnx-v14.5, u-boot-xlnx, poky-dylan, meta-xilinx-dylan
>
> I had an problems building with zynq_remoteproc and as u suggested in another post, i disabled it with the below patch.
> I am using the xilinx_zynq_defconfig in linux-xlnx-v14.5.
>
>
> --- a/arch/arm/configs/xilinx_zynq_defconfig
> +++ b/arch/arm/configs/xilinx_zynq_defconfig
> @@ -2220,10 +2220,10 @@ CONFIG_OF_IOMMU=y
>  #
>  # Remoteproc drivers (EXPERIMENTAL)
>  #
> -CONFIG_REMOTEPROC=m
> +# CONFIG_REMOTEPROC is not set
>  # CONFIG_STE_MODEM_RPROC is not set
> -CONFIG_ZYNQ_REMOTEPROC=m
> -CONFIG_MB_REMOTEPROC=m
> +# CONFIG_ZYNQ_REMOTEPROC is not set
> +# CONFIG_MB_REMOTEPROC is not set

Please post your entire kernel config. Also, please try to not
top-post, it makes it harder to follow the thread.

-Matt

