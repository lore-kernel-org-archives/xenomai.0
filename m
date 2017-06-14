MIME-Version: 1.0
From: Robbert van der Bijl <rvanderbijl@seuratech.com>
Date: Wed, 14 Jun 2017 19:51:40 -0400
Message-ID: <CAPEB8kXw=D=WOV2VgVncK_12k8YdkoOy3SXiQ5zywMYkTdt5UA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: [Xenomai] Mysterious Mode Switches (Xenomai 2.6.2.1)
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

All,

I'm fairly new when it comes to Linux & Xenomai, but I've been able to
successfully put together the majority of our fairly large application on
our Delta Tau PMAC board (PowerPC 465, dual core) in C++ so far.

The one thing that stumps me though, is the mode switches that happen with
certain memory accesses.

Take this chunk of code for instance:
for (int i=0; i<10000; i++)
   memset(m_pClientSendData+(32*i), 0, 32);

This does NOT cause mode switches when run on a chunk of memory that's been
malloc'ed.

However, this code DOES cause a mode switch (same memory):
memset(m_pClientSendData, 0, 320000);

The for loop is obviously crazy slow compared to the single memset and not
very practical. But I'm at a loss to explain this behavior. Similar
problems with memcpy as well.

Bottom line, what I'm trying to accomplish is getting around 400k of shared
memory pumped out through a pipe to a TCP/IP task that runs in secondary
mode only, as to avoid having the main task flip back and forth between
primary and secondary modes. I tried to do this with just plain shared
memory initially, but then found out that the mutexes I was using would
force my TCP/IP thread into primary mode when I grabbed the mutex....

Does anyone have any ideas?

Thanks,
Robbert
