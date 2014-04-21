MIME-Version: 1.0
Sender: mfornero@gmail.com
In-Reply-To: <535451A4.1050805@xenomai.org>
References: <5352BA1D.7070707@xenomai.org>
 <CADVgf9kfAGkqjmZ96cPY5gZyRLr2vAu-+5uwMEpdCBDy6+U_BQ@mail.gmail.com>
 <535451A4.1050805@xenomai.org>
Date: Mon, 21 Apr 2014 08:35:28 -0400
Message-ID: <CADVgf9nv3xwjs6MZFCtz7WMxs5S_HP9SLzZ54K2HwLiVHmuvWA@mail.gmail.com>
From: Matthew Fornero <mfornero.lists@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Xenomai] Pre/Post patches
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: "xenomai@xenomai.org" <xenomai@xenomai.org>

No question on the advantages of getting it into the mainline I-pipe
tree. The issue is that the current state of Linux mainline
(kernel.org) is not terribly usable on Zynq AFAIK, and Xilinx doesn't
have 3.14 in their tree yet for me to do the pre/post patching.

That being said, it's still probably worthwhile for me to try a quick
build of your tree on Zynq, just to see how close it is, though from a
quick glance it looks like some important bits will be missing (e.g.
Ethernet).

-Matt

On Sun, Apr 20, 2014 at 7:00 PM, Gilles Chanteperdrix
<gilles.chanteperdrix@xenomai.org> wrote:
> Le 20/04/2014 20:22, Matthew Fornero a =C3=A9crit :
>> Looks like Xilinx hasn't merged 3.14 into their tree yet. There is
>> some support for Zynq in mainline, but I'm not sure how functional it
>> is (I've always run from the Xilinx tree). I'm still aiming for a 3.10
>> build (-pre/-post patches) sometime soon, but I've been completely out
>> of bandwidth the last month or so.
>
> The advantage of being integrated in the mainline I-pipe tree is that
> from that point I handle the kernel version upgrades, which leaves you
> time to do less boring and repetitive things, such as getting the Xilinx
> tree patches integrated into the mainline kernel.
>
>
> --
> Gilles.

