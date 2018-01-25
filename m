MIME-Version: 1.0
From: Greg Gallagher <greg@embeddedgreg.com>
Date: Thu, 25 Jan 2018 15:26:51 -0500
Message-ID: <CALLqZ8SCqE4mx8i4p3bcztu_XmKnY6aTZFjCFyqpf-3QAOgJkg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: [Xenomai] meeting agenda suggestions
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: "Xenomai@xenomai.org" <Xenomai@xenomai.org>, Philippe Gerum <rpm@xenomai.org>
Cc: Jan Kiszka <jan.kiszka@siemens.com>, Steven Seeger <steven.seeger@nasa.gov>

Adding some points that I think need some attention at the meeting.

Drivers:
    Currently we have support for certain boards, SOC families and
devices.   Do we want to expand on that?  Are there commonly used
pieces of hardware that we want to add support for?  For most devices
it may be a port from Linux to Xenomai, which could be low effort.
What drives improvements to our current  frameworks like gpio and spi
?  Adding i2c, pwm and pci devices (etc) may be helpful.  Are users
looking for full BSPs?

Reference Boards:
    Projects like AGL (Automotive Grade Linux) use low cost boards as
reference platforms so potential customers can get up and running
quickly.  I really think this helps for prototyping.  There's already
some support for Raspberry Pi, we could expand on that.  We could look
at the beaglebone family of boards and potentially Zynq boards.

Quick Start Guide:
    This would probably fall under documentation but putting together
a quick start guide for new users may be worthwhile.  It could be tied
into the above comment of using low cost boards and we focus on a
quick start guide for one or two community (low cost) boards.

"How to" Articles:
   This may go with the above point, but adding some type of doc that
shows how to properly use the gpio, udd, ipc and other sub systems
would help new users and people possibly evaluating Xenomai.  Having
these on the homepage I think would show potential users that there
are resources to help get them started.  It would give prospective
users a general idea of what features Xenomai supports so far.  They
could also serve as reference/example code.

Testing:
   How do we test Xenomai?  There's some documentation on smokey the
smoke test framework, when are those tests run and how often?  Do we
run those tests across all architectures? Is a regression test suite
something we want to build?  Any reported bugs can be made into a test
case and added to the regression tests.

Bug reporting:
   When a user reports a bug on the mailing list they usually don't
include all the information needed.  There has been discussion on
using a bug tracking system.  Is this part of the gitlab effort? it
would be nice to ask the users for example code to reproduce their
bugs.  The udd issue on the todo list is hard to reproduce since there
is only snippets of code in the email thread and not a lot of
information on what the kernel side of the udd driver does.  We can
also see if anyone is watching or currently working on the bug.

Xenomai's successes:
    We could give community members and companies the opportunity to
post their product or creation somewhere on the Xenomai home page.  It
would give potential users the ability to see Xenomai's successes.

Thanks,

Greg

