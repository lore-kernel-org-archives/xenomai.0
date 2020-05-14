MIME-Version: 1.0
From: =?UTF-8?B?5a2Z5LiW6b6Z?= <sunshilong369@gmail.com>
Date: Thu, 14 May 2020 14:22:16 +0800
Message-ID: <CAAvDm6ajDfWc9ymVfdNAidyyPuStkRwD8FXXAz3NZwdoeG6gjA@mail.gmail.com>
Subject: Question about rt_task_sleep and rt_alarm_start.
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai <xenomai@xenomai.org>

Hi=EF=BC=8C
       Assuming that, there is a real time process which has only
a single thread.It creates an object triggering an alarm routine
at a specified time in the future.Then it triggers the alarm and
has been put to sleep for *a long long duration* through calling
to the *rt_task_sleep*.

     Will the routine be called when the alarm expires *again and again*?
     Will the routine runs in the same thread with the main function?

     Thank you for your attention to this matter.
     Look forward to hearing from you.
