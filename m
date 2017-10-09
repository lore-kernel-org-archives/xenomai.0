References: <0FA1B488-7D1D-40E2-A4B6-DE9E04852EAD@theobroma-systems.com>
From: Dmitriy Cherkasov <dmitriy@oss-tech.org>
Message-ID: <1c9bedc6-892d-5624-021d-c47f69a976a8@oss-tech.org>
Date: Mon, 9 Oct 2017 16:10:52 -0700
MIME-Version: 1.0
In-Reply-To: <0FA1B488-7D1D-40E2-A4B6-DE9E04852EAD@theobroma-systems.com>
Content-Type: text/plain; charset="windows-1252"; format="flowed"
Content-Language: en-GB
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Xenomai] [I-PIPE] [Patch] IRQ pipelining support for GICv3
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

On 10/09/2017 02:22 AM, Christoph M=FCllner wrote:
> Hi Xenomai/I-pipe devs,
>=20
> we have I-pipe/Cobalt/Xenomai running here on a Rockchip RK3399, which is=
 a six core ARMv8/aarch64 SoC.
> Our current kernel is based on vanilla Linux 4.12.10 and we've applied th=
e I-pipe patches for 4.11-arm64.
> Of course there were some conflicts, but we managed to resolve them quick=
ly.
> On top of that we are running Xenomai 3.1 (next) in dual-kernel configura=
tion (Cobalt).
> xeno-test did not show any errors/fails and we've successfully run latenc=
y for more than 72 hours in a row.
>=20
> The RK3399 has an ARM GICv3 interrupt controller. Unfortunately the I-pip=
e patches don't include
> support for that controller. Therefore I'd like to contribute a patch for=
 that (see attachment).
>=20
> -------------- next part --------------
> A non-text attachment was scrubbed...
> Name: 0001-ipipe-gicv3-Enable-interrupt-pipelining.patch
> Type: application/octet-stream
> Size: 1890 bytes
> Desc: not available
> URL: <http://xenomai.org/pipermail/xenomai/attachments/20171009/d69b8f01/=
attachment.obj>


Shouldn't ipipe_lock/unlock_irq() be added to the mask/unmask functions as =
well?=20
Otherwise hold/release don't do anything special.

