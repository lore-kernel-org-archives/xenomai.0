Message-ID: <49109BA5.6040107@domain.hid>
Date: Tue, 04 Nov 2008 19:59:49 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <51CAD0CE1504444DBE77CBBE51A0135D533259@domain.hid>	<490ECE11.208@domain.hid>	<51CAD0CE1504444DBE77CBBE51A0135D53325A@slcmail.slc.mew.int>	<490F2F23.2080307@domain.hid>	<67b6b3430811031237v4cfba0c9sf63e40a697f3da58@domain.hid>	<49101BFF.3060908@domain.hid>	<51CAD0CE1504444DBE77CBBE51A0135D5332B4@domain.hid>
	<67b6b3430811040929xe679a22k1c0f0dc3163452b1@domain.hid>
In-Reply-To: <67b6b3430811040929xe679a22k1c0f0dc3163452b1@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] fpu context switch issue
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Mark Saiia <mark.saiia@domain.hid>
Cc: xenomai@xenomai.org

Mark Saiia wrote:
> I've noticed the same erroneous behavior when CONFIG_XENO_HW_FPU is enabled
> and when it is disabled.  I don't know if this information is relevant or
> not.  Is this expected behavior?

No, it should not happen when disabled, you should see messages saying
"Invalid use of FPU in Xenomai context at xxxxxx" on the kernel console.
That is probably another bug. Is it possible for you to run your example
without Xenomai at all ? Just to be sure that we do not hit a Linux bug.

-- 
					    Gilles.

