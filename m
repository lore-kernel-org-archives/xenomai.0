Message-ID: <50571C03.9060507@mediso.hu>
Date: Mon, 17 Sep 2012 14:48:03 +0200
From: Norbert Bukuli <norbert.bukuli@mediso.hu>
MIME-Version: 1.0
References: <5057160B.8050303@xenomai.org>
In-Reply-To: <5057160B.8050303@xenomai.org>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"; Format="flowed"
Subject: [Xenomai] Fwd: Re: kernel compilation with ipipe turned off
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

Hello,

Please read the forwarded message.
Thank you.

-------- Original Message --------
Subject: Re: kernel compilation with ipipe turned off
Date: Mon, 17 Sep 2012 14:22:35 +0200
From: Philippe Gerum <rpm@xenomai.org>
To: Norbert Bukuli <norbert.bukuli@mediso.hu>

On 09/17/2012 01:39 PM, Norbert Bukuli wrote:
> Dear Philippe,
>
> First of all, I don't know whether you are the responsible person for
> the Adeos-ipipe patches, but on the Adeos web page I found your address
> under the contact link. If not, please let me know who is the right perso=
n.

I'm the right guy, but please redirect this info to xenomai.org. Thanks.

>
> Anyway, I found a little compilation problem with the
> adeos-ipipe-3.1.5-powerpc-2.13-06.patch, what is in the xenomai-forege
> sources. The problem appears if I turn off CONFIG_IPIPE:
>
>   CC      arch/powerpc/kernel/cputable.o
> In file included from include/linux/irqflags.h:15:0,
>                  from include/linux/spinlock.h:53,
>                  from include/linux/seqlock.h:29,
>                  from include/linux/time.h:8,
>                  from include/linux/timex.h:56,
>                  from include/linux/sched.h:57,
>                  from arch/powerpc/kernel/cputable.c:14:
> /home/bukulin/munka/gantry/Kernel/src/3/linux-stable/arch/powerpc/include=
/asm/irqflags.h:13:7:
> error: "CONFIG_IPIPE" is not defined [-Werror=3Dundef]
> cc1: all warnings being treated as errors
> make[1]: *** [arch/powerpc/kernel/cputable.o] Error 1
> make: *** [arch/powerpc/kernel] Error 2
>
> For the possible solution please take a look at the attached patch.
>
> I fount that the newer versions of the adeos-ipipe patches
> (adeos-ipipe-3.1.10-powerpc-2.13-08.patch,
> ipipe-core-3.2.21-powerpc-1.patch) are also affected.
>
> If this issue is fixed meanwhile, please ignore this e-mail.
>


-- =

Philippe.

-- =

Best regards,
Norbert Bukuli
-------------- next part --------------
A non-text attachment was scrubbed...
Name: ipipe_off.patch
Type: text/x-patch
Size: 639 bytes
Desc: not available
URL: <http://www.xenomai.org/pipermail/xenomai/attachments/20120917/d51c8c4=
6/attachment.bin>
