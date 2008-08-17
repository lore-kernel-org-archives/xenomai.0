Message-ID: <48A7D636.7020500@domain.hid>
Date: Sun, 17 Aug 2008 09:41:42 +0200
From: Wolfgang Grandegger <wg@domain.hid>
MIME-Version: 1.0
References: <486E6E1D.2020209@domain.hid> <4871C676.90301@domain.hid>
	<48A2BFD1.40400@domain.hid> <200808162315.31868.paul_c@domain.hid>
In-Reply-To: <200808162315.31868.paul_c@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-core] [PATCH] can: avoid naming conflict in 2.6.26
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Paul <paul_c@domain.hid>
Cc: Jan Kiszka <jan.kiszka@domain.hid>, xenomai@xenomai.org

Paul wrote:
> On Wednesday 13 August 2008, Jan Kiszka wrote:
>> Wolfgang Grandegger wrote:
>>> Hi Jan,
>>>
>>> Jan Kiszka wrote:
>>>> Due to a global definition of 'clock' in latest 2.6.26, we now have a
>>>> problem with two rtcan drivers. Below is a fix that breaks those
>>>> drivers' user interface by rename the conflicting variable which
>>>> unfortunately also renames the module parameter name.
>>>>
>>>> An alternative approach would be to add a kernel version dependent fix
>>>> to the drivers. That would be required as compat_module_param_array
>>>> cannot be extended to use a different parameter name than the related
>>>> variable is called. Maybe someone sees a third, better solution, I do
>>>> not.
>>> Nor do I. But I would prefer prefixing the module parameters with
>>> "can_". Who knows what comes next.
>> The issue is still open. Wolfgang, will you take care?

Didn't find time yet to fix it, sorry.

>> Jan
> 
> Just bringing the issue back to the top (had to fix locally before compiling 
> 2.6.26.2).
> 
>  Attached, a patch in line with Wolfgang's recommendation - Also includes a 
> trivial spelling correction.

Your patch looks good.

Thanks.

Wolfgang.

