From: Fabian <fabian.hartl@avl.com>
Date: Wed, 26 Aug 2015 11:03:33 +0000 (UTC)
Message-ID: <loom.20150826T125226-959@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Subject: [Xenomai] unable to patch kernel
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

Hi,

I am trying to patch a beaglebone black debian arm kernel with the xenomai 3
kernel for dual kernel mode (cobalt).

I used the debian kernel v3.14.39 and the ipipe-core 3.14.39-arm-9.patch,
because this seems to be the newest matching combination. but when i start
the patching it tells me:

prepare-kernel.sh: Unable to patch kernel 3.14.39 with
ipipe-core3.14.39-arm-9.patch

I also tried other kernel and ipipe versions combinations but with the same
result.

I got the debian-kernel from this git: https://github.com/beagleboard/linux.git 

and the xenomai-kernel from here: https://git.xenomai.org/xenomai-3.git


Unfortunately i have not found an instruction how to do this with the new
xenomai version 3, only version 2.6 is described in the net.


Thanks in advance 

Regards


