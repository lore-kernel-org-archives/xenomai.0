Message-ID: <4AF15548.5010308@domain.hid>
Date: Wed, 04 Nov 2009 11:19:52 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <4AEEA9AF.5030302@domain.hid>
In-Reply-To: <4AEEA9AF.5030302@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-core] [PATCH] bug found in psos queue
List-Id: Xenomai life and development <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Alexandre Coffignal <alexandre.coffignal@domain.hid>
Cc: xenomai@xenomai.org

Alexandre Coffignal wrote:
> Hello all,
> 
> I found a bug in xenomai-2.4/src/skins/psos+/queue.c,
> in function q_vreceive, struct modifier is not corectly fill with
> argument data.
> 
> Here the patch to fix this bug

Thanks for the patch. But we can not accept a patch of the CREDITS file:
appear in this file people which do contribute regularly. However, if
you send a patch in the usual git format (as produced by
git-format-patch), the patch will be credited to you in the git logs.

So, please resend.
Regard.

-- 
                                          Gilles


