Message-ID: <449039EC.7070404@domain.hid>
Date: Wed, 14 Jun 2006 18:31:40 +0200
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
Subject: Re: [Xenomai-core] /proc/xenomai broken...
References: <17552.12922.452992.652848@domain.hid>	<44903432.3070905@domain.hid>	<17552.13951.428423.915304@domain.hid>
	<4490381F.6030309@domain.hid>
In-Reply-To: <4490381F.6030309@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Philippe Gerum <rpm@xenomai.org>
Cc: xenomai@xenomai.org

Philippe Gerum wrote:
> Gilles Chanteperdrix wrote:
> 
>> Philippe Gerum wrote:
>>  > Gilles Chanteperdrix wrote:
>>  > > When using xenomai trunk, it appears that /proc/xenomai is no 
>> longer a
>>  > > directory but a file returning "0".
>>  > >  >  > Check your recent changes for giving the nucleus a regular 
>> syscall  > table. I would not be surprised of some side-effect there. 
>> i.e.  > something going on with the xnptree_t descriptor?
>>
>> That is exactly the source of the problem, since iface_proc_root in
>> nucleus/module.c has not yet been set, the proc entry for the nucleus
>> interface get created directly under /proc instead of
>> /proc/xenomai/interfaces.
>>
>> Do we need a /proc entry for this interface ?
>>
> 
> Not really. This would only give the exact number of processes bound to 
> the nucleus, whilst major interface counters already display the number 
> of bound threads.
> 

This said, the other option would be to move the call to 
xnshadow_mount() from the xnarch_init() to __xeno_sys_init() in a 
kernel-only section, just after xnpod_init_proc() has returned. There is 
nothing done in the arch-layer for any architecture that would prevent 
this. Btw, I'd say that "core" would be better than "xenomai" to name 
this internal interface.

-- 

Philippe.

