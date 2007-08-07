Message-ID: <2ff1a98a0708070809h2ac1a0b7q2178297d5a824bb9@domain.hid>
Date: Tue, 7 Aug 2007 17:09:05 +0200
From: "Gilles Chanteperdrix" <gilles.chanteperdrix@xenomai.org>
In-Reply-To: <46B888B4.2070301@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <46B86E53.1030803@domain.hid> <46B86FE4.3040209@domain.hid>
	<46B87B85.1080304@domain.hid>
	<2ff1a98a0708070711n5e97ca03y18aef78ececc7e0d@domain.hid>
	<46B87F93.9020308@domain.hid>
	<2ff1a98a0708070724j5afecf20q22994d053553ed57@domain.hid>
	<46B885E3.6060605@domain.hid>
	<2ff1a98a0708070756q60794718wb1bc55675ea05ba4@domain.hid>
	<46B888B4.2070301@domain.hid>
Subject: Re: [Xenomai-core] [Adeos-main] [COW-BUG] __alloc_pages called from
	atomic context
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
Cc: adeos-main <adeos-main@gna.org>, xenomai-core <xenomai@xenomai.org>

On 8/7/07, Jan Kiszka <jan.kiszka@domain.hid> wrote:
> Gilles Chanteperdrix wrote:
> > The fact that you are in a hurry should not be an excuse to propose a
> > fix which is much worse than the bug itself.
>
> Please explain.

Using GFP_ATOMIC is not a good idea, because the kernel needs the
GFP_ATOMIC pools for allocation that take place from really atomic
contexts such as interruption handlers for instance. fork should not
be an atomic context.

So the only reason I see why you propose this patch is because you are
in a hurry. Ok, before we fix this properly, you can use GFP_ATOMIC
locally, but please do not make
this an official patch.

-- 
                                               Gilles Chanteperdrix

