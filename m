MIME-Version: 1.0
In-Reply-To: <201301190052.19037.paul_c@tuxcnc.org>
References: <CALJOq=VtrBhMzCaT=7omDVN9hnnwZ+cmM1_1eff9DTS-fvLjaw@mail.gmail.com>
	<201301182211.27006.paul_c@tuxcnc.org>
	<CALJOq=Vy2eqfikHRzxwxs=yC4sXp=cChC76Q4ZNfs8GudpSAdg@mail.gmail.com>
	<201301190052.19037.paul_c@tuxcnc.org>
From: Pierre LE COZ <peter.le.coz@gmail.com>
Date: Sat, 19 Jan 2013 11:41:37 +0100
Message-ID: <CALJOq=UhOuExbOd+SLXQahQZi4PL8xrUTo27VQoKNvdUuKbizQ@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Subject: Re: [Xenomai] GPIO Interrupts problem with RTDM
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Paul <paul_c@tuxcnc.org>
Cc: xenomai@xenomai.org

Thanks Paul for suggestions.

Having patched my bcm2708_gpio.c,  I rebuild the kernel and modules.
I added the checks on the return codes and recompiled my own module.

Unfortunately it looks like I still have the same problem, except this
time, I get a return code :

# insmod rpi-rtdm.ko
insmod: can't insert 'rpi-rtdm.ko': Device or resource busy

I could not find it in Documentation/gpio.txt.
I've found someone asking for similar problems. Respondents suggested the
use of at32_select_gpio(), but it's for an other target. So I don't think
this will help.
