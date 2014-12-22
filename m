From: "Lennart Sorensen" <lsorense@csclub.uwaterloo.ca>
Date: Mon, 22 Dec 2014 09:42:25 -0500
Message-ID: <20141222144225.GI24110@csclub.uwaterloo.ca>
References: <20141210184232.GP1524@hermes.click-hack.org>
 <20141210190240.GB24110@csclub.uwaterloo.ca>
 <20141210190509.GR1524@hermes.click-hack.org>
 <20141210190939.GD24110@csclub.uwaterloo.ca>
 <20141210191350.GT1524@hermes.click-hack.org>
 <20141210191924.GF24110@csclub.uwaterloo.ca>
 <5488A2BD.3080800@xenomai.org>
 <20141210194405.GH24110@csclub.uwaterloo.ca>
 <5488A985.2070006@xenomai.org> <5497ED3D.9010304@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5497ED3D.9010304@web.de>
Subject: Re: [Xenomai] __ipipe_root_status exported GPL only but used to be
 not GPL only and is breaking other code
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Jan Kiszka <jan.kiszka@web.de>
Cc: xenomai@xenomai.org

On Mon, Dec 22, 2014 at 11:06:53AM +0100, Jan Kiszka wrote:
> Lennart, are you on x86 and do you have CONFIG_CMP disabled? Then
> __ipipe_root_status gets pulled in via arch_local_irq_disable ->
> ipipe_stall_root. If that is the problem, I think it's more than
> reasonable to argue that effectively making local_irq_disable GPL-only
> would be an unwanted restriction over mainline.

This is on powerpc.  So far we use xenomai on powerpc and arm, but
not x86.  And SMP is disabled since it is a single core MPC8360e.

-- 
Len Sorensen

