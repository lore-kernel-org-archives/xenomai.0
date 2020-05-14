MIME-Version: 1.0
From: =?UTF-8?B?5a2Z5LiW6b6Z?= <sunshilong369@gmail.com>
Date: Thu, 14 May 2020 13:37:35 +0800
Message-ID: <CAAvDm6Yzkph-2ecSBV_MFaYFOgO4v1gAmZi7gs-UJiLZCw3bsQ@mail.gmail.com>
Subject: When would a real time process be able to resume running again after
 it have called rt_task_sleep?   
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

Hi,
     I wonder that when a *real time process* would be able to resume
running again after it have called rt_task_sleep.

    Assuming that many *real time processes* with higher priority are
running in parallel=EF=BC=8CI think the process(which have called rt_task_s=
leep)
have to wait for available cpu resources *even if its sleep duration has *
*expired*. So, the real duaration may be longer then the setting value.
Am i right?

    Thank you for attention.
    Look forward to hearing from you.
