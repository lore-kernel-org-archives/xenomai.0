Message-ID: <45ABA0C7.3050407@domain.hid>
Date: Mon, 15 Jan 2007 16:41:59 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
Subject: Re: [Xenomai-core] IPIPE for ARM9 i.MX and AT91RM9200 ?
References: <45AB9D58.3060308@domain.hid>
In-Reply-To: <45AB9D58.3060308@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
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
To: Steven Scholz <steven.scholz@domain.hid>
Cc: xenomai@xenomai.org

Steven Scholz wrote:
> Hi all,
> 
> are there IPIPE Patches for recent kernels (2.6.19) available for
> Freescale's i.MX1/i.MXL and Atmel's AT91RM9200 cpus available.
> 
> Thanks a million,

Hi,

The IPIPE patches for ARM exist for linux 2.6.14 and 2.6.15. There is an
i.MX21 port for 2.6.14 and an AT91 port for 2.6.15. I do not know how
much i.MX21 is different from i.MX1.

Porting the IPIPE patch for ARM to linux 2.6.19 has a high priority on
the todo-list, but still needs to be done.

-- 
                                                 Gilles Chanteperdrix

