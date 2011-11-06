Message-ID: <4EB6F17F.2000304@domain.hid>
Date: Sun, 06 Nov 2011 21:43:43 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <4EB6CA3B.1040608@domain.hid>	<4EB6CB8A.2020303@domain.hid>	<4EB6CDB0.6070306@domain.hid>	<4EB6D11A.6070008@domain.hid>	<4EB6D2A4.2020102@domain.hid>	<4EB6D941.7080206@domain.hid>	<4EB6DA0E.9070802@domain.hid>	<4EB6E5FB.3010809@domain.hid>	<4EB6E7E5.3070303@domain.hid>
	<4EB6ECA8.8080806@domain.hid>	<4EB6EDBB.1060707@domain.hid>
	<4EB6EFFA.6060103@domain.hid>
In-Reply-To: <4EB6EFFA.6060103@domain.hid>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] Xenomai 2.6.0 - kernel seg faults on AT91
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: at91_enthus <nwromania@domain.hid>
Cc: xenomai@xenomai.org

On 11/06/2011 09:37 PM, at91_enthus wrote:
> Just switched "sh" to "bash" in rc.local.
> It simply works. I booted the board 3 times with no issues.

Yes, maybe sh does something which causes an anomaly. But the issue is
not sh itself, it is the anomaly it causes. Anything done by a
user-space program should not cause a kernel panic.

-- 
                                                                Gilles.

