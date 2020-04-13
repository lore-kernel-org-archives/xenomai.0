MIME-Version: 1.0
References: <CAAvDm6bFOv=0_9kcX5BUtPYs3dRh-aVc7XARY7BtDo5Pu4Mz-Q@mail.gmail.com>
 <d79fdc312b654a7ebf31e90d23a1d74b@intel.com>
In-Reply-To: <d79fdc312b654a7ebf31e90d23a1d74b@intel.com>
From: =?UTF-8?B?5a2Z5LiW6b6Z?= <sunshilong369@gmail.com>
Date: Mon, 13 Apr 2020 17:07:42 +0800
Message-ID: <CAAvDm6Y0Z4gGRVakze-1pANM62pxZ8VkQphSET8FM5deHU1YnA@mail.gmail.com>
Subject: Re: How could I allocate a huge memory in rtdm driver?
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
Cc: Xenomai <xenomai@xenomai.org>

Hi Meng,

    Thanks a lot for your reply.
     I will follow your advice not to throw out multi questions at once
any more.

     I have some industry PCs in hand which allready installed xenoami. I
use vmware to verify my code.
     It's more convenient to use word etc on windows while ubuntu installed
in vmwareis used for coding.

     The huge memory to be allocated will be used to store high
definitionvideo to be processed later .Though many image
processing algorithmsrequire contiguous memory, I do not need
contiguous memory indeed.

     Best regards.
Meng, Fino <fino.meng@intel.com> =E4=BA=8E2020=E5=B9=B44=E6=9C=8813=E6=97=
=A5=E5=91=A8=E4=B8=80 =E4=B8=8B=E5=8D=884:19=E5=86=99=E9=81=93=EF=BC=9A

>
>
> > From: Xenomai <xenomai-bounces@xenomai.org> On Behalf Of ??? via
> > Xenomai
> > Sent: Monday, April 13, 2020 3:21 PM
> > To: xenomai <xenomai@xenomai.org>
> > Subject: How could I allocate a huge memory in rtdm driver?
> >
> > Hi,
> >      I am using xenomai 3.1.
> >
> >      How could I allocate a huge memory which may be larger then 50MB i=
n
> > rtdm driver?
> >
> >      I have tried rtdm_malloc function,but it returns NULL.
> >
> >     To provide the operating system a large amount of free memory, I do
> this
> > test when the ubuntu is started at once in vmware.
> >
> >     Best regards.
>
> Hi Shilong,
>
> Which kind of application u want to do? If u throw out multi questions at
> once, we may hard to catch,
> Run a ubuntu in vmware cannot get correct real-time performance,
> And a normal PC mainboard's BIOS usually cannot match real-time profile
> also.
> we can recommend some Industry PC module available on market if u want to
> test,
>
> BR / Fino (=E5=AD=9F=E7=A5=A5=E5=A4=AB)
> Intel =E2=80=93 IOTG Developer Enabling
>
