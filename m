Date: Thu, 27 Nov 2014 21:34:00 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Message-ID: <20141127203400.GP7842@hermes>
References: <54775097.30705@siemens.com> <20141127181823.GK7842@hermes>
 <547772AF.108@siemens.com>
 <20141127191438.GI24110@csclub.uwaterloo.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20141127191438.GI24110@csclub.uwaterloo.ca>
Subject: Re: [Xenomai] [pull] forge: Adjust default registry mount point
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Lennart Sorensen <lsorense@csclub.uwaterloo.ca>
Cc: Jan Kiszka <jan.kiszka@siemens.com>, Xenomai <xenomai@xenomai.org>

On Thu, Nov 27, 2014 at 02:14:38PM -0500, Lennart Sorensen wrote:
> On Thu, Nov 27, 2014 at 07:51:27PM +0100, Jan Kiszka wrote:
> > On 2014-11-27 19:18, Gilles Chanteperdrix wrote:
> > > According to the filesystem hierarchy standard, /mnt is the standard
> > > place for "temporarily mounted filesystems".
> > > 
> > > http://en.wikipedia.org/wiki/Filesystem_Hierarchy_Standard
> > 
> > Right, another reason to NOT mess around with it: if something was
> > temporarily mounted there, we will create the mountpoint inside that
> > filesystem with unforeseeable side effects.
> 
> I always read that as "temporarily mounted there by the admin or some
> other human".  Certainly not automatic mounts by software.  There is a
> reason /media and such exists on many distributins.

I would not venture an "always", autofs for instance, used to mount
things under /mnt. and /media has not always existed either, we used
/mnt/cdrom.

-- 
					    Gilles.

