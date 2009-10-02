Message-ID: <4AC62883.1080908@domain.hid>
Date: Fri, 02 Oct 2009 18:21:23 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <4AC2448B.1080500@domain.hid> <1254396765.2703.234.camel@domain.hid>
In-Reply-To: <1254396765.2703.234.camel@domain.hid>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-core] RFC: 2.5 todo list.
List-Id: Xenomai life and development <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Philippe Gerum <rpm@xenomai.org>
Cc: Xenomai core <Xenomai-core@domain.hid>

Philippe Gerum wrote:
> On Tue, 2009-09-29 at 19:31 +0200, Gilles Chanteperdrix wrote:
>> Hi guys,
>>
>> full of energy after this tremendous first XUM,
> 
> Agreed, thanks to the DENX folks for having thought of it in the first
> place, and organized it nicely.
> 
>>  I would like to start a
>> discussion about what people would like to see in the 2.5 branch.
>>
> 
> Jan has described the situation quite accurately already, regarding the
> trade-off between getting everything we want into 2.5 so that no 2.6 is
> required, and releasing the too long-awaited 2.5 asap.
> 
> As you mentioned already, the key issue is ABI stability.
> Any change we want before 3.0 that breaks the ABI should preferably go
> to 2.5, so that we don't end up maintaining 2.5.x, 2.6.x and 3.x. At any
> rate, we could not afford the latter anyway. This is a different matter
> than API issues; we already allowed API extensions during a stable
> cycle, provided they do not break existing application code (except in
> emergency cases), so I see no problem in pushing a few more services to
> 2.5.1 and beyond, provided that condition is met.
> 
>> Here is a first list, please feel free to criticize it:
>> - signals in primary domain (something that we almost forgot)
> 
> Yes, this one must be in. At least, we should break the ABI one more
> time for this before releasing 2.5.0. This item has priority #1 for
> me, since providing that infrastructure will enable a series of
> additional services to be implemented properly. In fact, this is more a
> matter of allowing nucleus callouts to user-space than anything else;
> POSIX RT signals in full primary mode being an application of them.

Ok. So, if we add the core skin fdtable, this leaves us with two items:
- signals in primary domain
- core skin fdtable

-- 
					    Gilles.

