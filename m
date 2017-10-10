From: =?utf-8?Q?Christoph_M=C3=BCllner?=
 <christoph.muellner@theobroma-systems.com>
Message-Id: <3C3217CA-4594-4706-BD2D-E631EDF2C225@theobroma-systems.com>
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
Date: Tue, 10 Oct 2017 12:59:50 +0200
In-Reply-To: <1c9bedc6-892d-5624-021d-c47f69a976a8@oss-tech.org>
References: <0FA1B488-7D1D-40E2-A4B6-DE9E04852EAD@theobroma-systems.com>
 <1c9bedc6-892d-5624-021d-c47f69a976a8@oss-tech.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] [I-PIPE] [Patch] IRQ pipelining support for GICv3
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Dmitriy Cherkasov <dmitriy@oss-tech.org>
Cc: xenomai@xenomai.org

Hi Dmitry,

thanks for the hint.
I've attached a new version of the patch including the I-pipe locking and
the forwarding calls for locking/unlocking the IRQ in case of masking/unmasking.

-------------- next part --------------
A non-text attachment was scrubbed...
Name: 0001-ipipe-gicv3-Enable-interrupt-pipelining.patch
Type: application/octet-stream
Size: 3285 bytes
Desc: not available
URL: <http://xenomai.org/pipermail/xenomai/attachments/20171010/3cc04ce6/attachment.obj>
-------------- next part --------------


Thanks,
Christoph

--
Christoph M?llner
Theobroma Systems Design und Consulting GmbH
Seestadtstra?e 27 (Aspern IQ), 1220 Wien, Austria
Phone: +43 1 236 98 93-409, Fax: +43 1 236 98 93-9
http://www.theobroma-systems.com




> On 10 Oct 2017, at 01:10, Dmitriy Cherkasov <dmitriy@oss-tech.org> wrote:
> 
> On 10/09/2017 02:22 AM, Christoph M?llner wrote:
>> Hi Xenomai/I-pipe devs,
>> we have I-pipe/Cobalt/Xenomai running here on a Rockchip RK3399, which is a six core ARMv8/aarch64 SoC.
>> Our current kernel is based on vanilla Linux 4.12.10 and we've applied the I-pipe patches for 4.11-arm64.
>> Of course there were some conflicts, but we managed to resolve them quickly.
>> On top of that we are running Xenomai 3.1 (next) in dual-kernel configuration (Cobalt).
>> xeno-test did not show any errors/fails and we've successfully run latency for more than 72 hours in a row.
>> The RK3399 has an ARM GICv3 interrupt controller. Unfortunately the I-pipe patches don't include
>> support for that controller. Therefore I'd like to contribute a patch for that (see attachment).
>> -------------- next part --------------
>> A non-text attachment was scrubbed...
>> Name: 0001-ipipe-gicv3-Enable-interrupt-pipelining.patch
>> Type: application/octet-stream
>> Size: 1890 bytes
>> Desc: not available
>> URL: <http://xenomai.org/pipermail/xenomai/attachments/20171009/d69b8f01/attachment.obj>
> 
> 
> Shouldn't ipipe_lock/unlock_irq() be added to the mask/unmask functions as well? Otherwise hold/release don't do anything special.
> 
> _______________________________________________
> Xenomai mailing list
> Xenomai@xenomai.org
> https://xenomai.org/mailman/listinfo/xenomai

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 842 bytes
Desc: Message signed with OpenPGP
URL: <http://xenomai.org/pipermail/xenomai/attachments/20171010/3cc04ce6/attachment.sig>
