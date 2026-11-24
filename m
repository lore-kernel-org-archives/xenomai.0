Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=217.70.183.195
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795535776;
	b=jpUf4RqayELWDG1TX7NnCSKYbEAoi9SMpu7FY+2BE5OSmslOjKS4xr9cimw6GMXOTepH
	 97gT6LErJVKToFrnS4gaJjVXQa7HFHTpHDKRyJgA9iU0xXCREU34xMQEUr7Ely/TuErdY
	 NYvx97w9e6zmqO54xl3GmCHxX/boz4tZSyykfyzw8a/K9hDTo1COunpWRTPjdQ+5Inpld
	 qYJjDESRfN8bBzKboI+TF0WNimjMQ5pJuj+AA4KXHjh0BDd4dTC6smMtPWxtYm/GO6a5N
	 4QiASau9kSQenBV6GS2hTrwTo4kAceerf+dgDkV7z3LFR4erN1OTOuxEtfndcLF949A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795535776;
	h=DMARC-Filter:Received:DKIM-Signature:From:To:Cc:Subject:In-Reply-To:
	 References:User-Agent:Date:Message-ID:MIME-Version:Content-Type:
	 X-GND-Sasl:X-GND-Score:X-GND-Cause:X-GND-State;
	bh=LfOsQwMNTtUrBdR5Not6kcP4G3ANRzQRg9njCzQTHPc=;
	b=ZKqBO6iU0U76Riuto24zkcE47wqyg1aRHg/SGvZLREHm8PxaaltX8gs5sz7UcDRKGrjR
	 TwCe0GbaCu4xgkbTtEy+t+uNzbrTsPSsWGfPlvApVkVKGJE2UyrgDsrE6g7zlRgtZfat3
	 AoO2yRzin95Zyd210UdVYPpCAw9d205o9vRoVCkq5+hopGQtWH3pnHPOLZCNSn88yDxG8
	 rhPhBtWzOraYdRLwpb8BEIDJ0bLtqaOm4HWh+pxUKsCQURFOp832pMQNvs1nfns/7onDt
	 Trt9W4ReAYIaDN6BIyByQJnevRnoet+0fLhmYgpuAmPAugKwO9FQlIzCWhSQj8qxOTg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=xenomai.org;
	spf=pass smtp.mailfrom=xenomai.org;
	dkim=pass header.d=xenomai.org header.i=@xenomai.org header.a=rsa-sha256 header.s=gm1 header.b=RtNMDBCw;
	arc=none smtp.remote-ip=217.70.183.195
Received: from relay3-d.mail.gandi.net (relay3-d.mail.gandi.net [217.70.183.195])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB1A4606A31E
	for <xenomai@lists.linux.dev>; Tue, 24 Nov 2026 15:56:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org EB1A4606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=xenomai.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xenomai.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=xenomai.org header.i=@xenomai.org header.a=rsa-sha256 header.s=gm1 header.b=RtNMDBCw
Received: by mail.gandi.net (Postfix) with ESMTPSA id BC78121FF6;
	Tue, 24 Nov 2026 15:56:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=xenomai.org; s=gm1;
	t=1795535773;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=LfOsQwMNTtUrBdR5Not6kcP4G3ANRzQRg9njCzQTHPc=;
	b=RtNMDBCw8I4UIBzVmIYVdnmo3dDYU7yh9OtFNTL54Y4yvJzYvR5W7glVv6dQjogUaxHNMT
	pqWDyjF0Wo3nyfjqf0QHlL8nRRr3/oVJRCEX1WkOnhLT8Rb5CDYvesgCxZ5u40h4st74vR
	/Bx+aY8ycSTl4S2WNbDSawt+PQiY8L3H3S/WMI8zBKd6QiSRIo77PcK2+dFi6uJLiG7GQF
	9s+TBoz4QZ0uX1MB7V+SZbNxisqe4gDl+cfXR89hQ18y3KrTp5G1V2zrBwk71JInFSMF8D
	CBMEoD3LJFsBTHFiFNd78ZYeaB4gifz/47GYj0ZGSp705tg0vfjLqHgxV3AGZw==
From: Philippe Gerum <rpm@xenomai.org>
To: Jan Kiszka <jan.kiszka@siemens.com>
Cc: Xenomai <xenomai@lists.linux.dev>
Subject: Re: [RFC] symbol wrapping for libcobalt
In-Reply-To: <ccfe86ea-2afd-4047-bc65-4dd1a35820fc@siemens.com> (Jan Kiszka's
	message of "Tue, 24 Nov 2026 13:30:05 +0100")
References: <877bi3thhu.fsf@xenomai.org>
	<ccfe86ea-2afd-4047-bc65-4dd1a35820fc@siemens.com>
