From: "Lennart Sorensen" <lsorense@csclub.uwaterloo.ca>
Date: Wed, 10 Dec 2014 16:16:08 -0500
Message-ID: <20141210211608.GN24110@csclub.uwaterloo.ca>
References: <20141210190240.GB24110@csclub.uwaterloo.ca>
 <20141210190509.GR1524@hermes.click-hack.org>
 <20141210190939.GD24110@csclub.uwaterloo.ca>
 <20141210191350.GT1524@hermes.click-hack.org>
 <20141210191924.GF24110@csclub.uwaterloo.ca>
 <5488A2BD.3080800@xenomai.org>
 <20141210194405.GH24110@csclub.uwaterloo.ca>
 <5488A985.2070006@xenomai.org>
 <20141210201140.GL24110@csclub.uwaterloo.ca>
 <5488AF3A.8020504@xenomai.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5488AF3A.8020504@xenomai.org>
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
To: Philippe Gerum <rpm@xenomai.org>
Cc: xenomai@xenomai.org

On Wed, Dec 10, 2014 at 09:38:18PM +0100, Philippe Gerum wrote:
> GPL_ONLY is a clear statement that if somebody converts this to plain
> EXPORT_SYMBOL() in the code in order to link whatever non-GPL module, he
> is definitely and willingly violating the kernel license. This does make
> a difference.

Well given that the code isn't asking for ipipe features and is only
hitting this symbol because it is everywhere in the kernel once you
enable ipipe, then it seems excessive.

And as I found, in older ipipe versions that had most functions defined
as EXPORT_SYMBOL_GPL, this status flag was EXPORT_SYMBOL.

-- 
Len Sorensen

