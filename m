Message-ID: <480DB48F.5050303@domain.hid>
Date: Tue, 22 Apr 2008 11:49:03 +0200
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
References: <480A4F7F.4000909@domain.hid> <480DB1B5.10700@domain.hid>
In-Reply-To: <480DB1B5.10700@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: Philippe Gerum <philippe.gerum@domain.hid>
Subject: Re: [Xenomai-core] warning: symlink-is-self-recursive
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
To: Roland Stigge <stigge@domain.hid>
Cc: xenomai@xenomai.org

Roland Stigge wrote:
> Hi,
> 
> Roland Stigge wrote:
>> =========================================================================
>> W: libxenomai-dev: symlink-is-self-recursive
>> usr/include/xenomai/asm-generic/xenomai .
>> N:
>> N:   The symbolic link is recursive to a higher directory of the symlink
>> N:   itself. This means, that you can infinitely chdir with this symlink.
>> N:   This is usually not okay, but sometimes wanted behaviour.
>> N:
>> W: libxenomai-dev: symlink-is-self-recursive
>> usr/include/xenomai/asm-sim/asm .
>> W: libxenomai-dev: symlink-is-self-recursive
>> usr/include/xenomai/asm-sim/xenomai .
>> W: libxenomai-dev: symlink-is-self-recursive
>> usr/include/xenomai/asm-x86/xenomai .
>> W: libxenomai-dev: symlink-is-self-recursive usr/include/xenomai/xenomai .
>> =========================================================================
>>
>> I.e. installing Xenomai created those recursive links which might be
>> there for source compatibility reasons. Can they be removed at some
>> point or should I accept the above issue as intended for the future?
> 
> No comment from anyone? Maybe I should detect the necessity for those
> links by removing and seeing if anyone complains? ;-)
>

Those links are intended. We need them to build applications, so that the
include paths in userland look like the kernel ones, since we share header files
between both environments.

> bye,
>   Roland
> 
> _______________________________________________
> Xenomai-core mailing list
> Xenomai-core@domain.hid
> https://mail.gna.org/listinfo/xenomai-core
> 


-- 
Philippe.

