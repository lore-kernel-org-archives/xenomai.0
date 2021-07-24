MIME-Version: 1.0
From: Virendra Kate <virendrakate@gmail.com>
Date: Sat, 24 Jul 2021 03:25:31 -0700
Message-ID: <CAA3JOdbNPJKfSoE1KgLa9C+_CdnLpyYbOZb+Fix9RtTjkUEM8Q@mail.gmail.com>
Subject: Xenomai 3.1 User API : Posix vs Cobalt
Content-Type: text/plain; charset="UTF-8"
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: "Xenomai@xenomai.org" <xenomai@xenomai.org>

Hello,

According to the Xenomai 3.1 documentation, we found multiple sets of API
documentations, cobalt API and
the Xeno-Posix API (skipping Alchemy and the emulator skins for now). The
Cobalt API seems to
be rich in terms of the APIs.

Xeno-Posix API doc:
https://xenomai.org/documentation/xenomai-3/html/xeno3prm/group__cobalt__api.html
Cobalt API doc:
https://xenomai.org/documentation/xenomai-3/html/xeno3prm/group__cobalt__core.html

Which one should be used by the userspace application?
According to the information mentioned in the
https://source.denx.de/Xenomai/xenomai/-/wikis/Start_Here,
section "
<https://outlook.office.com/mail/sentitems/id/AAQkAGMyODIzYjdlLTc4NzItNDc4MS1iMzQxLWI0M2QzNjg3ODZiMgAQAHLZer7LYJ5Hua%2FPoWPXSJY%3D#x_user-content-how-does-xenomai-deliver-real-time>How
does Xenomai deliver real-time?": "In this *dual kernel* configuration, all
the RTOS APIs Xenomai
provides interface with the Cobalt core, and only those APIs are deemed
real-time capable, including the subset
of POSIX 1003.1c services implemented by Xenomai (aka *libcobalt*)."

Is the Cobalt API part of the Cobalt core or libcobalt? If it is part of
the Cobalt Core can the userspace application
directly use it?

Thanks,
Virendra
