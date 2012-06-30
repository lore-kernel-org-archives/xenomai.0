Message-ID: <4FEEDAD0.4050701@xenomai.org>
Date: Sat, 30 Jun 2012 12:54:08 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <CAKKWdtd6kB_FAzwPmC+Cxnc2tjSnZOLkqw5aoeDPwBa=dq1gNw@mail.gmail.com>
In-Reply-To: <CAKKWdtd6kB_FAzwPmC+Cxnc2tjSnZOLkqw5aoeDPwBa=dq1gNw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] question: scheduling latency
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: ali hagigat <hagigatali@gmail.com>
Cc: xenomai@xenomai.org

On 06/30/2012 12:48 PM, ali hagigat wrote:
> Does the scheduling latency is variable for a Xenomai system and
> depends on the amount of load of a system and the number of the system
> tasks and Linux applications?

The scheduling latency is variable, but the worst case scheduling
latency and best case scheduling latencies are not, by definition.

Running the latency test under high load for a long time gives you a
good idea of the worst case and best case scheduling latencies. But you
should be sure to try and cover as much as possible of the whole code of
the linux kernel, which is why we use LTP as part of the load we put on
the system.

-- 
                                                                Gilles.

