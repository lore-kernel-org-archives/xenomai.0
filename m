Date: Thu, 27 Nov 2014 23:39:30 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Message-ID: <20141127223930.GA24076@hermes>
References: <54775097.30705@siemens.com> <20141127181823.GK7842@hermes>
 <547772AF.108@siemens.com>
 <20141127191438.GI24110@csclub.uwaterloo.ca>
 <20141127203400.GP7842@hermes>
 <20141127214748.GJ24110@csclub.uwaterloo.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20141127214748.GJ24110@csclub.uwaterloo.ca>
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

On Thu, Nov 27, 2014 at 04:47:48PM -0500, Lennart Sorensen wrote:
> On Thu, Nov 27, 2014 at 09:34:00PM +0100, Gilles Chanteperdrix wrote:
> > I would not venture an "always", autofs for instance, used to mount
> > things under /mnt. and /media has not always existed either, we used
> > /mnt/cdrom.
> 
> Debian never touched /mnt in my experience, it used /cdrom.

Again, I would not use such definite words as "always" and "never".
I am almost sure the debian autofs package used mount points under
/mnt around woody. I can not seem to find the the .deb in the debian
archive, to check and have better things to do.


> 
> So as far as I am concerned, /mnt is _mine_, and software does not get to
> do stuff in there.

Xenomai is software that _you_ decide to run. So, if it creates
something under /mnt, it is still your doing.

-- 
					    Gilles.

