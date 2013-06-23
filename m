Message-ID: <51C6E8D3.3070407@web.de>
Date: Sun, 23 Jun 2013 14:23:47 +0200
From: Jan Kiszka <jan.kiszka@web.de>
MIME-Version: 1.0
References: <51BE2859.8000307@gmail.com> <51BE9E2C.9090204@web.de>
	<51BEDC9B.6040603@gmail.com> <51C54A88.3050003@web.de>
	<51C5F102.8010803@gmail.com> <51C61888.8080004@gmail.com>
In-Reply-To: <51C61888.8080004@gmail.com>
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Xenomai] Problem accessing msg_name in rt_udp_recvmsg
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

On 2013-06-22 23:35, Manuel Huber wrote:
>> Isn't msg->msg_name a user space buffer? Why is it possible to access
>> it from kernel space (Line 424 - 426)? I'm not really familiar with
>> the Linux kernel that much, therefore I checked some other parts of
>> RTnet (ipv4/tcp/tcp.c) and there is something strange as well:
>>
>>     2053     len =3D msg->msg_iov[0].iov_len;
>>     2054     buf =3D msg->msg_iov[0].iov_base;
>>
>> So I'm really getting confused... I mean wouldn't such a bug cause
>> serious problems? I'm running RTnet since months using the recvmsg
>> system call (udp) all the time and never encountered a problem. Sorry
>> ifthis question is somehow stupid, I really tried to figure it out
>> myself...
> Okay, sorry; There is a big difference between Linux and Xenomai most
> probably.Is it possible to access any user-space buffer from Xenomai
> in Primary Mode? What happens when a buffer is to small or invalid?
> Is it a problem to use rtdm_(safe_)copy_to_user in Primary Mode or does
> it only add overhead?

It is possible to access user space memory directly from Xenomai in
primary mode. However, RTnet is known to be buggy here because it
accesses user memory at some spots without using
rtdm_*_copy_to/from_user. This will cause kernel oopses when that memory
is not mapped in or the pointer is invalid.

> =

> Sorry for not paying enough attention in first place, and for asking
> so many questions...
> =


No problem at all!

Jan

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 263 bytes
Desc: OpenPGP digital signature
URL: <http://www.xenomai.org/pipermail/xenomai/attachments/20130623/29f0d5f=
f/attachment.pgp>
