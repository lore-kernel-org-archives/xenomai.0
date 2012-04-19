Message-ID: <4F8FE4B0.7040902@domain.hid>
Date: Thu, 19 Apr 2012 12:10:56 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <4F8FE2A9.8080303@domain.hid>
In-Reply-To: <4F8FE2A9.8080303@domain.hid>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-core] IMX25 timer access patch
List-Id: Xenomai life and development <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Michael Trimarchi <trimarchi@domain.hid>
Cc: Xenomai core <Xenomai-core@domain.hid>

On 04/19/2012 12:02 PM, Michael Trimarchi wrote:
> Hi,
> 
> I will send a proper patch. Is it possible to include in the ipipe-arm branch?

Please use the public mailing lists.

What exactly are you trying to fix ? What version of kernel ? The
ipipe-arm kernels are compile-tested, so, the code as is is correct
(except that maybe I did not compile-test imx25). If what you are trying
to fix is compilation for non-vanilla kernels, then the answer is no,
the ipipe-arm branches only support vanilla kernels.

-- 
					    Gilles.

