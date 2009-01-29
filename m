Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Date: Thu, 29 Jan 2009 15:05:06 -0700
Message-ID: <51CAD0CE1504444DBE77CBBE51A0135D590A88@domain.hid>
In-Reply-To: <498226CC.1020504@domain.hid>
References: <51CAD0CE1504444DBE77CBBE51A0135D590A7C@slcmail.slc.mew.int>
	<498226CC.1020504@domain.hid>
From: "Steven Seeger" <sseeger@domain.hid>
Subject: Re: [Xenomai-help] xnpod_schedule 2.4.6.1
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: rpm@xenomai.org
Cc: xenomai@xenomai.org

> There is a Xenomai to Linux context switch in between, and the nklock
> was indeed
> released in that case. This code is correct.

Thanks for letting me know. I am inspecting things and trying to
understand what happens in Xenomai so I can help debug the FPU issue we
are still having. I noticed on the RTAI mailing list there was another
user with my board who had the same problem with LXRT. It looks like
geodes do something weird.

Steven


