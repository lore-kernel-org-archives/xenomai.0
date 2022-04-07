References: <48e0fc4f-0020-907c-136e-53f01e596fda@siemens.com>
From: Philippe Gerum <rpm@xenomai.org>
Subject: Re: 5.10-dovetail regression?
Date: Thu, 07 Apr 2022 16:25:30 +0200
In-reply-to: <48e0fc4f-0020-907c-136e-53f01e596fda@siemens.com>
Message-ID: <87czhtezp0.fsf@xenomai.org>
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
To: Jan Kiszka <jan.kiszka@siemens.com>
Cc: Xenomai <xenomai@xenomai.org>

a
Jan Kiszka <jan.kiszka@siemens.com> writes:

> Hi Philippe,
>
> does this already ring some bell?
>
> https://source.denx.de/Xenomai/xenomai-images/-/jobs/419210
>
> Only triggers with qemu-amd64, not on real HW and not with 5.15.
>
> Jan

8e2c09ee5323 is most likely causing this. It's a backport of the fix
developed for 5.15. I have a kvm-aarch64 setup which I routinely use
too, I'll reproduce and fix this.

-- 
Philippe.

