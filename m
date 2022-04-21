MIME-Version: 1.0
References: <56fd561b25857e45232c952f6ef4a7a4@cweb010.nm.nfra.io>
In-Reply-To: <56fd561b25857e45232c952f6ef4a7a4@cweb010.nm.nfra.io>
From: Richard Weinberger <richard.weinberger@gmail.com>
Date: Thu, 21 Apr 2022 10:27:13 +0200
Message-ID: <CAFLxGvwn1j+6MJFRWVfwTvR=6S6H3fKW8hHGoY5AdevyitHCsQ@mail.gmail.com>
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

On Thu, Apr 21, 2022 at 8:21 AM Jae Hyun Park via Xenomai
<xenomai@xenomai.org> wrote:
> I have been used rt_task_create from Xenomai 2.
>
> In the Xenomai 3 cobalt example, it seemed to use only pthread_create.

It depends on the skin. rt_task_create is part of the native/alchemy skin.
While pthread_create is part of the posix skin.

Xenomai offers multiple interfaces to use realtime.

> I'm not familiar to task, process and thread...
>
> I have several question belong to thread_create and rt_task_create.
>
> 1. does rt_task_create create a process(task) instead of creating a single thread?

No. See above.

> 2. Is creating thread is better than using rt_task_create in Xenomai 3? I'm wondering now we are not using rt_task_create.

Depends. Many people prefer the posix skin because it feels familiar.

> 3. Is there difference between xnthread and pthread?

xnthread is Xenomai's internal kernel structure to represent a realtime thread.

-- 
Thanks,
//richard

