References: <E1daPAo-00086l-G6@xenomai.org>
From: Philippe Gerum <rpm@xenomai.org>
Message-ID: <b0711523-af3a-b8f3-d053-f9565d66c86e@xenomai.org>
Date: Wed, 26 Jul 2017 19:02:02 +0200
MIME-Version: 1.0
In-Reply-To: <E1daPAo-00086l-G6@xenomai.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] [Xenomai-git] Jan Kiszka : cobalt/syscall: Filter out
 invalid Linux syscalls
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org, xenomai-git@xenomai.org

On 07/26/2017 06:28 PM, git repository hosting wrote:
> Module: xenomai-jki
> Branch: for-forge
> Commit: 92fadda472ad755db2d7b9443d3b2108a35e5d14
> URL:    http://git.xenomai.org/?p=xenomai-jki.git;a=commit;h=92fadda472ad755db2d7b9443d3b2108a35e5d14
> 
> Author: Jan Kiszka <jan.kiszka@siemens.com>
> Date:   Mon Jul 24 14:22:29 2017 +0200
> 
> cobalt/syscall: Filter out invalid Linux syscalls
> 
> Suggested by Philippe Gerum: Instead of propagating them down the
> pipeline, triggering a XENO_BUG_ON in ipipe_fastcall_hook, catch invalid
> Linux syscalls early and terminate them immediately.
> 

I'm holding this one for now, this requires further investigation; a
syscall unexpectedly triggers this guard in the ARM port.

-- 
Philippe.

