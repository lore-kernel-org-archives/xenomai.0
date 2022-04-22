MIME-Version: 1.0
References: <56fd561b25857e45232c952f6ef4a7a4@cweb010.nm.nfra.io>
 <CAFLxGvwn1j+6MJFRWVfwTvR=6S6H3fKW8hHGoY5AdevyitHCsQ@mail.gmail.com>
 <82ef88bc2e32fa37af5cb992be6a293@cweb012.nm.nfra.io>
In-Reply-To: <82ef88bc2e32fa37af5cb992be6a293@cweb012.nm.nfra.io>
From: Richard Weinberger <richard.weinberger@gmail.com>
Date: Fri, 22 Apr 2022 09:54:02 +0200
Message-ID: <CAFLxGvz=4qOL3-A_wT00Oq7YO6SPZwbce5LZazmEirJDEW3S_w@mail.gmail.com>
Subject: Re: Difference between rt_task, pthread and xnthread in Xenomai 3
Content-Type: text/plain; charset="UTF-8"
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Jae Hyun Park <parkjahun42@naver.com>
Cc: Xenomai <xenomai@xenomai.org>

On Fri, Apr 22, 2022 at 5:02 AM Jae Hyun Park <parkjahun42@naver.com> wrote:
> Then can I understand that tasks made with rt_task_create work similarly to multi-threading?
>
> And I wonder if there is any difference in real-time guarantee performance between pthread
>
> of posix skin and xnthread of realtime thread of xenomai.

Skins are implemented in user space, so there shouldn't be a difference.
>From the kernel point of view they are all threads.

-- 
Thanks,
//richard

