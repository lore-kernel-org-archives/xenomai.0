MIME-Version: 1.0
In-Reply-To: <CADVgf9n6daP32wfGR+61Ko0m8q=nSD+uNe42PneJ_S5uhg7yyw@mail.gmail.com>
References: <CAKS01okfPOzCckUbe+NCfPT3fSqst2JaGpnGG8VaPCwbjvtE_Q@mail.gmail.com>
 <CADVgf9n6daP32wfGR+61Ko0m8q=nSD+uNe42PneJ_S5uhg7yyw@mail.gmail.com>
Date: Wed, 30 Oct 2013 10:25:54 +0100
Message-ID: <CAKS01om0rP3i3eAux+SC1Zt4-0-NdqOwLhg_8HQP4yjCiX2t2A@mail.gmail.com>
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

Hi Matthew,

System: Xilinx ZC702 evaluation Kit, SDK 14.5, linux-xlnx-v14.5,
u-boot-xlnx, poky-dylan, meta-xilinx-dylan

I had an problems building with zynq_remoteproc and as u suggested in
another post, i disabled it with the below patch.
I am using the xilinx_zynq_defconfig in linux-xlnx-v14.5.


--- a/arch/arm/configs/xilinx_zynq_defconfig
+++ b/arch/arm/configs/xilinx_zynq_defconfig
@@ -2220,10 +2220,10 @@ CONFIG_OF_IOMMU=y
 #
 # Remoteproc drivers (EXPERIMENTAL)
 #
-CONFIG_REMOTEPROC=m
+# CONFIG_REMOTEPROC is not set
 # CONFIG_STE_MODEM_RPROC is not set
-CONFIG_ZYNQ_REMOTEPROC=m
-CONFIG_MB_REMOTEPROC=m
+# CONFIG_ZYNQ_REMOTEPROC is not set
+# CONFIG_MB_REMOTEPROC is not set

Let me know if u need any more information.



On 29 October 2013 15:16, Matthew Fornero <mfornero.lists@gmail.com> wrote:

> On Tue, Oct 29, 2013 at 8:43 AM, Anup Kini <akini@synapticon.com> wrote:
> > Hi All,
> >
> > I am using xenomai-2.6.3 with linux-xlnx-v14.5.
> > I have patched the kernel as given in the readme (for Zynq SoC).
> >
> > My booting stops after the following messages:
> >
> >
> >    1. I-pipe: head domain Xenomai registered.
> >    2. Xenomai: hal/arm started.
> >    3. Xenomai: scheduling class idle registered.
> >    4. Xenomai: scheduling class rt registered.
> >    5. Xenomai: real-time nucleus v2.6.3 (Lies and Truths) loaded.
> >    6. Xenomai: debug mode enabled.
> >    7. Xenomai: starting native API services.
> >    8. Xenomai: starting POSIX services.
> >    9. Xenomai: starting RTDM services.
> >    10. bounce pool size: 64 pages
> >
> >
> > Pastebin link to entire bootlog: http://pastebin.com/jZTHEQU3
> >
> > <http://pastebin.com/jZTHEQU3>
> > Kindly let me know how to proceed with fixing this issue.
>
> Can you post your kernel config?
>



-- 

*Anup Kini
*Systems Engineer****
*
------------------------------
*

*Synapticon** * |  Cyber-Physical System Solutions ****

Mobile:

Direct:

+49 151 / 638 646 73

+49 7335 / 186 999 21

Fax:****
+49 7335 / 186 999 1


 **

 ****

synapticon.com <http://www.synapticon.com/>  |
@synapticon_co<https://twitter.com/#!/synapticon_co>
****

Synapticon GmbH  |  Hohlbachweg 2  |  73344 Gruibingen, DE
Secretary +49 7335 / 186 999 0  |  General Manager: Nikolai Ensslen
Registry Court Ulm HRB 725114  |  USt-ID DE271647127****

This message and any files transmitted with it are confidential and
intended
solely for the use of the individual or entity to whom they are addressed.
Please notify the sender immediately if you have received this e-mail by
mistake and delete it from your system.
