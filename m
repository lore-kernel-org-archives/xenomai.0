From: "Lennart Sorensen" <lsorense@csclub.uwaterloo.ca>
Date: Thu, 27 Nov 2014 14:14:38 -0500
Message-ID: <20141127191438.GI24110@csclub.uwaterloo.ca>
References: <54775097.30705@siemens.com> <20141127181823.GK7842@hermes>
 <547772AF.108@siemens.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <547772AF.108@siemens.com>
Subject: Re: [Xenomai] [pull] forge: Adjust default registry mount point
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Jan Kiszka <jan.kiszka@siemens.com>
Cc: Xenomai <xenomai@xenomai.org>

On Thu, Nov 27, 2014 at 07:51:27PM +0100, Jan Kiszka wrote:
> On 2014-11-27 19:18, Gilles Chanteperdrix wrote:
> > According to the filesystem hierarchy standard, /mnt is the standard
> > place for "temporarily mounted filesystems".
> > 
> > http://en.wikipedia.org/wiki/Filesystem_Hierarchy_Standard
> 
> Right, another reason to NOT mess around with it: if something was
> temporarily mounted there, we will create the mountpoint inside that
> filesystem with unforeseeable side effects.

I always read that as "temporarily mounted there by the admin or some
other human".  Certainly not automatic mounts by software.  There is a
reason /media and such exists on many distributins.

-- 
Len Sorensen

