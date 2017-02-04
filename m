MIME-Version: 1.0
From: Ran Shalit <ranshalit@gmail.com>
Date: Sat, 4 Feb 2017 10:19:39 +0200
Message-ID: <CAJ2oMhL5ZTgJQj60Evu6qsEE3GueDf_eKfVpHrZB7fhGaJkLQw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: [Xenomai] cpu with one core only
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

Hello,

It is said in documentation:

"The key issue is with the number of CPU cores actually running
real-time threads and receiving interrupts from real-time sources, not
with the overall number of cores on line on the target hardware.
Because the Cobalt co-kernel does not share any lock with the regular
Linux kernel when dealing with real-time activities, a 16-way server
pinning such activities on not more than four of the available cores
would still deliver good performances in a Cobalt-based dual kernel
configuration."

We plan to use xenomai,
but the cpu (Atom) is only a single core.

Can a single core still gives good results with xenomai ?

Regards,
Ran

