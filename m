Message-ID: <9716cf94f871edebb580b4010a5c24465299514f.camel@sprinte.eu>
Subject: Waking up a linux thread from a xenomai thread, without mode switch
From: Julien Blanc <julien.blanc@sprinte.eu>
Date: Fri, 14 Dec 2018 11:48:41 +0100
Content-Type: text/plain; charset="utf-8"
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: "Xenomai@xenomai.org" <Xenomai@xenomai.org>

Hi,

We’re currently using semaphores and a shared buffer to allow
communication between a xenomai cobalt thread and a linux regular
thread (the xddp interface has been tested and does not perform well
for our use case, which is exchanging a lot a very small messages).

While this works fine most of the time, we’ve noticed that this incurs
a mode switch when the xenomai rt-thread calls real_sem_post, and,
under heavy load, it can results in that specific thread being
suspended for too long.

I couldn’t find in the documentation how to do this properly :
* waiting on a xenomai semaphore from a linux thread is forbidden
* posting a linux semaphore from a xenomai thread incurs a mode switch

I’d like each thread to stay in its mode. I can live with the linux
thread entering the primary mode for a small amount of time, but not
the xenomai thread entering the secondary mode.

Did i miss something obvious ?

Regards,

Julien


