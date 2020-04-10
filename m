MIME-Version: 1.0
From: =?UTF-8?B?5a2Z5LiW6b6Z?= <sunshilong369@gmail.com>
Date: Fri, 10 Apr 2020 11:53:04 +0800
Message-ID: <CAAvDm6b4+VjdosMZOY=QZT1UqomhAwSffTYcVaF6AvYxXQdbTA@mail.gmail.com>
Subject: I think lib/copperplate depends on glic while using dual kernel
 configuration.Am i right?
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
   Two figures are contains in url
https://gitlab.denx.de/Xenomai/xenomai/-/wikis/Start_Here.

   Since the architecture showed in Figure 2. Xenomai 3 single kernel
configuration, i could draw the conclusion that copperplate interface
depends on the glibc.

   But i don't think i can draw the same conclusion from the Figure 1.
Xenomai 3 dual kernel configuration.

  When i enable the --enable-pshared compiler option, I could clearlly see
the create_main_heap function calls shm_open which is provided by glibc.
  So, i think copperplate interface depends on glibc while using dual
kernel configuration.Am i right?

  Thanks a lot.Looking forward to your reply.
  Best regards.
