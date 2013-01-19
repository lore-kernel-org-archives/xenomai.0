From: Paul <paul_c@tuxcnc.org>
Date: Sat, 19 Jan 2013 12:35:11 +0000
References: <CALJOq=VtrBhMzCaT=7omDVN9hnnwZ+cmM1_1eff9DTS-fvLjaw@mail.gmail.com>
	<201301190052.19037.paul_c@tuxcnc.org>
	<CALJOq=UhOuExbOd+SLXQahQZi4PL8xrUTo27VQoKNvdUuKbizQ@mail.gmail.com>
In-Reply-To: <CALJOq=UhOuExbOd+SLXQahQZi4PL8xrUTo27VQoKNvdUuKbizQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <201301191235.11402.paul_c@tuxcnc.org>
Subject: Re: [Xenomai] GPIO Interrupts problem with RTDM
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Pierre LE COZ <peter.le.coz@gmail.com>
Cc: xenomai@xenomai.org

On Saturday 19 January 2013, Pierre LE COZ wrote:
> Unfortunately it looks like I still have the same problem, except
> this time, I get a return code :
>
> # insmod rpi-rtdm.ko
> insmod: can't insert 'rpi-rtdm.ko': Device or resource busy

Add some debug messages in the areas you request resources and then use 
dmesg - The most likely source of error is either attempting to use a 
resource that has been claimed or not releasing when you have finished 
with it.

Went through the same exercise last week and generated a simple kernel 
module to demonstrate the use of interrupts with Xenomai native & rtdm 
skins.

> I could not find it in Documentation/gpio.txt.
> I've found someone asking for similar problems. Respondents suggested
> the use of at32_select_gpio(), but it's for an other target. So I
> don't think this will help.

The response is wrong on several levels, aside from using a function 
that is not exported, it relies on an architecture dependant call. Use 
the standard gpio lib (see Documentation/gpio.text).


Regards, Paul

