Date: Thu, 12 May 2016 21:39:07 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Message-ID: <20160512193907.GU13285@hermes.click-hack.org>
References: <5734A9F8.10305@siemens.com>
 <20160512163142.GC18298@hermes.click-hack.org>
 <5734B43B.4040001@siemens.com>
 <20160512165904.GF18298@hermes.click-hack.org>
 <20160512171246.GG18298@hermes.click-hack.org>
 <5734BA9B.1030503@siemens.com>
 <20160512182049.GQ13285@hermes.click-hack.org>
 <5734CA76.5000606@siemens.com>
 <20160512191127.GT13285@hermes.click-hack.org>
 <5734D9F6.8030308@siemens.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5734D9F6.8030308@siemens.com>
Subject: Re: [Xenomai] RTDM syscalls & switching
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Jan Kiszka <jan.kiszka@siemens.com>
Cc: Xenomai <xenomai@xenomai.org>

On Thu, May 12, 2016 at 09:31:02PM +0200, Jan Kiszka wrote:
> >> Now tell me how many drivers have read_nrt, write_nrt? 1 in-tree.
> >> recvmsg_nrt, sendmsg_nrt? 0 in-tree. Analogy is special (still like to
> >> understand why, though). And having some special code in the exceptional
> >> case is probably better then the side effects we get from eagerly
> >> switching now.
> > 
> > 
> > Analogy is special, but is in-tree. How many in-tree drivers
> > require an nrt handler that does not switch back to primary mode?
> 
> That is not an argument because Xenomai never designed its APIs only for
> in-tree usage.

You were the one who restricted the discussion to in-tree drivers.
See the quoted part above. I will stop answering this thread now,
and let you discuss the issue with Philippe.

-- 
					    Gilles.
https://click-hack.org

