Message-ID: <4F21D1DA.1090803@domain.hid>
Date: Thu, 26 Jan 2012 23:21:14 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <CAL0cVRD26O9Z+afvp0NGQp3qHaAKk-2Cz+dwygZXcD_30HVyDQ@mail.gmail.com>	<4F2026B6.8080008@domain.hid>	<4F20408E.4080001@domain.hid>	<CAL0cVRBM615h_tFjYXtZ8Bo8-o0rzW4xxgiqsez+GfxkLdU-1w@domain.hid>	<4F211198.804@domain.hid>
	<CAL0cVRDCZaBMDcTJaHRb85urJmUG3u4Xa9hWJqGXeGEXTC_=2A@mail.gmail.com>
In-Reply-To: <CAL0cVRDCZaBMDcTJaHRb85urJmUG3u4Xa9hWJqGXeGEXTC_=2A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] Xenomai and Pandaboard
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Christopher Roberts <adrath@domain.hid>
Cc: Xenomai help <xenomai@xenomai.org>

On 01/26/2012 11:17 PM, Christopher Roberts wrote:
> Im sorry that I keep bothering you with what appears to be really trivial
> problems, but Ive hit another snag after doing what you suggested above. I
> think it might be driver related, but I installed the modules that where
> built with the kernel, so I'm not sure how else to troubleshoot this. Heres
> the log of the kernel booting to where it halts.

Please keep the communications on the list. As I already suggested, if
the kernel does not boot with xenomai enabled, please try disabling
CONFIG_XENOMAI, and if it still does not work, try disabling CONFIG_IPIPE.


-- 
                                                                Gilles.

