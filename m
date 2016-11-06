References: <1676fd7b-a9a1-586a-9ffb-b27fa25c57ab@therobotstudio.com>
From: Philippe Gerum <rpm@xenomai.org>
Message-ID: <5f00234a-fc69-b2c7-a9d7-6a98dd432963@xenomai.org>
Date: Sun, 6 Nov 2016 10:46:30 +0100
MIME-Version: 1.0
In-Reply-To: <1676fd7b-a9a1-586a-9ffb-b27fa25c57ab@therobotstudio.com>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] Xenomai for the nVidia Jetson TK1
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Cyril Jourdan <cyril.jourdan@therobotstudio.com>, xenomai@xenomai.org

On 11/03/2016 09:28 AM, Cyril Jourdan wrote:
> Hello,
> 
> I would like to install Xenomai on my Linux kernel (3.10.40) of a Jetson
> TK1 board, is there any specific release for this ARM SoC (Quad-Core
> cortex-A15) ?

Not to my knowledge, but I don't know about every SoC Xenomai supports
anyway, since a lot of custom ports happen on vendor kernels and remain
unpublished.

The task is about porting the latest I-pipe patch published for the 3.10
series to your target vendor kernel, which is not far away from your
reference version:
http://xenomai.org/downloads/ipipe/v3.x/arm/older/ipipe-core-3.10.32-arm-14.patch

-- 
Philippe.

