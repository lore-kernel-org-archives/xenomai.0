MIME-Version: 1.0
References: <20210304134540.5246-1-s.grosjean@peak-system.com>
In-Reply-To: <20210304134540.5246-1-s.grosjean@peak-system.com>
From: Andy Tannenbaum <trb@bioniklabs.com>
Date: Thu, 4 Mar 2021 09:57:56 -0500
Message-ID: <CAHcYe6nEAJU7NYKwA55T4U0qLm+Ux6CaKdbzMkq78m_gKVWK_w@mail.gmail.com>
Subject: Re: [PATCH] RT-socket-CAN: Add support of PEAK PCAN-PCIe FD cards
 family
Content-Type: text/plain; charset="UTF-8"
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Xenomai mailing list <xenomai@xenomai.org>

I am using this PEAK pciefd patch with x86 and xenomai-next (3.1+) from the
repo and Linux 5.4.77, in my motor control system.  I am using the same API
that I had used for the PEAK PCIe device on Xenomai 2.6.4 and 3.1.  I do
not use the CAN-FD API features of the new driver, I just wanted to use the
newer PEAK M.2 device (because newer Intel motherboards support M.2 more
than PCIe) with the older CAN API, so this worked well for me.  I will
appreciate it if this patch is added to Xenomai 3.

-- 
*Andrew Tannenbaum*
Software Architect

*BIONIK, Inc.*
80 Coolidge Hill Road
Watertown, MA 02472
Office: +1 617 926 4800 x4811
www.bioniklabs.com
