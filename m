Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Date: Sun, 11 Nov 2007 13:46:32 -0700
Message-ID: <51CAD0CE1504444DBE77CBBE51A0135D3285CB@slcmail.slc.mew.int>
In-Reply-To: <47373710.1030400@domain.hid>
References: <51CAD0CE1504444DBE77CBBE51A0135D3285C8@domain.hid>
	<51CAD0CE1504444DBE77CBBE51A0135D3285C9@domain.hid>
	<47373710.1030400@domain.hid>
From: "Steven Seeger" <sseeger@domain.hid>
Subject: Re: [Xenomai-help] more geode issues
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

The select problem is now fixed running 2.6.22.2 and trunk (3174.)
However, I now notice that with this combination I see that the cursor
blinks very fast when I load the nucleus. However, when I load native it
runs fine. I am not saying that this is a new condition... I may have
not tested it by only loading nucleus.=20

On 2.6.22.2, if I load native it fixes the fast interrupt problem. On
2.6.23, the interrupts slow down by a factor of 10. Unloading
xeno_native on both systems yields correct interrupt behavior even with
the nucleus loaded.

Steven


