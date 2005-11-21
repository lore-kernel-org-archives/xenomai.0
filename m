Message-ID: <4381AE89.4070103@domain.hid>
Date: Mon, 21 Nov 2005 12:24:57 +0100
From: =?ISO-8859-1?Q?Ignacio_Garc=EDa_P=E9rez?= <iggarpe@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-help] pipe fun
References: <OF0501B44D.C5684C78-ONC12570C0.003940CB-C12570C0.003B0127@domain.hid>
In-Reply-To: <OF0501B44D.C5684C78-ONC12570C0.003940CB-C12570C0.003B0127@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Dmitry Adamushko <dmitry.adamushko@domain.hid>
Cc: xenomai@xenomai.org

Dmitry Adamushko wrote:

>            /* Return buffer is too small - message is lost. */
>            ret = -ENOSPC; <---- That's the error you are getting.
>
Maybe "No space left on device" is a bit misleading. Wouldn't ENOMEM fit
better? (or event EINVAL)


