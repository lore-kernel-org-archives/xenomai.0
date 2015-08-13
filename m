MIME-Version: 1.0
From: Hongfei Cheng <hongfei@mperpetuo.com>
Date: Thu, 13 Aug 2015 11:51:59 -0700
Message-ID: <CAKC9m6f5Yc7MZHZQO2MRCf+y2nOM7P1psX4fLTeqgE4tsnv+RA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: [Xenomai] I-pipe's determinism in handling hardware interrupts when
 GIC implements "Security Extensions"
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Xenomai Mailing List <xenomai@xenomai.org>

Hi All,

I am wondering (aloud) if anyone has experience running I-pipe on
ARMv7 platform which supports ARM's Security Extensions (TrustZone).

I believe, starting in ARMv7-A/R architecture, ARM added the
(optional) Security Extensions (TrustZone) to provide hardware
security features. Some of the ARM SoCs on the supported list by
Xenomai, such as Freescale QorIQ LS1 and Xilinx Zynq, appear to have
implemented such extensions.

On an ARM SoC platform implementing the Security Extensions -
1). How does the I-pipe/Adeos deal with both the interrupt sources in
"Normal world" (non-secure interrupt) and "Secure world" (secure
interrupt)?
2). What would happen if a Xenomai real-time thread is taking on a
non-secure interrupt while a secure interrupt with higher priviledge
arrives which must be routed to a Linux thread?
3). Since a secure interrupt can take an unbounded amount of time to
complete its task, such as downloading firmware, will it break
I-pipe's determinism in serving non-secure interrupt on behalf of
Xenomai real-time threads?

Thanks,
Hongfei

