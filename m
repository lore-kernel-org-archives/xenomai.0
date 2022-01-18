MIME-Version: 1.0
From: =?UTF-8?B?5a2Z5LiW6b6ZIHN1bnNoaWxvbmc=?= <sunshilong369@gmail.com>
Date: Tue, 18 Jan 2022 14:35:07 +0800
Message-ID: <CAAvDm6Y1DaeR==TZo-3pkWiQNKobro3JkYPsRdyHqxS3Tm7QBQ@mail.gmail.com>
Subject: Logging for real-time tasks.
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

Hi, lists

And I clearly know that writing to file could not be guaranteed
to be completed in a limited duration(i.e. before a specific
deadline).

Since logging information during the execution of real-time
tasks can help me understand what lead to a bug or crash,
so my question is how can I  write neccerary logs for
real-time tasks?

As far as I know, I can achieve this goal by

1. write the log in real-time thread by XDDP
   or
   write the log to a block of already allocated memory
2. read out the said log in non-real-time thread and write them to a file

Is there any better method?
Thank you for your attention to this matter.
