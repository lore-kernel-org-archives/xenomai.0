Message-ID: <537A2B38.6090304@steinkuehler.net>
Date: Mon, 19 May 2014 11:03:04 -0500
From: Charles Steinkuehler <charles@steinkuehler.net>
MIME-Version: 1.0
References: <537919DE.50303@zultron.com> <53792066.5050909@xenomai.org>
In-Reply-To: <53792066.5050909@xenomai.org>
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Xenomai] Cross-compiling for ARM
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: John Morris <john@zultron.com>, xenomai@xenomai.org

On 5/18/2014 4:04 PM, Gilles Chanteperdrix wrote:
> On 05/18/2014 10:36 PM, John Morris wrote:
>> My Debian kernel packages are just updated to Xenomai 2.6.3 and Linux =

>> 3.8.13 (will ask for testing soon), and I'm starting to look at adding =

>> armhf packages using Robert C Nelson's and Charles Steinkuehler's patch =

>> sets.  However, I'm brand-new at cross-compiling and would appreciate a =

>> pointer.
>>
>> Right out of the box, pbuilder can build in a QEMU-emulated chroot by =

>> setting --arch=3Darmhf and --debootstrap=3Dqemu-debootstrap.  Super easy=
. =

>> Super slow.
>>
>> Is there a way to cross-compile in an x86 native environment so that the =

>> (x86 native) compiler/assembler/linker/etc. cross-build for ARM =

>> architecture?
> =

> You need to install a cross compilation toolchain. You can find =

> pre-built ones, for instance for armhf, you can use the linaro =

> toolchain.

The RCN kernel build scripts (so my scripts as well) will download a
known working linaro cross-compiler if you run on an x86 machine and
don't point the build scripts to a pre-installed tool chain.

Review the scripts/gcc.sh shell script if you need hints on getting the
cross-compiler up and running, but it's pretty straight-forward.

-- =

Charles Steinkuehler
charles@steinkuehler.net

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 261 bytes
Desc: OpenPGP digital signature
URL: <http://www.xenomai.org/pipermail/xenomai/attachments/20140519/9b40e5a=
e/attachment.sig>
