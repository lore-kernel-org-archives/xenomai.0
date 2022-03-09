Date: Wed, 09 Mar 2022 18:29:03 +0000
From: Andrew <andrew.penner@protonmail.com>
Reply-To: Andrew <andrew.penner@protonmail.com>
Subject: Re: Compiling xenomai-linux 5.10.83
Message-ID: <96kUegpSbSVDQIbAaFblEwcH_ueIYUKQO9VdJ1lrYZtzP8W7UzXRQtFaz64ivafgCH8AcLHc5cYbJ-BePB_otDo6oXaQJFDc73WJFLuN-T0=@protonmail.com>
In-Reply-To: <87ley2f1f8.fsf@xenomai.org>
References: <HJ4i9nFdcaCaLnqZ6kJFqc-lsGhWGbI-ASP8PqZmkpGGD7FSSWYRIGgwLiVYMs-PiaD4SlaygjbJBCaGS8oZb3iZOS8XQzXw4kt2zzTgGyk=@protonmail.com>
 <87ley2f1f8.fsf@xenomai.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Philippe Gerum <rpm@xenomai.org>, Hongzhan Chen <hongzhan.chen@intel.com>
Cc: xenomai@xenomai.org

Hi,

Thank you for your response, Phillippe and Hongzhan, that was exactly the s=
olution I needed.

Cheers,

Andrew


------- Original Message -------

On Wednesday, February 23rd, 2022 at 08:07, Philippe Gerum <rpm@xenomai.org=
> wrote:

> Andrew via Xenomai xenomai@xenomai.org writes:
>
> > Hi,
> >
> > I am trying to work on a project that is easiest to accomplish if I bas=
e my changes on a product that is based on the mainline linux kernel 5.10.8=
3.
> >
> > I will explain the steps I took to get to the version I am interested i=
n:
> >
> > - I checkout the v5.10.y-evl-rebase branch of https://source.denx.de/Xe=
nomai/xenomai4/linux-evl.git
> >
> > - I look in Makefile to see the kernel version is at 5.10.99
> >
> > - I run make menuconfig to see what options I need to set to enable the=
 EVL kernel
> >
> > - Processor types and features ---> EVL real time core
> >
> > - I then look at git log to find the hash just before the integration o=
f 5.10.84
> >
> > - e6edaf2677939a8cf57e9152b1ab07b80f83fa11
> >
> > - I assume this would be the latest set of changes that allow xenomai t=
o work with the mainline kernel 5.10.83
> >
> > - I run make menuconfig
> >
> > - We no longer have any options (that I can see) to configure the EVL c=
ore
> >
> > Does my approach make sense to get the xenomai version that was compati=
ble with the mainline kernel 5.10.83?
>
> That won't work because this is a rebase branch, meaning that EVL sits
>
> on top of the mainline tip, therefore #e6edaf26 is below the first
>
> commit introducing the EVL code.
>
> > I understand you are all busy, but any advice/direction/web pages that =
describe what I need to do would be appreciated.
>
> There are several ways to do this, but in your case, the easiest would
>
> be to check out this tag: v5.10.83-evl1-rebase. There is no additional
>
> EVL code between v5.10.83-evl1-rebase and v5.10.99-evl1-rebase.
>
> --
>
> Philippe.

