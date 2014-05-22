From: "Lim Tao Ming (SIMTech)" <tmlim@simtech.a-star.edu.sg>
Date: Thu, 22 May 2014 10:40:23 +0000
Message-ID: <EF7485C1EA725C47A37C7090FD7DDF78442128BC@S3-EXCHMB05.shared-svc.local>
References: <mailman.3.1398938401.5042.xenomai@xenomai.org>
In-Reply-To: <mailman.3.1398938401.5042.xenomai@xenomai.org>
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: Re: [Xenomai] Xenomai Digest, Vol 25,
 Issue 1 ( ipipe-core-3.10 patch for arm)
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: "xenomai@xenomai.org" <xenomai@xenomai.org>

> Hello,
>
> I saw from your past discussion that there is a patch for kernel=20
> version 3.10 but was not released. It just so happened that the=20
> provided kernel source code with support for my hardware is always=20
> released with version sublevel=3D0 (i.e. 3.10 but not 3.10.18 or=20
> 3.10.32). Can I get this patch from you to try out xenomai? BTW I am a=20
> newbie at this and I've tried patching the 3.10 source code using the=20
> 3.10.18 and 3.10.32 patches without success.

A simple solution is to apply the 3.10.18 stable patch to your vendor kerne=
l based on 3.10.0, then apply the I-pipe patch.

--=20
					    Gilles.

Hello again,

Sorry for not giving more info earlier... I am using the Atmel's SAMA5D3 AR=
M hardware.

I've tried your suggestion (thanks!) and it patched successfully but the co=
mpilation now says that AT91 is not supported. So I thought I should look a=
t the patches provided by the latest xenomai stable release

FYI the hardware's supported linux kernel versions are 2.6.39, 3.4.9, 3.6.9=
, 3.10, 3.15 and xenomai's supported ones are 3.4.6, 3.5.7, 3.8.13. I tried=
 with kernel version 3.4.9, did a reverse patch to the base 3.4, patch it t=
o 3.4.6 and used the xenomai I-pipe patch for 3.4.6. Unfortunately the xeno=
mai failed to patch vmalloc.c. Am I doing things correctly and do you have =
any suggestions to resolve this?=20

Thanks and best regards
TM

