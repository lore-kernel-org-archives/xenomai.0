MIME-Version: 1.0
In-Reply-To: <20160502172745.GH2055@csclub.uwaterloo.ca>
References: <CAHoW4hE=sh9dL_+LpCmO8qKhzfnMYQbu9Yx-2jf+6Cu4gDFUrg@mail.gmail.com>
 <20160502172745.GH2055@csclub.uwaterloo.ca>
Date: Thu, 5 May 2016 10:54:27 -0400
Message-ID: <CAHoW4hFb+NBJ_qatDnDX6cjRw-qtb5_NGUaW_yELhpkO=uEigQ@mail.gmail.com>
From: Charles Kiorpes <ckiorpes@gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Xenomai] i-pipe patched 4.1.18 fails to boot on
 BeagleBoard-x15 (AM5728 processor)
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Lennart Sorensen <lsorense@csclub.uwaterloo.ca>
Cc: xenomai@xenomai.org

On Mon, May 2, 2016 at 1:27 PM, Lennart Sorensen <
lsorense@csclub.uwaterloo.ca> wrote:

> On Wed, Apr 13, 2016 at 02:04:16PM -0400, Charles Kiorpes wrote:
> > Hello,
> >
> > I have been trying to bring up a Rev A2 BeagleBoard-x15 with i-pipe, in
> > order to test Xenomai co-kernel functionality on this board.
> >
> > I have verified that the kernel configuration settings that I'm using
> > create a bootable mainline 4.1.18 kernel.
> >
> > Once I patch the 4.1.18 kernel with ipipe-core-4.1.18-arm-4.patch, and
> make
> > the same configuration changes, I am unable to boot the resulting kernel.
> >
> > I have attached my kernel config and the kernel output from a failed
> boot.
> >
> > The first major error (aside from some lock debug printouts) occurs at
> > 2.141340, when the kernel attempts to dereference a NULL pointer.
> > It appears that the problem is related to the PALMAS driver, but I am not
> > well-versed in kernel development and don't know how to proceed.
> >
> > What steps can I take to better debug and eventually correct the problem?
>
> I just sent a patch to the mailing list that seems to make the
> irq-crossbar work in 4.1 with ipipe.  I got a NULL pointer dereference
> in that.  This probably did not exist in 3.14 which is why I had not
> seen it before.
>
> --
> MLen Sorensen
>

I can confirm that your submitted patch fixes the NULL pointer dereference
I was seeing.  I can now run Xenomai 3 "next" from the git repo over top of
the 4.1.18 kernel.

Thank you!
-Charles
