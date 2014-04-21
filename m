Message-ID: <5355A58E.8050604@xenomai.org>
Date: Tue, 22 Apr 2014 01:11:10 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <5352BA1D.7070707@xenomai.org>
 <CADVgf9kfAGkqjmZ96cPY5gZyRLr2vAu-+5uwMEpdCBDy6+U_BQ@mail.gmail.com>
 <535451A4.1050805@xenomai.org>
 <CADVgf9nv3xwjs6MZFCtz7WMxs5S_HP9SLzZ54K2HwLiVHmuvWA@mail.gmail.com>
In-Reply-To: <CADVgf9nv3xwjs6MZFCtz7WMxs5S_HP9SLzZ54K2HwLiVHmuvWA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
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

On 04/21/2014 02:35 PM, Matthew Fornero wrote:
> No question on the advantages of getting it into the mainline I-pipe
> tree. The issue is that the current state of Linux mainline
> (kernel.org) is not terribly usable on Zynq AFAIK, and Xilinx doesn't
> have 3.14 in their tree yet for me to do the pre/post patching.

My point being: it may be a more useful effort to add what is missing to
the mainline kernel (the ethernet driver for instance) from the Xilinx
tree and get Xenomai working on that kernel embryo which is bound to
evolve, than to continue generating pre and post patches for the Xilinx
tree. Vendor forks tend to become obsolete very quickly, and lack the
review of their patches by the kernel community.


-- 
                                                                Gilles.

