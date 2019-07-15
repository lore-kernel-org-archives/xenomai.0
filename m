MIME-Version: 1.0
From: Richard Weinberger <richard.weinberger@gmail.com>
Date: Mon, 15 Jul 2019 21:59:40 +0200
Message-ID: <CAFLxGvyy3Ume6K_K4-TgiAK_ycOJ4PUQfGiDzbtO2Y_USWvfpQ@mail.gmail.com>
Subject: rt_mutex_release() within a signal handler
Content-Type: text/plain; charset="UTF-8"
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

Docs on rt_mutex_release() state:
-EPERM is returned if mutex is not owned by the current task, or more
generally if this service was called from a context which cannot own
any mutex (e.g. interrupt context).

Do you mean signal handlers by "interrupt context"?
Long story short, is it allowed to unlock a RT_MUTEX from a signal handler?

-- 
Thanks,
//richard

