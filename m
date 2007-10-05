Message-ID: <2ff1a98a0710050124g4fcc1d44m697e17979875bec0@domain.hid>
Date: Fri, 5 Oct 2007 10:24:10 +0200
From: "Gilles Chanteperdrix" <gilles.chanteperdrix@xenomai.org>
In-Reply-To: <200710050756.l957u8tH013063@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <18181.15818.772625.155922@domain.hid>
	<200710050756.l957u8tH013063@domain.hid>
Subject: Re: [Xenomai-help] rt_task crash kernel
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Patrick <kpa_info@domain.hid>
Cc: xenomai@xenomai.org

On 10/5/07, Patrick <kpa_info@domain.hid> wrote:
> I have tried to compile Xenomai 2.3.2 with adeos patch 1.7-03 but the system
> doesn't boot correctly. If I disable RealTime subsystem in kernel
> configuration the system boots right.
>
> I have tried to compile Xenomai 2.3.4 with adeos patch 1.7-01. The system
> boots but when I insert my module the system crashes. Exactly like with the
> 1.7-06.
>
> So I think that the bug is not in adeos patch but in Xenomai ?!?

We already knew that 1.7-02 did not work, so testing 1.7-03 was
useless. Please do not use your module to test, use latency -p 1000.

Now, you also know that I-pipe 2.6.15-1.5-08 works.
Instead of trying the patches one after the other, you should try to
do it the same was as a bisection (dichotomie en francais). That is,
when you have a version n that works and version m that does not work,
try version (n+m)/2. This will converge much faster.

-- 
                                               Gilles Chanteperdrix

