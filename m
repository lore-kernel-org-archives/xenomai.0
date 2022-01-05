Message-ID: <13d8cb9c-591d-481a-73b6-623b892deea0@siemens.com>
Date: Wed, 5 Jan 2022 15:43:26 +0100
MIME-Version: 1.0
Subject: Re: [PATCH 0/7] y2038: cond_wait_prologue64 and related fixes
Content-Language: en-US
References: <20220105140650.1033850-1-florian.bezdeka@siemens.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
In-Reply-To: <20220105140650.1033850-1-florian.bezdeka@siemens.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Florian Bezdeka <florian.bezdeka@siemens.com>, xenomai@xenomai.org

On 05.01.22 15:06, Florian Bezdeka wrote:
> Hi all,
> 
> this is the last missing POSIX related y2038 affected syscall in
> Xenomai. With this applied we have two Xenomai specific syscalls
> missing:
> 
>   - sc_cobalt_thread_setschedparam_ex
>   - sc_cobalt_thread_getschedparam_ex
> 
> While adding tests for the introduced cond_wait_prologue64 I hit a
> kernel OOPS due to insuficient validation of user provided pointers.
> That has been addressed as well.

Thanks for both! Is it possibly to move the fixes the front? That would
also ensure that I can easily pick them into stable.

Thanks,
Jan

-- 
Siemens AG, Technology
Competence Center Embedded Linux

