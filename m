Message-ID: <4F1C5BE7.9080302@domain.hid>
Date: Sun, 22 Jan 2012 19:56:39 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <4F184B4E.9040505@domain.hid>
In-Reply-To: <4F184B4E.9040505@domain.hid>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-core] [PATCH] nucleus: Fix relaxed owner check
List-Id: Xenomai life and development <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Jan Kiszka <jan.kiszka@domain.hid>
Cc: xenomai-core <xenomai@xenomai.org>

On 01/19/2012 05:56 PM, Jan Kiszka wrote:
> Fix a logic inversion introduced by b75cec1938. This both allows the
> relaxed-owner check to work again and prevents that we enter an endless
> signal storm if XNSWREP happens to be set already at this point (as seen
> in the field).

Applied, thanks.


-- 
                                                                Gilles.

