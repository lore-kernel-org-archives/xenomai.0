Message-ID: <4E7C8EB2.1020308@domain.hid>
Date: Fri, 23 Sep 2011 15:50:42 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <cover.1316774468.git.richard.cochran@domain.hid>
In-Reply-To: <cover.1316774468.git.richard.cochran@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-core] [RFC 0/1] Class driver for raw Ethernet packets
List-Id: Xenomai life and development <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Richard Cochran <richardcochran@domain.hid>
Cc: xenomai@xenomai.org

On 2011-09-23 13:02, Richard Cochran wrote:
> This patch adds a class driver for raw Ethernet drivers under
> Xenomai. The goal is to support industrial protocols such as EtherCAT
> and IEC 61850, where the "stack" is a user space program needing
> direct access at the packet level. The class driver offers interfaces
> for registration, buffer management, and packet sending/receiving.
> 
> Although this patch is a kind of first draft, still I have it working
> on the Freescale P2020 with a real world application, with very good
> results. I can post a patch series for the gianfar driver in the ipipe
> tree, if anyone is interested.
> 
> The user space interface is a character device and not a socket, simply
> because my applications will probably never need fancy socket
> options. The class driver could surely be made to offer a socket
> instead, but I think the character is sufficient.

Many interesting interfaces already exists for standard PF_PACKET (e.g.
time stamping), plus you gain portability this way. So let's not create
something special here even if it's sufficient for the first use case.

> 
> The class driver is clearly in the wrong directory within the source
> tree, but I put it there just to get started. It really does not fit
> to any of the other drivers, so it probably would need its own place
> under ksrc/drivers.

New class, new directory.

However, the key question is how this approach relates to RTnet. Right
now its likely comparing apples to onions, but that may change as things
evolve in the right direction.

Can you explain a bit about your NIC driver architecture and the
maintenance strategy? It looks like you are taking an approach of
patching existing drivers in-tree. Anything that resolves the
maintenance pain we have with the RTnet model is already worth
considering. Did you take this approach intentionally? What pros and
cons do you see?

Jan

-- 
Siemens AG, Corporate Technology, CT T DE IT 1
Corporate Competence Center Embedded Linux

