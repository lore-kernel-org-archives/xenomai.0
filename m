Message-ID: <50F6C781.2060407@siemens.com>
Date: Wed, 16 Jan 2013 16:30:09 +0100
From: Jan Kiszka <jan.kiszka@siemens.com>
MIME-Version: 1.0
References: <50F6C3EE.1020508@siemens.com> <50F6C657.2060503@xenomai.org>
In-Reply-To: <50F6C657.2060503@xenomai.org>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] ipipe: fix domain migration helper
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Philippe Gerum <rpm@xenomai.org>
Cc: Xenomai <xenomai@xenomai.org>

On 2013-01-16 16:25, Philippe Gerum wrote:
> On 01/16/2013 04:14 PM, Jan Kiszka wrote:
>> Hi Philippe,
>>
>> a first heads-up, maybe you have an idea before I start debugging: That
>> patch causes troubles when our application shuts down. The main thread
>> hangs like this, unkillable:
>>
> 
> It looks like the LO_WAKEUP_REQ virtual interrupt does not reach the 
> handler.

Hmm, lostage queue overflow? We used to carry some detection patch (to
make the existing detector unconditional), not sure what happened to it.
Will dig in this direction first.

That said, the system runs fine with the patch removed.

Jan

-- 
Siemens AG, Corporate Technology, CT RTC ITP SDP-DE
Corporate Competence Center Embedded Linux

