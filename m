MIME-Version: 1.0
Sender: mfornero@gmail.com
In-Reply-To: <5352BA1D.7070707@xenomai.org>
References: <5352BA1D.7070707@xenomai.org>
Date: Sun, 20 Apr 2014 14:22:46 -0400
Message-ID: <CADVgf9kfAGkqjmZ96cPY5gZyRLr2vAu-+5uwMEpdCBDy6+U_BQ@mail.gmail.com>
From: Matthew Fornero <mfornero.lists@gmail.com>
Content-Type: text/plain; charset=UTF-8
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

Looks like Xilinx hasn't merged 3.14 into their tree yet. There is
some support for Zynq in mainline, but I'm not sure how functional it
is (I've always run from the Xilinx tree). I'm still aiming for a 3.10
build (-pre/-post patches) sometime soon, but I've been completely out
of bandwidth the last month or so.

-Matt

On Sat, Apr 19, 2014 at 2:02 PM, Gilles Chanteperdrix
<gilles.chanteperdrix@xenomai.org> wrote:
>
> Hi all,
>
> I am currently validating the I-pipe patch for Linux 3.14 on armv4 and
> armv5, but it should already work for armv6 and armv7 processors, it is
> available as a branch for-ipipe-3.14.0 in ipipe-gch git. Could you have
> a look at it on BeagleBone, Raspberry and Zynq? For the SOCs supported
> by mainline, please simply send patches to the for-ipipe-3.14.0 branch.
>
> Regards.
>
> --
> Gilles.

