References: <6aedc4bc-74b5-4a9f-5c38-036a3d7850b9@siemens.com>
 <ee7647d4-0bfd-0933-2f10-e9fdc5da2880@web.de>
From: Philippe Gerum <rpm@xenomai.org>
Message-ID: <03b3c307-07bd-58d1-d555-19449186fca6@xenomai.org>
Date: Tue, 20 Mar 2018 16:05:07 +0100
MIME-Version: 1.0
In-Reply-To: <ee7647d4-0bfd-0933-2f10-e9fdc5da2880@web.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] 4.9 for x86 issue
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Jan Kiszka <jan.kiszka@web.de>
Cc: Xenomai <xenomai@xenomai.org>

On 03/10/2018 11:06 PM, Jan Kiszka wrote:
> On 2018-03-09 08:51, Jan Kiszka wrote:
>> 4.9 requires more work, I've pushed the beginning to wip/4.9 in the same
>> repo.
> 
> I started to patch further on this during my flight (wip/4.9 updated),
> noticed that the 4.14-wip queue will need a little bit sysentry tweaking
> as well (missing 64-bit syscall dispatching), and then had to find 4.9
> in a rather unfortunate state /wrt x86-64: CPUs are no longer idling
> properly. I went back to ipipe-core-4.9.24-x86-2, without a difference.
> 
> If you should look into 4.9-x86 as you indicated, please check this.
> 
> Another catch along that road: maxcpus=1 with >1 CPUs available triggers
> a NULL pointer when Xenomai gets armed. That is the case with 4.4 as well.
> 

Can't reproduce this one (over kvm), 4.4 and 4.9 included, so this may
be depending on the Kconfig.

-- 
Philippe.

