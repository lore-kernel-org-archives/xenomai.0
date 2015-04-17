Message-ID: <55314426.7040300@siemens.com>
Date: Fri, 17 Apr 2015 19:34:30 +0200
From: Jan Kiszka <jan.kiszka@siemens.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: 7bit
Subject: [Xenomai] Dealing with too small thread stacks
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Xenomai <xenomai@xenomai.org>

Hi,

analyzing page faults of an application that prefers to set its own
stacks, I noticed a problem in Xenomai (2 and 3), at least from the
usability POV: We document the minimum stack stack as PTHREAD_STACK_MIN
+ 1 page, at least in Xenomai 3, and we enforce that on thread creation.
However, enforcement is doomed to fail if the stack is preallocated (and
that too small).

As we cannot detect if the user set a stack address in pthread_attr_t, I
would suggest to fail thread creation instead of performing it with
improper parameters. Other suggestions? If not, I would prepare a patch
for Xenomai 3 (for 2 only if desired).

Jan

-- 
Siemens AG, Corporate Technology, CT RTC ITP SES-DE
Corporate Competence Center Embedded Linux