User-Agent: mu4e 1.12.12; emacs 30.2
Date: Tue, 24 Nov 2026 16:56:13 +0100
Message-ID: <87ecca2pgi.fsf@xenomai.org>
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Post: <mailto:xenomai@lists.linux.dev>
List-Help: <mailto:xenomai+help@lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
List-Owner: <mailto:xenomai+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain
X-GND-Sasl: rpm@xenomai.org
X-GND-Score: -100
X-GND-Cause: dmFkZTEdWz9SLQvKafftQzKXuU+IsOuxojrSHi1VKyqkaO5LoxCgYWqs4HlE7HABZpv5Czw+XdPjZomu3X1O3kHQCyOz3BeCVg+wkqhcXSJuaVZPX6997H2PCa2ImdrLtkjk99v6SsMdsxk6W3djDDlNtwJmglZxktzZE5pZ0AQv/akf0BIuRctk5r3gGp+E9HyFPymy9o7G0LS7IIOikSqjyu5GY988kwY0Vd+ONe7tsrk8QyTIb8AHBMXmWwWbfakeuKbmHMidhuNOwc8LvhHUkeDwev9i8SnetcvOEB+g/aZwRPAruCCdfE4AeKy4RKPtDoX0MnuRDZ5exgCyG3+B7GYzZnE9YgwcsGgojOf2HvzZCF55UHgD3+4M2PhnsoCtJeN4eFezTqfueOPL+g1lY4DdOGobqB18W0XeNQZmQWpL7XZOlnj7tqoMnUcQ9KGzkBFKRcpEVFIYNCrb88GjjE+45W0tEFcW+GJYBEsWR9/a8IYRc8LrgoMTM+o8yN8mKK5bgliWAf2vokMz5WgJ2QHmbPNd0nQLZFgdovO2jLZOEDXbcvmRwAXXyAY+F5Aq6hX7jvYX+QV0RDTxDLMTTmnnCnu/NfE2QACIukTNwsZBIQa+Cjx0G5GKPjEFtIF3AOL3iZkgGIVlDbl3CWPR4y5MHIGzKIaCq1rEX+mR9WLfww
X-GND-State: clean

Jan Kiszka <jan.kiszka@siemens.com> writes:

> On 23.11.26 21:33, Philippe Gerum wrote:
>>   We could use C11 thrd_create() the same way to create workers and get
>>   into the exact same pitfalls without involving libstdc++ at all.
>>   
>
> To be fair, using language provided threading and locking is generally
> are recipe for desaster on PREEMPT-RT as well because most are non-RT only.
>

Agreed. Also known as "The Fine Print" of the "Real-time Everywhere, Go
Wild, We Care!" promise.

>> - a way to somehow mark the object files that did include the libcobalt
>>   headers, so that linking them without -Wl,--wrap fails.
>> 
>
> Already some idea for how this could be implemented?
>

Some, still at the early stage though. I've been experimenting with them
lately. Not far away from a solution, but there is still some work ahead
to keep it simple. I'll follow-up on this.

>> - conversely, a way to mark the object files that did _not_ include the
>>   libcobalt headers but the regular glibc ones, so that linking them
>>   _with_ -Wl,--wrap fails when the wrap list contains inconsistently
>>   used symbols.
>
> Well, the absence of the marker above must be enough in order to detect
> pre-built standard libs.
>

I don't think so. We need a way to actually claim that we don't want the
wrapping step to happen on a set of objects we manage, while excluding
libraries which plays no part in the Xenomai system from the
check. Otherwise, we would reject libgcc.a, crt.o, plus any unrelated
3rd-party library on the ground that they don't claim anything. IOW,
having no marker does not mean that we claim that we should not have
one, it just means that we don't care (in most cases because we don't
even know about Xenomai in the first place). So these are two separate
issues. Tricky.

>> 
>> This metadata could be used by a checker tool that would answer the
>> following question: "where the heck each call to libcobalt services
>> actually goes for this executable"? It could also be used to generate
>> the wrap list on the fly for symbols which carry the 'wrapped' marker
>> by inspecting the object list.
>> 
>> Icing on the cake, it should even be possible to use this information to
>> implement auto-annotation of source code by reading a wrapped binary,
>> i.e. patching in the __COBALT() annotations mechanically, for those who
>> want an easy way to depart from symbol wrapping for an existing
>> application.
>> 
>> Thoughts welcome.
>> 
>
> Having wrapping as an opt-in layer on top of an explicit
> POSIX-compatible API sounds fair to me. Then only users who need the
> wrapping for a good reason can select that separately. Technically,
> users could already do that with Xenomai 3 today, but it is not
> presented that way, thus likely only few will do it.
>

True, as wrapping even appears to be recommended since it is used
throughout the examples, tests and so on in our code base. Opt-in is
clearly the proper way.

-- 
Philippe.
