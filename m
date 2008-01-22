Message-ID: <4796186D.2070906@domain.hid>
Date: Tue, 22 Jan 2008 17:23:09 +0100
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
References: <4794DDF7.9070009@domain.hid> <4794E556.1030904@domain.hid>
	<4794E904.5060106@domain.hid>
In-Reply-To: <4794E904.5060106@domain.hid>
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Sender: Philippe Gerum <philippe.gerum@domain.hid>
Subject: Re: [Xenomai-core] Patch selection by prepare-kernel.sh (again)
Reply-To: rpm@xenomai.org
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Jan Kiszka <jan.kiszka@domain.hid>
Cc: Xenomai-core@domain.hid

Jan Kiszka wrote:
> Jan Kiszka wrote:
>> Jan Kiszka wrote:
>>> Philippe,
>>>
>>> what was the idea behind commit #3256 [1]? It breaks the original
>>> behavior of selection adeos-ipipe-2.6.23-... in the presence of 2.6.23.x
>>> - and leaves a bad first impression for beginners (I received such a
>>> notice here...). Was this for the special case
>>> adeos-ipipe-2.6.20.21-i386-1.12-02.patch? But I think the common case
>>> should take precedence over this corner case here. Unless there are more
>>> issues with the original version, I would vote for restoring it.
>>>
>>> Alternatively, we could add a safety belt by trying to apply the patch
>>> with --dry-run first and only continue if this works out without
>>> failures. Can hack this up if it's acceptable.
>> Oh, this check already exists!
>>
>> So let's try this version, which additionally cleans up the related
>> documentation. Catches both 2.6.23* and 2.6.24* for me here, but I may
>> miss some cases (2.4?).
> 
> The documentation hunk was nonsense, here is a hopefully better version.
> 

Makes sense and works fine for the kernel/arch combos I've tested so
far. Merged, thanks.

-- 
Philippe.

