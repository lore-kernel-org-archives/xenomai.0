Message-ID: <535451A4.1050805@xenomai.org>
Date: Mon, 21 Apr 2014 01:00:52 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <5352BA1D.7070707@xenomai.org>
 <CADVgf9kfAGkqjmZ96cPY5gZyRLr2vAu-+5uwMEpdCBDy6+U_BQ@mail.gmail.com>
In-Reply-To: <CADVgf9kfAGkqjmZ96cPY5gZyRLr2vAu-+5uwMEpdCBDy6+U_BQ@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: Re: [Xenomai] Pre/Post patches
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

Le 20/04/2014 20:22, Matthew Fornero a écrit :
> Looks like Xilinx hasn't merged 3.14 into their tree yet. There is
> some support for Zynq in mainline, but I'm not sure how functional it
> is (I've always run from the Xilinx tree). I'm still aiming for a 3.10
> build (-pre/-post patches) sometime soon, but I've been completely out
> of bandwidth the last month or so.

The advantage of being integrated in the mainline I-pipe tree is that
from that point I handle the kernel version upgrades, which leaves you
time to do less boring and repetitive things, such as getting the Xilinx
tree patches integrated into the mainline kernel.


-- 
Gilles.

