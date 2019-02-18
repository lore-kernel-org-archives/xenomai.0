Date: Mon, 18 Feb 2019 07:08:55 -0600 (CST)
From: Per Oberg <pero@wolfram.com>
Message-ID: <731343616.4059321.1550495335135.JavaMail.zimbra@wolfram.com>
In-Reply-To: <f51b37b7-4293-4b29-6d78-3eb460de3015@siemens.com>
References: <1798013633.4056474.1550493375498.JavaMail.zimbra@wolfram.com>
 <f51b37b7-4293-4b29-6d78-3eb460de3015@siemens.com>
Subject: Re: Cyclic hardware reset for e1000e
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


----- Den 18 feb 2019, p=C3=A5 kl 13:43, Jan Kiszka jan.kiszka@siemens.com =
skrev:

> On 18.02.19 13:36, Per Oberg via Xenomai wrote:
> > Hello list

>> I have this issue where my e1000e network card gets into some kind of cy=
clic
>> hardware reset during operation. The weird thing is that this only happe=
ns when
>> I let systemd start the application. If it's started manually it always =
works
> > as intended.

>> I am running xenomai 3.0.7 with a linux-4.9.38 kernel and I use the netw=
ork
> > connection in Linux non-rt mode. I use systemd and NetworkManager.

>> I do realize that once I get into the reset it will continue resetting b=
ecause I
>> keep flooding the buffers. My issue is that it -never- happens when I st=
art my
>> process manually, only when systemd starts it. Because the network goes =
down
>> quite badly I cannot log in and disable the service once it happens and
>> therefore I cannot really try starting it manually after letting the net=
work
> > recover.

>> There is some information from intel in [1] below. There is talk about p=
ower
> > management function and EPROM etc. They specifically write:

> > "82573(V/L/E) TX Unit Hang Messages
>> Several adapters with the 82573 chipset display "TX unit hang" messages =
during
>> normal operation with the e1000 driver. The issue appears both with TSO =
enabled
>> and disabled, and is caused by a power management function that is enabl=
ed in
>> the EEPROM. Early releases of the chipsets to vendors had the EEPROM bit=
 that
>> enabled the feature. After the issue was discovered newer adapters were
> > released with the feature disabled in the EEPROM."


> > I also read something about disabling GRO/TSO/GSO that helped some peop=
le.

> > My questions to the list are:

> > 1. Have you guys any experience with this?
> > 2. Would I be better of using the RT Net drivers?
>> 3. What could cause the issue to trigger only when run by systemd. (I th=
ought
> > about timing issues and NetworkManager, but how do I debug this?)

>> [1]
> > https://serverfault.com/questions/193114/linux-e1000e-intel-networking-=
driver-problems-galore-where-do-i-start

> > Thoughts anyone?

> Are you giving Linux enough time to work (no 100% RT domination of any co=
re for
> hundreds of milliseconds or longer)?

I am not sure, yet. I have this logging function for reporting back to me w=
hen I loose samples. Loosing samples would currently make the software try =
to catch up and this would mean 100% cpu till it does. I do see this being =
logged around the time it resets but I'm not sure if it's much worse than "=
usual". If for some reason the hardware reset happens because linux gets st=
arved I can easily see this going cyclic.

Per =C3=96berg=20

