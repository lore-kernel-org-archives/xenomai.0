Date: Thu, 27 Nov 2014 19:18:23 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Message-ID: <20141127181823.GK7842@hermes>
References: <54775097.30705@siemens.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <54775097.30705@siemens.com>
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

On Thu, Nov 27, 2014 at 05:25:59PM +0100, Jan Kiszka wrote:
> The following changes since commit c13ff82ac09f6daa94778dcd8b51902efd754f3d:
> 
>   rtnet: update at91_ether driver (2014-11-16 20:06:04 +0100)
> 
> are available in the git repository at:
> 
>   git://git.xenomai.org/xenomai-jki.git for-forge
> 
> for you to fetch changes up to d36ae28f9c0549c0af66e896711dde21ea769587:
> 
>   regd: Switch to tmpfs as default (2014-11-27 17:19:33 +0100)

According to the filesystem hierarchy standard, /mnt is the standard
place for "temporarily mounted filesystems".

http://en.wikipedia.org/wiki/Filesystem_Hierarchy_Standard

/run is a deviation to the standard, and does not seem to be
indicated as a mount point (though debian mounts things there).

The standard equivalent of /run would be /var/run.

But why do we need to change that globally, is not this configurable?

-- 
					    Gilles.

