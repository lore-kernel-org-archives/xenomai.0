MIME-Version: 1.0
In-Reply-To: <0daa5cf3-7525-1e1c-a1c3-df76b66d29e5@xenomai.org>
References: <CAOocw5uUjKL5=jWd70z8nV5BbWyDxxaAtgb6+1hZaFknfbZj2w@mail.gmail.com>
 <0daa5cf3-7525-1e1c-a1c3-df76b66d29e5@xenomai.org>
From: Danrae Pray <danrae.pray@metecs.com>
Date: Thu, 2 Nov 2017 17:49:24 -0500
Message-ID: <CAOocw5uCnv_iZKzA5eMPV1rOS1Rfc0wq=bEifxofd2n=zPL1zg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Xenomai] prepare-kernel.sh error on Ubuntu 14.04
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Philippe Gerum <rpm@xenomai.org>
Cc: xenomai@xenomai.org

Just wanted to note this ipipe patch appears to have worked.  Ran into an
issue w/ visorbus driver, but wasn't sure if I needed it (
https://xenomai.org/pipermail/xenomai/2016-February/035819.html) so
disabling the UNISYS SPAR option in kernel config seems to have fixed it...

Thanks!

On Wed, Nov 1, 2017 at 3:01 PM, Philippe Gerum <rpm@xenomai.org> wrote:

> On 11/01/2017 07:13 PM, Danrae Pray wrote:
> > Hi,
> >
> > I am trying to install the COBALT kernel alongside the Ubuntu 14.04
> kernel
> > in a VirtualBox VM and have executed the following script:
> >
> > ./scripts/prepare-kernel.sh --arch=x86_64 --linux=/usr/src/linux-4.4.95
> > --ipipe=/usr/src/ipipe-core-4.4.43-x86-8.patch
> >
> > The xenomai code and ipipe patch came from the xenomai downloads site and
> > the linux distro is from kernel.org...
> >
> > Can someone please help me understand why prepare-kernel.sh is failing?
> >
>
> Because some changes which happened between mainline kernel 4.4.43 and
> 4.4.95 are conflicting with those introduced by the I-pipe patch, which
> was originally based on 4.4.43.
>
> This patch against kernel 4.4.71 is available, you may want to try it
> instead. It will still apply to 4.4.95:
>
> http://xenomai.org/downloads/ipipe/v4.x/x86/ipipe-core-4.4.71-x86-10.patch
>
> --
> Philippe.
>
