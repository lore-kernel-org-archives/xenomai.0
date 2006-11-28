Message-ID: <456C97B9.1000402@domain.hid>
Date: Tue, 28 Nov 2006 21:10:33 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-core] Re: [RFC][PATCH 1/2] rework shadow CPU affinity
References: <456C3EF9.30102@domain.hid> <456C8961.7060906@domain.hid>
In-Reply-To: <456C8961.7060906@domain.hid>
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Sender: jan.kiszka@domain.hid
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: xenomai-core <xenomai@xenomai.org>

Gilles Chanteperdrix wrote:
> Jan Kiszka wrote:
>> Picking up the earlier discussion of CPU affinity of shadow threads,
>> this patch now opens the possibility to assign a CPU mask on
>> xnshadow_map. It cleans up the related nucleus code and updates all
>> callers of xnshadow_map appropriately.
>>
>> Be warned, it's only tested on (q)emulated SMP. Comments and test
>> reports on real hardware are welcome.
> 
> It is only possible to set the affinity of a user-space thread, why
> adding another way to do it ?
> 

I'm not yet completely understanding what you mean.

So far the affinity was indirectly assigned to some xnthread by the CPU
the caller of xnshadow_map happened to run on. Now this is done
explicitly, thus in a more robust way (there was an undefined path in
the old code) and without duplicating code (/wrt skins).

Jan

