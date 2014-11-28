From: "Lennart Sorensen" <lsorense@csclub.uwaterloo.ca>
Date: Fri, 28 Nov 2014 11:21:04 -0500
Message-ID: <20141128162104.GW24110@csclub.uwaterloo.ca>
References: <20141127181823.GK7842@hermes> <547772AF.108@siemens.com>
 <20141127191438.GI24110@csclub.uwaterloo.ca>
 <20141127203400.GP7842@hermes> <54778CF6.6000909@siemens.com>
 <20141127231527.GC24076@hermes> <5478430B.9030602@siemens.com>
 <20141128095038.GA3832@hermes>
 <20141128160946.GQ24110@csclub.uwaterloo.ca>
 <5478A1B9.3020702@xenomai.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5478A1B9.3020702@xenomai.org>
Subject: Re: [Xenomai] [pull] forge: Adjust default registry mount point
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Philippe Gerum <rpm@xenomai.org>
Cc: Jan Kiszka <jan.kiszka@siemens.com>, Xenomai <xenomai@xenomai.org>

On Fri, Nov 28, 2014 at 05:24:25PM +0100, Philippe Gerum wrote:
> Let's make this a configuration variable set by a build switch, and move
> on. Looking over the trenches, I don't think there will be any consensus
> on this anyway.

Exactly.  Both /run and /var/run seem sensible, but not necesarily fully
standard at this point.

-- 
Len Sorensen

