MIME-Version: 1.0
Date: Tue, 6 Jan 2015 10:20:04 -0600
Message-ID: <CA+C+_XQi7Nji4Ecq2VH4KfVxRdtWouE4=APu4bhfo8Yk4dZ-Zg@mail.gmail.com>
From: Mathew Benson <mathew.benson@gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: [Xenomai] Resource utilization
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: "xenomai@xenomai.org" <xenomai@xenomai.org>

First, I'd like to thank all contributors for Xenomai.  I'm an embedded
software engineer accustomed to working with the more expensive closed
RTOSs.  So far, I'm really happy with Xenomai.

Second, is there a mechanism to monitor resource utilization from user
space?  My application used to measure CPU idle time by busy waiting and
counting in a low priority thread.  Not the best solution, but usually very
portable.  However, the nucleus detects the Linux kernel is getting starved
and flags it as a failure.  I could move this thread to secondary mode, but
I would rather use a native API if one exists.

Similar to the previous question, what other metrics are available?
