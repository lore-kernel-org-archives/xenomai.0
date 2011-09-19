Message-ID: <4E76F6AD.5070501@domain.hid>
Date: Mon, 19 Sep 2011 10:00:45 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <4E76DB36.5060203@domain.hid>
	<21788_1316418497_4E76F3C1_21788_13255_1_ECB646CBB62FD044927FDEDF0252D3E701E39310098B@THSONEA01CMS03P.one.grp>
In-Reply-To: <21788_1316418497_4E76F3C1_21788_13255_1_ECB646CBB62FD044927FDEDF0252D3E701E39310098B@THSONEA01CMS03P.one.grp>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] Can a network freeze caused by Xenomai ?
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: VEYSSIERE Nicolas <nicolas.veyssiere@domain.hid>
Cc: Xenomai help <xenomai@xenomai.org>

On 09/19/2011 09:49 AM, VEYSSIERE Nicolas wrote:
> Hello,
> 
> I would like to know if it is possible that a network freeze been
> caused by the use of Xenomai ?
> 
> Here is my problem : we have 4 HP DL 360 G6 server. All are installed
> with the last update of Redhat Entreprise Linux 5.6.
> 
> All 4 have 4 physical ethernet interface (2 from intel chipset, 2
> from broadcom chipset).
> 
> They all have a virtual ethernet interface on eth0 (named eth0:1).
> 
> 2 of them have Xenomai installed (v2.5.5.2 with linux kernel
> v2.6.35.7).
> 
> 
> The problem is : on 1 with Xenomai installed, (the other one is not
> running for the moment), and we regularly have 'network freeze', we
> can't ping it, it can't reach other computers, and we have to restart
> the OS.
> 
> 
> Any help is welcome.

Do you have the same issue with the latest stable release (v2.5.6)? If
yes, please try and capture the kernel logs from the boot, up to the
bug, via serial console, or via netconsole (but seeing the bug you
describe, serial console is a better idea).

-- 
					    Gilles.

