Date: Thu, 8 Jan 2015 19:24:28 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Message-ID: <20150108182428.GB25375@hermes.click-hack.org>
References: <E1Y9Fya-0004NM-Fe@sd-51317.xenomai.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E1Y9Fya-0004NM-Fe@sd-51317.xenomai.org>
Subject: Re: [Xenomai] [Xenomai-git] Jan Kiszka : copperplate/registry:
 Switch to /var/ run as default mountpoint root
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org
Cc: xenomai-git@xenomai.org

On Thu, Jan 08, 2015 at 05:30:24PM +0100, git repository hosting wrote:
> Module: xenomai-jki
> Branch: for-forge
> Commit: 90dfc3fa9bc324b587832247a82d02412391e95a
> URL:    http://git.xenomai.org/?p=xenomai-jki.git;a=commit;h=90dfc3fa9bc324b587832247a82d02412391e95a
> 
> Author: Jan Kiszka <jan.kiszka@siemens.com>
> Date:   Thu Nov 27 16:47:13 2014 +0100
> 
> copperplate/registry: Switch to /var/run as default mountpoint root
> 
> Creating directories in a user/admin-owned and typically persistent
> filesystem for the purpose of mounting volatile filesystems on top is
> a suboptimal default. Today /run should be used for such purposes, but
> older distros may only expose the current FHS standard /var/run. So use
> that instead.
> 
> This comes with the advantage that we will now typically work against
> tmpfs, thus won't stumble if / is read-only.

Please stop reusing that argument: those users which have root
mounted read-only know what they are doing, and are able to create
the /mnt/xenomai mount point and mount a tmpfs themselves. The average
clueless user does not use a read-only filesystem. So, in the end,
this is a non-issue.

-- 
					    Gilles.

