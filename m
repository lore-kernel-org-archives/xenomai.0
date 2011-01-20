Message-ID: <4D38770A.4070404@domain.hid>
Date: Thu, 20 Jan 2011 18:55:22 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <OF1911EB62.67FE0A4E-ONC125781E.0029C740-C125781E.002C4F5B@LocalDomain>	<alpine.DEB.1.10.1101200922440.1211@domain.hid>	<4D384CC9.2040303@domain.hid>	<alpine.DEB.1.10.1101201702340.1990@domain.hid>	<4D386922.5080807@domain.hid>
	<4D3871F1.6020306@domain.hid>
In-Reply-To: <4D3871F1.6020306@domain.hid>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] gpio
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: cagnulein@domain.hid
Cc: xenomai@xenomai.org

Cagnulein wrote:
> I ported a linux environment module implementing gpio handling to
> Xenomai environment.
> Under linux i was able to see /dev/gpio1 and execute echo 1>  /dev/gpio1
> command via bash shell to set the gpio output state.
> Now, under Xenomai, with the RTDM driver developed and loaded I am not
> able to get the gpio1 device.
> Could you help me ?

The fact is that the system services you use to access a RTDM devices
are special services handled by Xenomai RTM skin, they are not usual
Linux services. So, there is no way you can access an RTDM device node
with Linux system calls (which is what echo 1 > /dev/gpio1 does).

Please avoid replying a random thread to post your question, as it
messes up those of us who order mails by threads, and notably the
mailing list archives.

-- 
                                                                Gilles.

