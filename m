Message-ID: <48F83F96.4080709@domain.hid>
Date: Fri, 17 Oct 2008 09:32:38 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <20081016154620.320953568@domain.hid>	<20081016154621.960994053@domain.hid>	<48F7A2A8.6020807@domain.hid>
	<48F7C9F8.5080405@domain.hid>
In-Reply-To: <48F7C9F8.5080405@domain.hid>
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Sender: jan.kiszka@domain.hid
Subject: Re: [Xenomai-core] [PATCH 10/12] Report current shadow thread mode
	to user space
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
Cc: xenomai@xenomai.org

Jan Kiszka wrote:
> Gilles Chanteperdrix wrote:
>> Jan Kiszka wrote:
>>
>> Ok. I still liked the solution of using a piece of shared heap. This was
>> more general and would have allowed us to use this piece of shared heap
>> for future purposes.
> 
> Shared heaps do not allow for the __thread optimization.

Actually, not true. But it would add a level of indirection to this path.

So, before adding support for something that /may/ be of interest in
future (and that still could be added at that time): What further use
cases for _per-thread_ data that is shared between user space and kernel
do you see? I do have the syscall-less real-time clock in mind, but that
will be globally shared data.

Jan

