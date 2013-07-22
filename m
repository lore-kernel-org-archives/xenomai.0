From: "Lennart Sorensen" <lsorense@csclub.uwaterloo.ca>
Date: Mon, 22 Jul 2013 12:57:43 -0400
Message-ID: <20130722165743.GA11325@csclub.uwaterloo.ca>
References: <001c01ce86ef$ce0d0ab0$6a272010$@ovi.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <001c01ce86ef$ce0d0ab0$6a272010$@ovi.com>
Subject: Re: [Xenomai] Xenomai for Zynq
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Kari Kumpulainen <k_olavi@ovi.com>
Cc: xenomai@xenomai.org

On Mon, Jul 22, 2013 at 06:26:14PM +0300, Kari Kumpulainen wrote:
> Which kernel and Xenomai versions should I use if I want to build Xenomai
> support for a Zynq (Xilinx) chip?
> I tried to patch the 3.5 kernel provided by Xilinx, but patching failed
> because of conflicts in some files.

I believe satndard practice is:

Get the kernel.org kernel with the version xenomai has a patch for,
then apply the xenomai patch, then add any extra patches needed for your
system, fixing any conflicts and issues that come up.

-- 
Len Sorensen

