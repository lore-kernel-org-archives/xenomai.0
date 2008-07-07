Message-ID: <4871C676.90301@domain.hid>
Date: Mon, 07 Jul 2008 09:32:06 +0200
From: Wolfgang Grandegger <wg@domain.hid>
MIME-Version: 1.0
References: <486E6E1D.2020209@domain.hid>
In-Reply-To: <486E6E1D.2020209@domain.hid>
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
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
To: Jan Kiszka <jan.kiszka@domain.hid>
Cc: xenomai-core <xenomai@xenomai.org>

Hi Jan,

Jan Kiszka wrote:
> Due to a global definition of 'clock' in latest 2.6.26, we now have a
> problem with two rtcan drivers. Below is a fix that breaks those
> drivers' user interface by rename the conflicting variable which
> unfortunately also renames the module parameter name.
> 
> An alternative approach would be to add a kernel version dependent fix
> to the drivers. That would be required as compat_module_param_array
> cannot be extended to use a different parameter name than the related
> variable is called. Maybe someone sees a third, better solution, I do
> not.

Nor do I. But I would prefer prefixing the module parameters with 
"can_". Who knows what comes next.

Wolfgang.

