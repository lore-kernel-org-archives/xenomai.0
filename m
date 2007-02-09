Message-ID: <b647ffbd0702091553w41f4ec9cne58a59206a58121d@domain.hid>
Date: Sat, 10 Feb 2007 00:53:31 +0100
From: "Dmitry Adamushko" <dmitry.adamushko@domain.hid>
Subject: Re: [Xenomai-help] Strange deadlock.
In-Reply-To: <45CCF15F.806@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <45CCCD10.9000008@domain.hid>
	<b647ffbd0702091314y5c452cd2wc48f126763b9b3@domain.hid>
	<45CCF15F.806@domain.hid>
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Maksym Veremeyenko <verem@domain.hid>
Cc: Xenomai help <xenomai@xenomai.org>

> i try to move lock/unlock to macros and add some history logging.
>
> Is possible next scenario:
> 1. task A lock mutex M
> 2. task A going to secondary mode
> 3. task A performing "long" io wait operation and some flags modified.
> ...

What do you mean by "some flags modified" ?
Anyway, the "scenario" you have described is just not how it all works.


> BTW
> at some moment i got a kernel oops, not very informative but...
> ...
> Feb  9 23:26:02 dev-3 kernel: CPU:    0
> Feb  9 23:26:02 dev-3 kernel: EIP:    0060:[<c01b53b2>]    Not tainted VLI
> Feb  9 23:26:02 dev-3 kernel: EFLAGS: 00210246   (2.6.17.14-xenomai #1)
> Feb  9 23:26:02 dev-3 kernel: EIP is at remove_proc_entry+0x22/0x1b0
> ...
> <c014476e> registry_proc_callback+0x17e/0x370

Does it happen at the time your application deletes some objects (e.g.
mutexes) ?

If it's not possible to get a simpler code fragment out of your
application to illustrate this problem, then maybe you could describe
some logic behind your application..
(how often each task acquires a lock / how long does it hold it and
what kind of actions does it do at this time, etc.)...

TIA,

-- 
Best regards,
Dmitry Adamushko

