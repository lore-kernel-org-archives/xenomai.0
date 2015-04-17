Message-ID: <55314F6E.6010806@siemens.com>
Date: Fri, 17 Apr 2015 20:22:38 +0200
From: Jan Kiszka <jan.kiszka@siemens.com>
MIME-Version: 1.0
References: <55314426.7040300@siemens.com>
In-Reply-To: <55314426.7040300@siemens.com>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] Dealing with too small thread stacks
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Xenomai <xenomai@xenomai.org>

On 2015-04-17 19:34, Jan Kiszka wrote:
> Hi,
> 
> analyzing page faults of an application that prefers to set its own
> stacks, I noticed a problem in Xenomai (2 and 3), at least from the
> usability POV: We document the minimum stack stack as PTHREAD_STACK_MIN
> + 1 page, at least in Xenomai 3, and we enforce that on thread creation.
> However, enforcement is doomed to fail if the stack is preallocated (and
> that too small).

Another aspect in this: I just realized that the glibc tends to ignore
our "+ getpagesize()" in the stack calculation. That's at least true for
the x86-64 systems with glibc 2.19 on which I tested.

Jan

-- 
Siemens AG, Corporate Technology, CT RTC ITP SES-DE
Corporate Competence Center Embedded Linux

