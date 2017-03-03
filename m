Date: Fri, 3 Mar 2017 15:18:38 +0100
From: Henning Schild <henning.schild@siemens.com>
Message-ID: <20170303151838.35652dab@md1em3qc>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: [Xenomai] any extra reasons for -EINTR in xenomai
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: "xenomai@xenomai.org" <xenomai@xenomai.org>

Hi,

someone came to me asking about reasons why system calls would exit
with -EINTR on a xenomai 2 system. As far as i know there a are two
possible reasons for that to happen.
1. the thread received a signal while being blocked in the call
2. the thread got a rt_task_unblock

Now we are pretty sure that we can rule out both of these cases. It is
a complex system and there might be signals. But none of the
applications signal handlers was called and the application did not
exit, which only leaves very few signals as candidates. Because almost
all default signal handlers will end an application.
And my current assumption would be that default signal handlers
all have SA_RESTART and there would be no -EINTR. Which limits the
possible signals to the ones where a custom handler was installed and
SA_RESTART was not set. But according to the logs no custom handler was
called.

We know it happened while being blocked in rtdm_event_timedwait and the
documentation mentions the two reasons from above.

Am i missing anything important here?

regards,
Henning

