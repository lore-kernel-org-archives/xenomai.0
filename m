MIME-Version: 1.0
References: <CAF_6MazWZnuJ3v4XjLLfAWMxrgSKsE2qt_60LLp0ifkC=fqoAQ@mail.gmail.com>
 <5a43908e-817b-bcbc-867d-7284fa07e9fc@siemens.com>
In-Reply-To: <5a43908e-817b-bcbc-867d-7284fa07e9fc@siemens.com>
From: gopi ratnakaram <gopi.ratnakaram@svayarobotics.com>
Date: Wed, 9 Sep 2020 15:50:14 +0530
Message-ID: <CAF_6MazHN=cvjh+J_oQbpxp1dfcGcxwST=r2uQF9MtJ0Pw3oFA@mail.gmail.com>
Subject: Re: Regarding SMBus
Content-Type: text/plain; charset="UTF-8"
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Jan Kiszka <jan.kiszka@siemens.com>
Cc: "Xenomai@xenomai.org" <xenomai@xenomai.org>

Yes, the motherboard manufacturer has shared the bus with other devices
too. I didn't change any kernel configuration with respect to xenomai, but
the issue was not there in 4.15.0 which is not RT patched where I am not
getting this kind of issue. But, this only happened in 4.19.59 xenomai
patched kernel. Is there any interrupt related configuration change in
kernel configuration can resolve this issue, please let me know.

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


On Wed, Sep 9, 2020 at 1:32 PM Jan Kiszka <jan.kiszka@siemens.com> wrote:

> On 09.09.20 07:23, gopi ratnakaram via Xenomai wrote:
> > Team,
> >
> > I am working with xenomai patched with kernel 4.19.59 on an Industrial
> > motherboard which has an SMBus. After patching during my testing it was
> > observed that the SMbus got some issues and the bus is locking
> immediately
> > after running my application and the error log is as follows. But, when I
> > run my SMbus based application in the kernel 4.15.0 without RT patching
> it
> > was working fine. Is there any configuration setting while patching
> xenomai
> > is causing this issue?
> >
> > --best regards,
> > R Gopi Krishna,
> > Svaya Robotics Pvt., Ltd.,
> > Hyderabad, India.
> > T: +91 40 2354 6019
> > F: +91 40 2354 7901
> >
> >
> > *DISCLAIMER  :This e-mail and any files transmitted with it may contain
> > privileged, undisclosed, or otherwise confidential information of Svaya
> > Robotics Pvt. Ltd., and are intended solely for the use of the individual
> > or entity to whom they are addressed, shall be maintained in confidence
> and
> > not disclosed to third parties without the written consent of the sender.
> > If you have received this E-mail in error, you are hereby notified that
> any
> > review, copying, printing or distribution of it is strictly prohibited.
> > Please immediately notify the sender by return e-mail  and destroy the
> > original transmittal. Thank you for your cooperation.*
> > -------------- next part --------------
> > [    1.291726] i801_smbus 0000:00:1f.4: SPD Write Disable is set
> > [    1.291801] i801_smbus 0000:00:1f.4: SMBus using PCI interrupt
> > [  366.625686] i801_smbus 0000:00:1f.4: Timeout waiting for interrupt!
>
> The Linux interrupt is not making it through. Is it shared with another
> device that happens to be managed by an RTDM driver? Does the issue
> disappear when keeping the kernel version, just turning of Xenomai and
> I-pipe in the kernel configuration?
>
> Jan
>
> --
> Siemens AG, Corporate Technology, CT RDA IOT SES-DE
> Corporate Competence Center Embedded Linux
>
