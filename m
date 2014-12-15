Date: Mon, 15 Dec 2014 17:18:39 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Message-ID: <20141215161839.GO11058@hermes.click-hack.org>
References: <548F07F1.7010606@telecom-paristech.fr>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <548F07F1.7010606@telecom-paristech.fr>
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
To: Renaud Pacalet <renaud.pacalet@telecom-paristech.fr>
Cc: xenomai@xenomai.org

On Mon, Dec 15, 2014 at 05:10:25PM +0100, Renaud Pacalet wrote:
> Dear Xenomai developers,
> 
> I ran into troubles when trying to follow the instructions at
> http://www.wiki.xilinx.com/Xenomai+for+Zynq: the
> xenomai-2.6.3/ksrc/arch/arm/patches/ipipe-core-3.8.13-arm-1.patch
> patch mentioned in the instructions is no longer the one distributed
> in http://download.gna.org/xenomai/stable/xenomai-2.6.3.tar.bz2. It
> has been replaced by ipipe-core-3.8.13-arm-3.patch patch which is not
> compatible with the xilinx-v14.5 tag of
> git://github.com/Xilinx/linux-xlnx.git. In order to patch and compile
> the compile Linux kernel I had to download and apply
> http://download.gna.org/adeos/patches/v3.x/arm/older/ipipe-core-3.8-arm-1.patch
> instead.

Bad idea, using the latest I-pipe patch for a kernel is recommended,
a newer release means some things were fixed. For the same reason,
using xenomai 2.6.3 is not recommended.

Maybe you could show us the errors you get?

-- 
					    Gilles.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 173 bytes
Desc: not available
URL: <http://www.xenomai.org/pipermail/xenomai/attachments/20141215/8877ba4f/attachment.sig>
