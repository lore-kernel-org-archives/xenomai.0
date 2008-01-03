Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Date: Thu, 3 Jan 2008 19:40:19 +0100
Message-ID: <0B45E93C5FF65740AEAE690BF3848B7A4AB2FF@rennsmail04.eu.thmulti.com>
From: "Fillod Stephane" <stephane.fillod@domain.hid>
Subject: Re: [Xenomai-help] RTDM mmap and DMA
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: xenomai-help <xenomai@xenomai.org>

Gilles Chanteperdrix wrote:
[...]
> Ok. I merged the patch I sent, as well as this patch (fixed to make
> rt_heap_inquire a hyperlink) in trunk. However, I did not commit it in
> the v2.[34].x branch, since it is a patch which breaks the ABI (size
of
> the rt_heap_info structure changes). Should I increment the ABI
revision
?

Albeit it is a minor ABI break, I guess this is the policy expected by=20
Xenomai dev.

> Beware: your mailer broke your patch by adding a newline. It may be a
> better idea to send the patch as a plain text attachment, it avoids
such
> surprises. I have already seen a site explaining how to teach your
> mailer not to do this, but I do not have the URL at hand.

Sorry about that. My MUA is a corporate crap, not even able to respect
the References: field. I'll make sure to always use attached files in
the future.
--=20
Stephane

