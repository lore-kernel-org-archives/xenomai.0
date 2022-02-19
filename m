References: <PH1P110MB105036E4A7D3954173E4C536E2379@PH1P110MB1050.NAMP110.PROD.OUTLOOK.COM>
From: Philippe Gerum <rpm@xenomai.org>
Subject: Re: In-band Context Switch on oob_ioctl() call
Date: Sat, 19 Feb 2022 16:29:26 +0100
In-reply-to: <PH1P110MB105036E4A7D3954173E4C536E2379@PH1P110MB1050.NAMP110.PROD.OUTLOOK.COM>
Message-ID: <877d9qho0c.fsf@xenomai.org>
MIME-Version: 1.0
Content-Type: text/plain
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Russell Johnson <russell.johnson@kratosdefense.com>
Cc: xenomai@xenomai.org


Russell Johnson via Xenomai <xenomai@xenomai.org> writes:

> Hello,
>
> I have added the oob_ioctl file descriptor to my driver, and I have
> made sure that I call the necessary evl functions in the open()
> function in the driver as well. I have a test app in userspace that is
> simply opening the driver and issuing an oob_ioctl every second. What
> I am seeing in the output from "evl ps -l" is that the "ISW" and
> "CTXSW" fields are incrementing with every oob_ioctl call. I added in
> the O_OOB flag to my open call, and I am still seeing the same
> behavior. I don't get why it would be switching to in-band every time
> the oob_ioctl() is called. Any ideas on what I could be doing wrong?
>
> Thanks,
> Russell

It looks like the calling thread is undergoing the so-called weak
scheduling policy, see [1].

[1] https://evlproject.org/core/user-api/scheduling/#SCHED_WEAK

-- 
Philippe.

