MIME-Version: 1.0
References: <CAF_6MazWZnuJ3v4XjLLfAWMxrgSKsE2qt_60LLp0ifkC=fqoAQ@mail.gmail.com>
 <5a43908e-817b-bcbc-867d-7284fa07e9fc@siemens.com>
 <CAF_6MazHN=cvjh+J_oQbpxp1dfcGcxwST=r2uQF9MtJ0Pw3oFA@mail.gmail.com>
 <MWHPR11MB191871C53075347DAB3E78B4EE270@MWHPR11MB1918.namprd11.prod.outlook.com>
In-Reply-To: <MWHPR11MB191871C53075347DAB3E78B4EE270@MWHPR11MB1918.namprd11.prod.outlook.com>
From: gopi ratnakaram <gopi.ratnakaram@svayarobotics.com>
Date: Thu, 10 Sep 2020 14:11:04 +0530
Message-ID: <CAF_6Max4Cc_x9JafnZPw_U5DgtD-mEcE3B2buripo4xj5whrqA@mail.gmail.com>
Subject: Re: Regarding SMBus
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: "Meng, Fino" <fino.meng@intel.com>
Cc: "Xenomai (xenomai@xenomai.org)" <xenomai@xenomai.org>

Hi Fino,

Firstly, I would like to confirm that 4.19.59 without RT patching I am not
finding any issue with SMBus locking as I have tested it just some time
back.

As per your inputs I have few queries,

If u are using this kernel, a quick try is use acrn_defconfig instead of
xenomai_test_defconfig.
It is the defconfig using by ACRN team:
https://github.com/intel/linux-stable-xenomai/blob/F/4.19.59/base/ipipe/xen=
omai_3.1/arch/x86/configs/acrn_defconfig

*Question: Do I need to change configure file and reinstall again? Please
provide me with any supporting documents available?*

--best regards,
R Gopi Krishna,
Svaya Robotics Pvt., Ltd.,
Hyderabad, India.
T: +91 40 2354 6019
F: +91 40 2354 7901


*DISCLAIMER  :This e-mail and any files transmitted with it may contain
privileged, undisclosed, or otherwise confidential information of Svaya
Robotics Pvt. Ltd., and are intended solely for the use of the individual
or entity to whom they are addressed, shall be maintained in confidence and
not disclosed to third parties without the written consent of the sender.
If you have received this E-mail in error, you are hereby notified that any
review, copying, printing or distribution of it is strictly prohibited.
Please immediately notify the sender by return e-mail  and destroy the
original transmittal. Thank you for your cooperation.*


On Thu, Sep 10, 2020 at 11:19 AM Meng, Fino <fino.meng@intel.com> wrote:

>
> >Sent: Wednesday, September 9, 2020 6:20 PM
> >
> >Yes, the motherboard manufacturer has shared the bus with other devices
> too. I didn't change any kernel configuration with
> >respect to xenomai, but the issue was not there in 4.15.0 which is not R=
T
> patched where I am not getting this kind of issue.
> >But, this only happened in 4.19.59 xenomai patched kernel. Is there any
> interrupt related configuration change in kernel
> >configuration can resolve this issue, please let me know.
>
> If u are using this kernel, a quick try is use acrn_defconfig instead of
> xenomai_test_defconfig.
> It is the defconfig using by ACRN team:
>
> https://github.com/intel/linux-stable-xenomai/blob/F/4.19.59/base/ipipe/x=
enomai_3.1/arch/x86/configs/acrn_defconfig
>
> xenomai_test_defconfig was originally from Yocto, not optimized for PC.
> We are struggling for a good way to make proper defconfig,
> but it's really hard work due to kernel config are more than 8000 lines
> already.
>
>
> BR / Fino (=E5=AD=9F=E7=A5=A5=E5=A4=AB)
> Intel =E2=80=93 IOTG Developer Enabling
>
>
> >
> >--best regards,
> >R Gopi Krishna,
> >Svaya Robotics Pvt., Ltd.,
> >Hyderabad, India.
> >T: +91 40 2354 6019
> >F: +91 40 2354 7901
> >
> >
> >*DISCLAIMER  :This e-mail and any files transmitted with it may contain
> privileged, undisclosed, or otherwise confidential
> >information of Svaya Robotics Pvt. Ltd., and are intended solely for the
> use of the individual or entity to whom they are
> >addressed, shall be maintained in confidence and not disclosed to third
> parties without the written consent of the sender.
> >If you have received this E-mail in error, you are hereby notified that
> any review, copying, printing or distribution of it is
> >strictly prohibited.
> >Please immediately notify the sender by return e-mail  and destroy the
> original transmittal. Thank you for your
> >cooperation.*
> >
> >
> >On Wed, Sep 9, 2020 at 1:32 PM Jan Kiszka <jan.kiszka@siemens.com> wrote=
:
> >
> >> On 09.09.20 07:23, gopi ratnakaram via Xenomai wrote:
> >> > Team,
> >> >
> >> > I am working with xenomai patched with kernel 4.19.59 on an
> >> > Industrial motherboard which has an SMBus. After patching during my
> >> > testing it was observed that the SMbus got some issues and the bus
> >> > is locking
> >> immediately
> >> > after running my application and the error log is as follows. But,
> >> > when I run my SMbus based application in the kernel 4.15.0 without
> >> > RT patching
> >> it
> >> > was working fine. Is there any configuration setting while patching
> >> xenomai
> >> > is causing this issue?
> >> >
> >> > --best regards,
> >> > R Gopi Krishna,
> >> > Svaya Robotics Pvt., Ltd.,
> >> > Hyderabad, India.
> >> > T: +91 40 2354 6019
> >> > F: +91 40 2354 7901
> >> >
> >> >
> >> > *DISCLAIMER  :This e-mail and any files transmitted with it may
> >> > contain privileged, undisclosed, or otherwise confidential
> >> > information of Svaya Robotics Pvt. Ltd., and are intended solely for
> >> > the use of the individual or entity to whom they are addressed,
> >> > shall be maintained in confidence
> >> and
> >> > not disclosed to third parties without the written consent of the
> sender.
> >> > If you have received this E-mail in error, you are hereby notified
> >> > that
> >> any
> >> > review, copying, printing or distribution of it is strictly
> prohibited.
> >> > Please immediately notify the sender by return e-mail  and destroy
> >> > the original transmittal. Thank you for your cooperation.*
> >> > -------------- next part --------------
> >> > [    1.291726] i801_smbus 0000:00:1f.4: SPD Write Disable is set
> >> > [    1.291801] i801_smbus 0000:00:1f.4: SMBus using PCI interrupt
> >> > [  366.625686] i801_smbus 0000:00:1f.4: Timeout waiting for interrup=
t!
> >>
> >> The Linux interrupt is not making it through. Is it shared with
> >> another device that happens to be managed by an RTDM driver? Does the
> >> issue disappear when keeping the kernel version, just turning of
> >> Xenomai and I-pipe in the kernel configuration?
> >>
> >> Jan
> >>
> >> --
> >> Siemens AG, Corporate Technology, CT RDA IOT SES-DE Corporate
> >> Competence Center Embedded Linux
> >>
>
