Message-ID: <434A601C.7000605@domain.hid>
Date: Mon, 10 Oct 2005 14:35:40 +0200
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
References: <b647ffbd0510100450n19552d5fq@domain.hid>	
	<434A585B.40905@domain.hid>
	<b647ffbd0510100529v2c96d260r@domain.hid>
In-Reply-To: <b647ffbd0510100529v2c96d260r@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Subject: [Xenomai-core] Re: [syscall.c] rt_bind_queue/heap()
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Dmitry Adamushko <dmitry.adamushko@domain.hid>
Cc: xenomai@xenomai.org

Dmitry Adamushko wrote:
>>As you noticed below, the point is that this feature should be active for
>>kernel-based code only; for user-space, we're toast: typical chicken-and-egg
>>problem since we need the registry to cross the space boundaries but the
>>registry requires a name to index the object first. So yes, we need to check for
>>anonymous calls in every service taking a symbolic name in native/syscalls.c,
>>and return -EINVAL when applicable.
> 
> 
> I thought that "libnative" would be a better place since this way we
> would avoid the user mode -> kernel mode switch.
> 
> 
>>...Or, we might auto-generate some dummy name in native/syscalls.c we would pass
>>to the registry when this situation arises, so that anonymous creation and use
>>from user-space would still be possible.
> 
> 
> Yep, in this case a name would be a string == object's address, thus
> it's unique.
> 
> Ok, I'd probably vote for the 2-nd approach.
> 

Definitely better since this keeps the semantics consistent across execution spaces.

-- 

Philippe.

