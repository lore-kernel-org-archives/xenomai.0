MIME-Version: 1.0
From: Ronny Meeus <ronny.meeus@gmail.com>
Date: Fri, 31 Jan 2020 10:46:07 +0100
Message-ID: <CAMJ=MEd18keoeV3DQZ5Z+CjKWEYqRfHPLp=bM=65tvW6518CAA@mail.gmail.com>
Subject: bug in eventobj_wait when using EVOBJ_ALL mode
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

Hello

Following patch corrects an issue when passing the EVOBJ_ALL mode to the
eventobj_wait function.

The expected behavior of this function to my understanding is:
eventobj_wait in EVOBJ_ALL mode is supposed to return when all the bits
specified by the caller are set in core.value (=pending events).
The state of the other bits in core.value is not relevant.

The current behavior is that it returns when all bits are set AND no
other events
are pending in the core.value, which is not correct in my opinion.

diff --git a/lib/copperplate/eventobj.c b/lib/copperplate/eventobj.c
--- a/lib/copperplate/eventobj.c
+++ b/lib/copperplate/eventobj.c
@@ -217,7 +217,7 @@ int eventobj_wait(struct eventobj *evobj
        }

        waitval = evobj->EVOBJ_ANY & bits;
-       testval = mode & EVOBJ_ANY ? waitval : evobj->core.value;
+       testval = mode & EVOBJ_ANY ? waitval : bits;

        if (waitval && waitval == testval) {
                *bits_r = waitval;


Best regards,
Ronny

