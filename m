Message-ID: <2ff1a98a0805290730m2fb0aa02o50c4b317f83aaa00@domain.hid>
Date: Thu, 29 May 2008 16:30:55 +0200
From: "Gilles Chanteperdrix" <gilles.chanteperdrix@xenomai.org>
In-Reply-To: <51B669A8A7D2914E9AB2B3F40AC6553E646FC7@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <51B669A8A7D2914E9AB2B3F40AC6553E646FC3@domain.hid>
	<2ff1a98a0805290621r361ceb3dh601e41768983fb27@domain.hid>
	<51B669A8A7D2914E9AB2B3F40AC6553E646FC5@domain.hid>
	<2ff1a98a0805290654w33623528yf34c610f11015220@domain.hid>
	<51B669A8A7D2914E9AB2B3F40AC6553E646FC7@domain.hid>
Subject: Re: [Xenomai-help] Xenomai and SDL NET sockets 1.2
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: "Karch, Joshua" <jkarch@domain.hid>
Cc: xenomai@xenomai.org

On Thu, May 29, 2008 at 3:56 PM, Karch, Joshua <jkarch@domain.hid> wrote:
> Gilles,
>
> Any potential problem with MlockAll and dynamically linked in libraries?

No.

>
> The standalone, non Xenomai application works with no hitches.  I
> essentially took the main loop from the net comms program and put it into an
> RT-Task thread object with minimum (1) priority and now it doesn't work.

Since you are able to see the segmentation fault with gdb, why not
using gdb to find the bug ?


-- 
 Gilles

