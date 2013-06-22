Message-ID: <51C54A88.3050003@web.de>
Date: Sat, 22 Jun 2013 08:56:08 +0200
From: Jan Kiszka <jan.kiszka@web.de>
MIME-Version: 1.0
References: <51BE2859.8000307@gmail.com> <51BE9E2C.9090204@web.de>
	<51BEDC9B.6040603@gmail.com>
In-Reply-To: <51BEDC9B.6040603@gmail.com>
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Xenomai] rtdm: minimal patch for sys_rtdm_recvmsg
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Manuel Huber <manuel.h87@gmail.com>
Cc: xenomai@xenomai.org

On 2013-06-17 11:53, Manuel Huber wrote:
>> Please post patches inline, makes reviewing easier. The explanatory
>> part, like above, can be put after the "---" so that it won't show up in
>> the commit log.
> Oh, sorry; I forgot to send it plain-text...
> =

>> Let's just only copy back what can change, msg_flags and msg_controllen,
>> just like the kernel does.
> I have already implemented a version that does that, but then I looked at
> rt_udp_recvmsg implementation (stack/ipv4/udp/udp.c) and saw that it also
> sets msg_namelen field. This member will never be used in RTnet source
> code, so I think it should be copied back to the user...
> I mean it seems a little useless, because the user has to know the struct=
ur
> anyway; I'm not sure if code really relies on this behaviour....
> =

> So if it's necessary to write back the msg_namelen field, I would need 3
> __xn_put_user calls. I just though it looks ugly and probably does worse
> then a single __xn_copy_to_user call.
> =

> Do you think it's necessary to write back msg_namelen? Because otherwise
> I would definitely prefer using __xn_put_user twice.
> =


I think you stumbled over one of the very old and broken edges of RTnet.
It really makes no sense to copy namelen back. Rather, RTnet should
check msg_namelen before blindly copying the address into the msg_name
buffer.

Jan


-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 263 bytes
Desc: OpenPGP digital signature
URL: <http://www.xenomai.org/pipermail/xenomai/attachments/20130622/5d6c982=
e/attachment.pgp>
