From: Richard Weinberger <richard@nod.at>
Subject: Re: [PATCH] cobalt: x86: Use ipipe_root_nr_syscalls
Date: Thu, 14 Feb 2019 16:12:35 +0100
Message-ID: <16324092.S9KuMY5lOr@blindfold>
In-Reply-To: <cf2852a2-8000-d545-4d32-fcdab5ba4522@siemens.com>
References: <cf2852a2-8000-d545-4d32-fcdab5ba4522@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Jan Kiszka <jan.kiszka@siemens.com>, Philippe Gerum <rpm@xenomai.org>
Cc: Xenomai <xenomai@xenomai.org>

Am Donnerstag, 31. Januar 2019, 18:09:53 CET schrieb Jan Kiszka:
> From: Jan Kiszka <jan.kiszka@siemens.com>
> 
> Required to handle compat syscalls correctly.
> 
> Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
> ---
> 
> This is against next. The stable patch needs to touch kernel/cobalt
> /posix/syscall.c instead.
> 
> Testing all these would be very appreciated!

Finally had time to test and review the patches.
The Problem I saw is gone. :-)

For all three patches:
Reviewed-by: Richard Weinberger <richard@nod.at>
Tested-by: Richard Weinberger <richard@nod.at>

Thanks,
//richard



