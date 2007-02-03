Message-ID: <b647ffbd0702031020u2d02d234k309e5fa830c79d21@domain.hid>
Date: Sat, 3 Feb 2007 19:20:07 +0100
From: "Dmitry Adamushko" <dmitry.adamushko@domain.hid>
Subject: Re: [Xenomai-help] Error: cat: /proc/xenomai/stat: Cannot allocate
	memory
In-Reply-To: <1170520703.8282.6.camel@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <19981456.1170405795640.JavaMail.ngmail@domain.hid>
	<1170409755.4981.11.camel@domain.hid> <45C309BF.9090808@domain.hid>
	<1170415388.4981.36.camel@domain.hid> <1170420270.4981.58.camel@domain.hid>
	<Pine.LNX.4.64.0702021456170.12191@domain.hid>
	<1170426719.4981.66.camel@domain.hid>
	<Pine.LNX.4.64.0702021635150.12191@domain.hid>
	<Pine.LNX.4.64.0702031807260.22251@domain.hid>
	<1170520703.8282.6.camel@domain.hid>
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: rpm@xenomai.org
Cc: Xenomai help <xenomai@xenomai.org>

Hi,

are there any other memory pools increasing while "MemFree" is decreasing?

cat /proc/meminfo

If it's kmalloc() - related, I'd expect "Slab" to be increasing..  [1]

Moreover, if it's left to be running for quite some time, does it
actually causes an "out-of-memory" problem in the end?  [2]

I have run "while true ; do cat /proc/interrupts; done" for some time
and "MemFree" is going down but what's going up is "Buffers" +
"Cached" (mainly, the first one) and not
"Slab".

cat /proc/interrupts returns file content which is different every
time and might be cached (likely - "Buffers").. Actually, do you
observe similar behaviour when reading any other /proc file (or even
any regular) ?

After all, Linux memory manager is quite dynamic in its behaviour, and
"MemFree" does not really answer a question "how much memory is free"
as there are some _reclaimable_ sources of memory ("buffers" and
"cached")..

So what's about [1]? Of course, if you can encounter [2] after some time..

-- 
Best regards,
Dmitry Adamushko

