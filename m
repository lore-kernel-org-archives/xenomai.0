From: "Lennart Sorensen" <lsorense@csclub.uwaterloo.ca>
Date: Mon, 17 Nov 2014 15:11:56 -0500
Message-ID: <20141117201155.GT24110@csclub.uwaterloo.ca>
References: <20141001142416.GA4435@csclub.uwaterloo.ca>
 <20141107182600.GS24110@csclub.uwaterloo.ca>
 <545D12D2.2020104@xenomai.org>
 <20141117191237.GS24110@csclub.uwaterloo.ca>
 <546A500A.5080004@xenomai.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <546A500A.5080004@xenomai.org>
Subject: Re: [Xenomai] I-pipe error when requesting irq that is on omap gpio
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

On Mon, Nov 17, 2014 at 08:44:10PM +0100, Philippe Gerum wrote:
> The reason to move all of these calls to lostage is that all of them may
> have to traverse regular linux code, which cannot be made I-pipe aware
> by design (e.g. PCI config code holding the big pci_lock). In such a
> case, we certainly don't want them to be called from the middle of
> nowhere linux-wise, e.g. from the real-time domain. So yes, all of them
> must be switched to lostage mode.

OK, fair enough.  I just wanted to confirm.

> This is likely a bug in the irq chip handling for these gpios lines.

Hmm, now for how to track that down.

-- 
Len Sorensen

