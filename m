Subject: Re: rt_mutex_release() within a signal handler
References: <CAFLxGvyy3Ume6K_K4-TgiAK_ycOJ4PUQfGiDzbtO2Y_USWvfpQ@mail.gmail.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <a9bb8611-0d71-39d6-b825-6434f887efc9@siemens.com>
Date: Tue, 16 Jul 2019 09:36:21 +0900
MIME-Version: 1.0
In-Reply-To: <CAFLxGvyy3Ume6K_K4-TgiAK_ycOJ4PUQfGiDzbtO2Y_USWvfpQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Richard Weinberger <richard.weinberger@gmail.com>, xenomai@xenomai.org

On 15.07.19 21:59, Richard Weinberger via Xenomai wrote:
> Docs on rt_mutex_release() state:
> -EPERM is returned if mutex is not owned by the current task, or more
> generally if this service was called from a context which cannot own
> any mutex (e.g. interrupt context).
> 
> Do you mean signal handlers by "interrupt context"?

I think that term dates back to times where the API was available to in-kernel
users. Example should probably be removed.

> Long story short, is it allowed to unlock a RT_MUTEX from a signal handler?
> 

A signal handler is run in a thread in the end, and a thread can own mutexes.
That is not an issue. But I hope you are aware of the fact that signal handlers
are non-RT on entry.

Jan

-- 
Siemens AG, Corporate Technology, CT RDA IOT SES-DE
Corporate Competence Center Embedded Linux

