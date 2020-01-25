MIME-Version: 1.0
From: Greg Gallagher <greg@embeddedgreg.com>
Date: Fri, 24 Jan 2020 21:34:58 -0500
Message-ID: <CALLqZ8Rxxass-jFgRSPm4NoGNs4MBw3M8bezJvFJNkbTR68eiQ@mail.gmail.com>
Subject: Kconfig errors in stable branch
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

Hi,
Is the stable branch of Xenomai meant to run over the 4.19 kernels? I
found the following error when you do so:
                   init/Kconfig:2056: can't open file
"arch/$SRCARCH/xenomai/Kconfig"
Looks like we are missing these two commits from the stable branch:
https://gitlab.denx.de/Xenomai/xenomai/commit/c9810f0a7a1ae5e83f69e4224b69811f1f21f1cc
https://gitlab.denx.de/Xenomai/xenomai/commit/60aa08c98a2602919d89d28b5641965c092dccf0

This may not be an issue but I thought I would bring it up just in case.

Thanks

Greg

