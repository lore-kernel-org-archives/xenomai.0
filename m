References: <E1bDxXW-0008Sd-Gx@sd-51317.xenomai.org>
From: Philippe Gerum <rpm@xenomai.org>
Message-ID: <b3aa8837-ec02-869a-35ba-5a27774f3f49@xenomai.org>
Date: Sat, 18 Jun 2016 15:37:05 +0200
MIME-Version: 1.0
In-Reply-To: <E1bDxXW-0008Sd-Gx@sd-51317.xenomai.org>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] [Xenomai-git] Jan Kiszka : cobalt/autotune: Rework
 autotune_ioctl_nrt/ rt for more robust request handling
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org, xenomai-git@xenomai.org

On 06/17/2016 07:26 PM, git repository hosting wrote:
> Module: xenomai-jki
> Branch: for-forge
> Commit: 3aa24e314c81d52d8d2e00ce05da9c0e18a698d2
> URL:    http://git.xenomai.org/?p=xenomai-jki.git;a=commit;h=3aa24e314c81d52d8d2e00ce05da9c0e18a698d2
> 
> Author: Jan Kiszka <jan.kiszka@siemens.com>
> Date:   Fri Jun 17 17:41:37 2016 +0200
> 
> cobalt/autotune: Rework autotune_ioctl_nrt/rt for more robust request handling
> 
> Do not trigger any activity before a correct request has been
> identified, do not copy data from user space as well. Account for races
> between parallel IOCTL calls on the same device when changing or using
> the tuner reference.
>

A better approach would be to lock out any timer-based activity while
the autotuner runs, this would include additional autotune instances by
definition. We may need a status bit in the xnclock descriptor for that,
so that we can tag the core clock accordingly.

-- 
Philippe.

