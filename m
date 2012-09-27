MIME-Version: 1.0
In-Reply-To: <5064C1CB.5070209@xenomai.org>
References: <CAOiXNkCgA42HcOWaLuzmkaLPaSW2zCTEux3rdzKmUYeu1Egzyg@mail.gmail.com>
	<506496C2.9030302@xenomai.org>
	<CAOiXNkA3NLDDzt6PaYj670jGuAeES_r8pm0Q6qo9vAk=zgO9VA@mail.gmail.com>
	<5064BFDB.1040906@xenomai.org>
	<CAOiXNkAxMRy5m+-2gwvNbx_YDCOFW-QHJRU-5hRTnBx=3HefAw@mail.gmail.com>
	<5064C1CB.5070209@xenomai.org>
Date: Thu, 27 Sep 2012 23:24:03 +0200
Message-ID: <CAOiXNkAYj8ACmoVGwV0xRumS5pAjGsKB9eOMUt1d_tqpu+C-Yw@mail.gmail.com>
From: Andrey Nechypurenko <andreynech@googlemail.com>
Content-Type: text/plain; charset=ISO-8859-1
Subject: Re: [Xenomai] Error requesting IRQ on DM3730 (BeagleBoard xM)
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: xenomai@xenomai.org

> You are really supposed to use the kernel API for these things, and not
> touch the registers directly.

You are right and I will definitely change the pin configuration code.
It was just a very first quick prototype and I was unfamiliar with
corresponding kernel API.

Is it also "safe" to use kernel GPIO API to toggle GPIO from RT
context such as timer handler? With safe I mean if it can influence
real-time performance in some negative way?

Thank you,
Andrey.

