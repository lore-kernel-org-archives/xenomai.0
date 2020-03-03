MIME-Version: 1.0
References: <23edaf750b0b41ef9a129bbaf2758d9f@RCDC-MAIL09.corp.diehl.com>
 <0281e4a5-a2b2-bac5-1e30-ea2bb85f3d8d@siemens.com>
 <373cc865d6c34dda997ac6745bae99cd@RCDC-MAIL09.corp.diehl.com>
 <9cc5a0de-1db9-e46f-7aa8-30e41b1ac926@siemens.com>
 <f92ca27d1ba34380b47c0c451da4f61b@RCDC-MAIL09.corp.diehl.com>
 <925e50f4-8395-2a15-3654-73ea1f241f1c@siemens.com>
 <b4806aec7c5746bc83fa897b09ce7ab1@RCDC-MAIL09.corp.diehl.com>
 <d36eca04d68b4434bde75d9cfa8c1418@RCDC-MAIL09.corp.diehl.com>
 <f7fc8190-afe3-872e-d7aa-dcabcd576a77@siemens.com>
 <ee2bea74fc5b40af8fbc9cff17c9bd78@RCDC-MAIL09.corp.diehl.com>
In-Reply-To: <ee2bea74fc5b40af8fbc9cff17c9bd78@RCDC-MAIL09.corp.diehl.com>
From: Richard Weinberger <richard.weinberger@gmail.com>
Date: Tue, 3 Mar 2020 13:08:21 +0100
Message-ID: <CAFLxGvyxyfU0_F+mqymZg1d+X_Rzw9=LoZQAXuF5J8skR8n2Xg@mail.gmail.com>
Subject: Re: Migrate project from Debian 8 Xenomai 2.x to Debain 9 Xenomai 3.x
Content-Type: text/plain; charset="UTF-8"
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Carsten EHRMANN <Carsten.Ehrmann@diehl.com>
Cc: Jan Kiszka <jan.kiszka@siemens.com>, "xenomai@xenomai.org" <xenomai@xenomai.org>

On Tue, Mar 3, 2020 at 1:03 PM Carsten EHRMANN via Xenomai
<xenomai@xenomai.org> wrote:
>
> Hi Jan,
>
> I don't have one of the files
>
> - /usr/src/linux-4.9.146/include/config/xeno/drivers/rtipc/xddp.h
>
> - /lib/modules/4.9.146/kernel/drivers/xenomai /ipc/xeno_rtipc.ko
>
>
> Where do I get them? Do they have to be installed when building the kernel?

Did you enable CONFIG_XENO_DRIVERS_RTIPC_XDDP in your kernel.

-- 
Thanks,
//richard

