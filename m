References: <51e26820-fb3f-0404-f799-2c87020a211d@gmail.com>
 <ee61ace6-ac6b-ed36-bcbf-9b17add27c09@siemens.com>
From: Edouard Tisserant <edouard.tisserant@gmail.com>
Message-ID: <80b359f3-0a8a-6165-bb0f-4603aed42416@gmail.com>
Date: Tue, 18 Sep 2018 09:33:15 +0200
MIME-Version: 1.0
In-Reply-To: <ee61ace6-ac6b-ed36-bcbf-9b17add27c09@siemens.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Content-Language: en-US
Subject: Re: [Xenomai] [PATCH 0/1] Add non-RT sendmsg and recvmsg in
 rtpacket.
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Jan Kiszka <jan.kiszka@siemens.com>, "Xenomai (xenomai@xenomai.org)" <xenomai@xenomai.org>

Hi Jan,

> Better but not quite yet: Just copy&paste the output of "git
> format-patch --stdout $COMMIT^..$COMMIT" into the email body AND make
> sure line wrapping is off - or use git send-email.

Thanks for telling, I didn't realize my MUA wrecked the patch. I
actually used "git send-email --stdout origin > mail.eml", opened .eml
file with thunderbird, and sent it. I thought that it would have been
preserved this way, but i guess I'll have to setup sendmail.

> Ok, on the content: Why do you need that mechanism? Normally, all your
> RT application threads have a Xenomai shadow that can be used to
> execute RT calls, like send or receive. By not providing the related
> nrt callbacks, a driver signals to the core "migrate the caller to RT
> as needed". If you look at other drivers, they do not have such
> trampolines as well, e.g. the CAN stack or the UARTs.

Indeed. Now that you present it like that, it feels like bit of a hack.

The reason is that EtherLAB master "Idle" thread is a non-real-time
kernel thread, sending Ethernet frames periodically. That kernel thread
found no trampoline when jumping in rtdm_recvmsg, it just got -ENOSYS.
It looks like that from kernel side there is no such an automatic
migration implemented, so I looked around to see what was implementing
such a delegation pattern, and rtpc.c was a good candidate.

Having the "migrate the caller to RT as needed" trampoline for all
rtdm_* non implemented ops.nrt_* calls from kernel space would be
definitely better. Why it is reserved only to userspace apps ? ;)

Edouard


