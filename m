MIME-Version: 1.0
From: Marco Barletta <barlettamarco8@gmail.com>
Date: Fri, 21 May 2021 13:21:13 +0200
Message-ID: <CAK6DXL2H4OuDGehPaHwDtArtg=Y2H+xs6eC49_9NueYPtxRCHA@mail.gmail.com>
Subject: xnsched_kick
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

Hi everyone, related to the sched_quota patch I posted about one week ago.
I'm trying to understand why xnsched_kick is needed, in which situation is
called. Reading the code it seems it's called when there's a xeno thread
that must be downgraded and scheduled in Linux, but I didn't understand why
there's the need to run to complention without respecting group budget. Can
you help me?
Best regards.

-- 
Marco Barletta
