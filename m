Message-ID: <434A585B.40905@domain.hid>
Date: Mon, 10 Oct 2005 14:02:35 +0200
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
References: <b647ffbd0510100450n19552d5fq@domain.hid>
In-Reply-To: <b647ffbd0510100450n19552d5fq@domain.hid>
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

<snip>

> 
> So it must be fixed. There must be an explicit prohibition on creating
> NULL-named objects from the user-mode.
> 

...Or, we might auto-generate some dummy name in native/syscalls.c we would pass 
to the registry when this situation arises, so that anonymous creation and use 
from user-space would still be possible.

-- 

Philippe.

