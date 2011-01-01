Message-ID: <4D1FA974.8090803@domain.hid>
Date: Sat, 01 Jan 2011 23:23:48 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <AANLkTim+BeV2q5stB-ErSVqF9Oy5BJTHtZF29aPN1c6w@domain.hid>
In-Reply-To: <AANLkTim+BeV2q5stB-ErSVqF9Oy5BJTHtZF29aPN1c6w@domain.hid>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] PCI1711 Rtdm driver reading and writing error
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: adilkaraoz <adilkaraoz@domain.hid>
Cc: xenomai@xenomai.org

adilkaraoz wrote:
> I am writing rtdm driver for PCI1711 card. I got base adress and configured
> it. But when I write digtal output or Dac, I can't see changes at those
> registers. My Code is below please help me.

Is this issue really related to Xenomai? Do you get a different
behaviour if you try writing to these registers in a plain Linux driver?
I doubt it, and you do not give us any clue on what the system you are
running. Please do not bother sending more information unless you have
verified that the issue is specific to Xenomai.

Anyway, if I were you, I would check if the physical address correct
passed to ioremap is the corrrect one. That is print it, and look if it
is what should be expected (if you have a working Linux driver for this
hardware, the physical address should be the same).
The mask with 0xfffffff0 looks suspicious, if the system is x86_64, it
will not only mask the 4 lower bits, it will also mask the 32 upper bits.

-- 
                                                                Gilles.

