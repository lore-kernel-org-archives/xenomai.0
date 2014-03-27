From: Paul <paul_c@tuxcnc.org>
Date: Thu, 27 Mar 2014 11:18:45 +0000
References: <CAK4EZFTBCxVWrbMS9DTnR72bcVnSkrkEDCfCZye4u-BREFGoBg@mail.gmail.com>
 <5332A14F.2070303@xenomai.org>
 <CAK4EZFSWuzPgQ8QWn8tY8Wpmojca+vgezSkFMXsS13kBOx7qsA@mail.gmail.com>
In-Reply-To: <CAK4EZFSWuzPgQ8QWn8tY8Wpmojca+vgezSkFMXsS13kBOx7qsA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <201403271118.45617.paul_c@tuxcnc.org>
Subject: Re: [Xenomai] Raspberry Pi Xenomai Linux + Minimal Raspian Net
	Install Guide
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org


Going to highlight a couple of issues:

On Wednesday 26 March 2014, Adam Vaughan wrote:
> So its all in one place, I've also attached is an updated guide for
> minimal Raspbian and Xenomai with the attached patch. 

> ===============================================================
> // Automatically install minimal Raspbian OS through net installer...
> //
> echo "wget -q -O -
> http://hifi.iki.fi/raspbian-ua-netinst/raspbian-ua-netinst-20140115-g
>itf8f70f8.img.xz | xzcat - > /dev/sde" | sudo sh sync

A netinstall on to an SD card is extremely slow, and quite honestly, not 
really needed unless you are trying squeeze a minimal install on to a 
small card - The standard Raspian images fit quite comfortably on to a 
2G card (which is the starting point for most).

For those that need/want a minimal embedded install will have the tools 
and knowledge to produce their own.

> ===============================================================
> // Blow away existing tools...

Why ?????

> ===============================================================
> // Get RPi cross compile tools...
> git clone --depth=1 git://github.com/raspberrypi/tools.git

One of the key points of GIT (and other VCS packages) is that you only 
need to pull in changes - This reduces the amount of data being 
transfered and reduces the load on the hosting servers. Some people 
have to pay for each Gigabyte and won't thank you for needlessly 
running up their bill !

> ===============================================================
> // Set the base Linux kernel config
> # OPTION:  wget
> https://www.dropbox.com/s/dcju74md5sz45at/rpi_xenomai_config && mv
> rpi_xenomai_config .config && make ARCH=arm oldconfig #

A less than optimal config with CPU Frequency scaling enabled along with 
a whole bunch of debug/tracing options that impact on performance.

> ===============================================================

