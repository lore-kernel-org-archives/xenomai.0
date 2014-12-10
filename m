From: "Lennart Sorensen" <lsorense@csclub.uwaterloo.ca>
Date: Wed, 10 Dec 2014 17:01:29 -0500
Message-ID: <20141210220129.GP24110@csclub.uwaterloo.ca>
References: <20141210190509.GR1524@hermes.click-hack.org>
 <20141210190939.GD24110@csclub.uwaterloo.ca>
 <20141210191350.GT1524@hermes.click-hack.org>
 <20141210191924.GF24110@csclub.uwaterloo.ca>
 <5488A2BD.3080800@xenomai.org>
 <20141210194405.GH24110@csclub.uwaterloo.ca>
 <5488A985.2070006@xenomai.org>
 <20141210201140.GL24110@csclub.uwaterloo.ca>
 <20141210212342.GO24110@csclub.uwaterloo.ca>
 <5488C149.8020901@nta-inc.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5488C149.8020901@nta-inc.net>
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
To: Jeff Webb <jeff.webb@nta-inc.net>
Cc: xenomai@xenomai.org

On Wed, Dec 10, 2014 at 03:55:21PM -0600, Jeff Webb wrote:
> I can confirm that this is around the time I started having trouble with the proprietary nvidia module.  In the linux 2.6.?? days, I didn't experience that issue.  It is obviously up to the authors to decide whether or not it is desirable to allow proprietary modules to continue to operate on an I-pipe patched kernel as they do an un-patched kernel.  Since the issue was raised, I thought I would report my experience in case there is a desire to get this configuration working again.

Well certainly I do agree with Gilles that if there is a binary blob,
you can not know if it is going to mess directly with interrupts and
break ipipe, so the nvidia driver could be a problem (hard to know).

Of course if you have source code and are compiling the module yourself
then that part should not be a problem.  I wonder if a BSD licenced
module would even compile with an ipipe enabled kernel
right now assuming any such thing exists (other than
./Documentation/blackfin/gptimers-example.c:MODULE_LICENSE("BSD");
that I spotted).

-- 
Len Sorensen

