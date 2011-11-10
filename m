Message-ID: <4EBBE367.1000806@domain.hid>
Date: Thu, 10 Nov 2011 15:44:55 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <2AB71B0EA2424A6C953F1BA9E4D51A79@domain.hid>
	<4EBB9104.2040203@domain.hid>
	<49264DA96DC4430AADFD3D442E1F2FBC@TerryHP>
In-Reply-To: <49264DA96DC4430AADFD3D442E1F2FBC@TerryHP>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] Xenomai test progs segfault
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Terry Fryar <terry.fryar@domain.hid>
Cc: Xenomai help <xenomai@xenomai.org>

On 11/10/2011 03:04 PM, Terry Fryar wrote:
> Whoops...no, I was using 2.5.6...I'll switch to 2.6.0 and see what happens.
> Also, I've been wondering if my FPU flags were consistent between my
> kernel/xenomai builds...I need to double check that also I think?

In user-space the choice is either soft-float, or hard-float with VFP.
If you want hard-float with VFP, you need CONFIG_VFP in kernel
configuration, but it is probably enabled by default. For use of VFP by
real-time threads, you need CONFIG_XENO_HW_FPU, which should be enabled
by default as well.

Please no private mails.

-- 
					    Gilles.

