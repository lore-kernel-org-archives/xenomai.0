Message-ID: <4D239001.9050604@domain.hid>
Date: Tue, 04 Jan 2011 22:24:17 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <4D233AB4.5070702@domain.hid> <4D2352C9.9050006@domain.hid>
	<4D2377B5.1040807@domain.hid>
	<4D23785B.5050108@domain.hid> <4D2379EF.5@domain.hid>
	<4D237A89.3010205@domain.hid> <4D237CA9.2090408@domain.hid>
	<4D237F62.2030609@domain.hid> <4D2381B6.80304@domain.hid>
	<4D238C56.40906@domain.hid> <4D238EA1.7020409@domain.hid>
In-Reply-To: <4D238EA1.7020409@domain.hid>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] Xenomai failure
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Tamas Szklenar <tszklenar@domain.hid>
Cc: xenomai@xenomai.org

Tamas Szklenar wrote:
> Hi Gilles,
> 
> I configured an other computer two weeks ago. That machine is much older 
> but has the same kernel (2.6.35.7) and the same version of Xenomai 
> (2.5.5.2) like the current computer.
> The only difference is the hardware and the Debian version (Lenny vs. 
> Squezze). Is Xenomai running on Debian squezze? Have you any experience 
> with it?

The distribution does not matter, the failing initialization takes place
in the kernel, without any support from the distribution. So, this is
either a kernel configuration issue, or a hardware issue.

Could you show us the result of the command:
cat /proc/timer_list

After booting the failing machine + xenomai combination?

-- 
                                                                Gilles.

