Date: Mon, 18 Feb 2019 06:36:15 -0600 (CST)
From: Per Oberg <pero@wolfram.com>
Message-ID: <1798013633.4056474.1550493375498.JavaMail.zimbra@wolfram.com>
Subject: Cyclic hardware reset for e1000e
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai <xenomai@xenomai.org>

Hello list

I have this issue where my e1000e network card gets into some kind of cycli=
c hardware reset during operation. The weird thing is that this only happen=
s when I let systemd start the application. If it's started manually it alw=
ays works as intended.=20

I am running  xenomai 3.0.7 with a linux-4.9.38 kernel and I use the networ=
k connection in Linux non-rt mode. I use systemd and NetworkManager.

I do realize that once I get into the reset it will continue resetting beca=
use I keep flooding the buffers. My issue is that it -never- happens when I=
 start my process manually, only when systemd starts it. Because the networ=
k goes down quite badly I cannot log in and disable the service once it hap=
pens and therefore I cannot really try starting it manually after letting t=
he network recover. =20

There is some information from intel in [1] below. There is talk about powe=
r management function and EPROM etc. They specifically write:=20

"82573(V/L/E) TX Unit Hang Messages
Several adapters with the 82573 chipset display "TX unit hang" messages dur=
ing normal operation with the e1000 driver. The issue appears both with TSO=
 enabled and disabled, and is caused by a power management function that is=
 enabled in the EEPROM. Early releases of the chipsets to vendors had the E=
EPROM bit that enabled the feature. After the issue was discovered newer ad=
apters were released with the feature disabled in the EEPROM."


I also read something about disabling GRO/TSO/GSO that helped some people.=
=20

My questions to the list are:=20

1. Have you guys any experience with this?
2. Would I be better of using the RT Net drivers?
3. What could cause the issue to trigger only when run by systemd. (I thoug=
ht about timing issues and NetworkManager, but how do I debug this?)

[1] https://serverfault.com/questions/193114/linux-e1000e-intel-networking-=
driver-problems-galore-where-do-i-start

Thoughts anyone?

Regards
Per =C3=96berg=20

