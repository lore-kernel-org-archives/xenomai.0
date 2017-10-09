From: =?utf-8?Q?Christoph_M=C3=BCllner?=
 <christoph.muellner@theobroma-systems.com>
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
Message-Id: <0FA1B488-7D1D-40E2-A4B6-DE9E04852EAD@theobroma-systems.com>
Date: Mon, 9 Oct 2017 11:22:57 +0200
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Subject: [Xenomai] [I-PIPE] [Patch] IRQ pipelining support for GICv3
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

Hi Xenomai/I-pipe devs,

we have I-pipe/Cobalt/Xenomai running here on a Rockchip RK3399, which is a six core ARMv8/aarch64 SoC.
Our current kernel is based on vanilla Linux 4.12.10 and we've applied the I-pipe patches for 4.11-arm64.
Of course there were some conflicts, but we managed to resolve them quickly.
On top of that we are running Xenomai 3.1 (next) in dual-kernel configuration (Cobalt).
xeno-test did not show any errors/fails and we've successfully run latency for more than 72 hours in a row.

The RK3399 has an ARM GICv3 interrupt controller. Unfortunately the I-pipe patches don't include
support for that controller. Therefore I'd like to contribute a patch for that (see attachment).

-------------- next part --------------
A non-text attachment was scrubbed...
Name: 0001-ipipe-gicv3-Enable-interrupt-pipelining.patch
Type: application/octet-stream
Size: 1890 bytes
Desc: not available
URL: <http://xenomai.org/pipermail/xenomai/attachments/20171009/d69b8f01/attachment.obj>
-------------- next part --------------


Thanks,
Christoph

--
Christoph M?llner
Theobroma Systems Design und Consulting GmbH
Seestadtstra?e 27 (Aspern IQ), 1220 Wien, Austria
Phone: +43 1 236 98 93-409, Fax: +43 1 236 98 93-9
http://www.theobroma-systems.com




-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 842 bytes
Desc: Message signed with OpenPGP
URL: <http://xenomai.org/pipermail/xenomai/attachments/20171009/d69b8f01/attachment.sig>
