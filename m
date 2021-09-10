MIME-Version: 1.0
From: Byron Jacquot <bjacquot@cardinalpeak.com>
Date: Fri, 10 Sep 2021 14:37:14 -0600
Message-ID: <CAJte2PCq9wdgeN8AA=dfRxewhe+61UgRY=ecqG-y_wXXQ+0c2w@mail.gmail.com>
Subject: EVL Semaphore Open Question
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

Hello Everyone,

I'm working on growing some EVL proof-of-concept applications to come
closer to the end application.

I want to build a multicore processing pipeline by connecting out-of-band
threads with semaphores.  The EVL Function Index [1] marks the semaphore
creation & open functions as being available for in-band calls.

It appears that I'm unable to call them in-band - evl_new_sem() returns "No
such device or address."  evl_open_sem() segfaults.

As a workaround, the creating thread (an in-band management thread that
ideally creates and manages the OOB resources) can temporarily attach to
EVL, do the creation operation, then detach.

Do I understand the information in the function index correctly?  Is there
a recommended best practice for managing EVL resources from an in-band
thread?

I can cut code down to a brief example if that would help.

[1]https://evlproject.org/core/user-api/function_index/

Thank you,

Byron Jacquot
