Date: Tue, 16 Dec 2014 12:16:34 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Message-ID: <20141216111634.GR11058@hermes.click-hack.org>
References: <548F07F1.7010606@telecom-paristech.fr>
 <20141215161839.GO11058@hermes.click-hack.org>
 <548FDC78.5080600@telecom-paristech.fr>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <548FDC78.5080600@telecom-paristech.fr>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] I-pipe patch broken for Xilinx Zynq
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: pacalet <renaud.pacalet@telecom-paristech.fr>
Cc: xenomai@xenomai.org

On Tue, Dec 16, 2014 at 08:17:12AM +0100, pacalet wrote:
> Would you like me to post the rejects files somewhere?

No. The problem is that the ipipe-core-3.8.13-arm-4.patch (and not
-3, as I said, you should be using the latest version), as its name
indicates, is made for Linux 3.8.13, whereas the xilinx tag is based
on 3.8.0. So, the correct procedure is:

git checkout -b xenomai-test 6a0bedad
git remote add stable git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git
git fetch stable
git merge v3.8.13
patch -p1 < /path/to/ipipe-core-3.8-zynq-pre.patch
patch -p1 < /path/to/ipipe-core-3.8.13-arm-4.patch
patch -p1 < /path/to/ipipe-core-3.8-zynq-post.patch

If git fetch stable takes too long, you can use the 3.8.13 patch
from kernel.org:
https://www.kernel.org/pub/linux/kernel/v3.x/patch-3.8.13.xz

-- 
					    Gilles.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 173 bytes
Desc: not available
URL: <http://www.xenomai.org/pipermail/xenomai/attachments/20141216/dc6afce6/attachment.sig>
