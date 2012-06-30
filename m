MIME-Version: 1.0
In-Reply-To: <4FEEDAD0.4050701@xenomai.org>
References: <CAKKWdtd6kB_FAzwPmC+Cxnc2tjSnZOLkqw5aoeDPwBa=dq1gNw@mail.gmail.com>
	<4FEEDAD0.4050701@xenomai.org>
Date: Sat, 30 Jun 2012 15:42:06 +0430
Message-ID: <CAKKWdtdEAxLQ9Px4uTbVWbCtw7DVNLwQpV9JghgvCjo4XiNq5Q@mail.gmail.com>
From: ali hagigat <hagigatali@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Subject: Re: [Xenomai] question: scheduling latency
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: xenomai@xenomai.org

Does the worst/best case scheduling latencies depend on the number of
the real time tasks? How about the number of Linux non real-time
tasks?
Does the number of the interrupts effect the latency? How about the
type of the interrupt?

Much appreciate for the reply.

On Sat, Jun 30, 2012 at 3:24 PM, Gilles Chanteperdrix
<gilles.chanteperdrix@xenomai.org> wrote:
> On 06/30/2012 12:48 PM, ali hagigat wrote:
>> Does the scheduling latency is variable for a Xenomai system and
>> depends on the amount of load of a system and the number of the system
>> tasks and Linux applications?
>
> The scheduling latency is variable, but the worst case scheduling
> latency and best case scheduling latencies are not, by definition.

