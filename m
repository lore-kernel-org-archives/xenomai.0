Sender: Alexis Berlemont <alexis.berlemont@domain.hid>
References: <200808312323.29665.berlemont.hauw@domain.hid>
	<48BCF4D9.8030100@domain.hid>
	<200812310119.48242.berlemont.hauw@domain.hid> <4960BD85.6040703@domain.hid>
From: Alexis Berlemont <berlemont.hauw@domain.hid>
Date: Mon, 05 Jan 2009 00:15:54 +0100
In-Reply-To: <4960BD85.6040703@domain.hid> (Jan Kiszka's message of "Sun\,
	04 Jan 2009 14\:45\:41 +0100")
Message-ID: <87tz8eirx1.fsf@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Subject: Re: [Xenomai-core] [PATCH 0/2] RTDM in user mode
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

Hi,

> I already created some local branch with your patches and compiled them.
> Only minor issues visible: please check for pointer<->int conversion
> warnings on 64-bit - and please add spaces after if, while, for etc. :).
> I will look into this in more details soon.

OK.

> Did you already tried to build or even run some existing single-user
> driver against your extension? I'm thinking of the 16550A e.g. (it even
> has a test case). Also the irqbench driver could be a candidate. Is
> there some standard how-to-convert/build procedure?

OK. I will try to port these drivers into user-space. Before doing
that, I just have to develop the framework for common kernel API
(lists, ioremap, test_*_bit, etc.).

Many thanks for having a look at these patches.

Alexis.

