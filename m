From: "Zemskov, Evgeny" <Evgeny.Zemskov@transas.com>
Date: Fri, 18 Oct 2013 10:29:01 +0000
Message-ID: <FA4CEC4EBE2FA145A7663764A1CCB31ED4275E9E@VOITV-EXCH-BE02.transas.com>
References: <FA4CEC4EBE2FA145A7663764A1CCB31EC74CB0DA@VOITV-EXCH-BE02.transas.com>,
	<5256B03C.8080909@xenomai.org>
	<FA4CEC4EBE2FA145A7663764A1CCB31EC74CB2AE@VOITV-EXCH-BE02.transas.com>,
	<52581527.2040508@xenomai.org>
In-Reply-To: <52581527.2040508@xenomai.org>
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: Re: [Xenomai] Kernel 2.6.32 patched with xenomai 2.6.0 and 2.6.3
 crashes on a Core i5 / QM77 system
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: "xenomai@xenomai.org" <xenomai@xenomai.org>

On 10/11/2013 04:42 PM, Zemskov, Evgeny wrote:
> On 10/10/2013 01:57 PM, Zemskov, Evgeny wrote:
>> Greetings !
>>
>> I'm trying to run Xenomai system on an industrial computer with
>> Core i5-3610ME 2.70GHz and 8Gb RAM on QM 77 chipset.
>>
>> Any attempts to boot xenomai-patched kernel fail with a stack stace stat=
ed below.
>> I've tried vanilla kernel 2.6.32 patched with Xenomai 2.6.0 and 2.6.3 (A=
deos 2.7-03).
>> Xenomai 2.6.0 works fine on a number of other machines with Pentium4, Co=
de 2 Duo and Core i7.
>>
>> Regretably, we are unable to try use newer kernels (2.6.38 or 3.x) and A=
deos versions,
>> since we're bound to a certified distrubution of Linux with 2.6.32 kerne=
l.
>>
>> Any suggestions are wery welcome.
>
> Could you try a recent kernel, just to see if the issue is still there?
> Could you also try to compile your kernel as a 64 bits kernel?
>
> --
>                                              Gilles.
>
> Tried to build 2.6.32 patched with 2.6.3 and Adeos 2.7-03 as x64;
> The result crashed with the same stack trace (although I can't verify tha=
t I've built a proper x64 kernel).
> Experiments with recent kernels are delayed, cause I can't boot my distri=
bution and waiting for a reaction of its vendor.

If the problem is with the devices nodes creation, you can enable
devtmpfs in recent kernels to get the behaviour you had with devfs,
prior to udev.

--
                                            Gilles.

I believe that devtmpfs was enabled by default in all kernel configuration =
I've tried; in .config it looks like :
>CONFIG_DEVTMPFS=3Dy
>CONFIG_DEVTMPFS_MOUNT=3Dy

Anyway, latest Ubuntu 13.04 with 3.8.0 kernel patched with latest adeos (ip=
ipe-core-3.8-x86-1.patch) and built in 32-bit mode seems to boot and work f=
ine with our problematic hardware.

Eugene

