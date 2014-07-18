MIME-Version: 1.0
Sender: justinhartubc@gmail.com
Date: Thu, 17 Jul 2014 23:07:33 -0700
Message-ID: <CAFgu5KVLOB46vh85KV47RT0b4YBsAW_KkLBGRbY_TWhRyrgGMw@mail.gmail.com>
From: Justin Hart <justin.hart@mech.ubc.ca>
Content-Type: text/plain; charset=UTF-8
Subject: [Xenomai] Large clock drift, keyboard issues
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

Hi everyone,

I'm experiencing a problem with a kernel I recently patched with Xenomai.
 I'm a bit new to Xenomai, so I apologize if this is a silly question or
the wrong list.  Basically, the clock on the machine that we have xenomai
running on runs very fast.  Additionally, after using the system to control
our Barrett WAM, We have keyboard issues, wherein a single keystroke will
yield a long line of characters.  For example, typing "hello" would give
you "hellooooooooooooooooooooooooo."

Here's my output from xeno clocktest

== Tested clock: 0 (CLOCK_REALTIME)
CPU      ToD offset [us] ToD drift [us/s]      warps max delta [us]
--- -------------------- ---------------- ---------- --------------
  0          674175352.5      -498134.813          0            0.0
  1          674175353.8      -498133.887          0            0.0
  2          674175451.3      -498135.134          0            0.0
  3          674175466.0      -498135.222          0            0.0

Is there anywhere that I should start my search, with regards to fixing
this?  This is especially important to my group, as our controller for the
WAM interpolates over time, meaning that the arm lurches and jumps with
respect to the clock running incorrectly.

Thanks!

Justin
