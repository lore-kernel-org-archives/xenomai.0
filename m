Date: Fri, 27 May 2016 08:58:22 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Message-ID: <20160527065822.GH22660@hermes.click-hack.org>
References: <E1b6BNz-0003SF-Fa@sd-51317.xenomai.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E1b6BNz-0003SF-Fa@sd-51317.xenomai.org>
Subject: Re: [Xenomai] [Xenomai-git] Jan Kiszka : cobalt/rtdm: Fix driver
 reference counting
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

On Fri, May 27, 2016 at 08:36:43AM +0200, git repository hosting wrote:
> Module: xenomai-jki
> Branch: for-forge
> Commit: c9d83776c0ed882c71045dc32b340b57f88c5e00
> URL:    http://git.xenomai.org/?p=xenomai-jki.git;a=commit;h=c9d83776c0ed882c71045dc32b340b57f88c5e00
> 
> Author: Jan Kiszka <jan.kiszka@siemens.com>
> Date:   Fri May 27 08:32:41 2016 +0200
> 
> cobalt/rtdm: Fix driver reference counting
> 
> The rtdm smokey test triggered a BUG due to rtdm_dev_unregister not
> taking the reference counter of a driver into account. Fix this by
> moving the check into unregister_driver directly.

Did you have a look at commit
96e85548a56c8c7fbd6d64c079701483a8e5da27 ?
This looks like a revert, so since the commit was fixing something,
I believe you are reintroducting a bug.

-- 
					    Gilles.
https://click-hack.org

