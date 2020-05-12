Subject: =?UTF-8?Q?Re=3a_When_the_linux_process_could_recieve_the_message_tr?=
 =?UTF-8?Q?ansport_through_XDDP=ef=bc=9f?=
References: <CAAvDm6bKxtaf-xg5bM+SGgt39CrTh94chO9rfs-NuAO4nwPx3w@mail.gmail.com>
From: steve freyder <steve@freyder.net>
Message-ID: <37d2adba-f2e4-dd77-89cc-a6d5ee95ee34@freyder.net>
Date: Mon, 11 May 2020 22:42:57 -0500
MIME-Version: 1.0
In-Reply-To: <CAAvDm6bKxtaf-xg5bM+SGgt39CrTh94chO9rfs-NuAO4nwPx3w@mail.gmail.com>
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Transfer-Encoding: 8bit
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: =?UTF-8?B?5a2Z5LiW6b6Z?= <sunshilong369@gmail.com>, xenomai <xenomai@xenomai.org>

On 5/11/2020 9:16 PM, 孙世龙 via Xenomai wrote:
> Hi,
>       As i am using XDDP to transport messages bettween the head domain and
> linux domain(i mean there are two processes, one is rt process, the other
> is linux process.),I wonder that when the linux process could recieve the
> message？
>       *Will ADOES wake up the related linux process at once when the head
> domain write something to the XDDP node?* Or, the linux process has to wait
> for the schedule of linux kernel, if the processor is busy, it may wait for
> a long long time.
>
>       Thank you for your attention.
>       Looking forward to hearing from you.

The Linux process cannot wake up immediately, otherwise what would be 
the point of having an RT co-kernel if it didn't preempt the non-RT 
environment.


If the RT process wishes to give the non-RT process an opportunity to 
run in order to receive the just-sent message, it had better relinquish 
the CPU.  Inserting an rt_sleep() call (or equivalent) might be one 
(inelegant?) option, but certainly nothing in iPipe or anything at that 
layer is going to magically solve that problem for you.


If you're going to build code that makes a NRT process a subordinate of 
an RT process, you're going to have to employ some non-standard logic 
and get creative about how you deal with the inverted priority 
relationship that implicitly exists between the RT/NRT schedulers 
involved in that scenario.  XDDP is a bidirectional data relay, not a 
scheduler.


Regards,

Steve


