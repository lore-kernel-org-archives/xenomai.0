MIME-Version: 1.0
From: =?UTF-8?B?5a2Z5LiW6b6Z?= <sunshilong369@gmail.com>
Date: Sun, 10 May 2020 13:11:39 +0800
Message-ID: <CAAvDm6YS03s6A76n_As4Bo4BkpcdYXOzmSkC3LGCseTJv_fTfA@mail.gmail.com>
Subject: Q: about mutex lock bettween rt thread and nrt thread.
Content-Type: text/plain; charset="UTF-8"
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai <xenomai@xenomai.org>

Hi,
I think mutex lock should not be shared bettween rt thread and
nrt thread, because if i use the posix mutex api implemented
by linux,it causes the rt thread switch to the secondary mode.

    As per the documentation(https://xenomai.org/documentation/
xenomai-3/html/xeno3prm/group__alchemy__mutex.html
#ga8f7db304bb5a839d81614f00c4cde145),
the mutex api implemented by xenomai could not be used in
normal linux thread.

So,how to share the same mutex bettween rt thread and nrt
thread?Could you offer some guidance on that?

Thank you for your attention.
Looking forward to hearing from you.
