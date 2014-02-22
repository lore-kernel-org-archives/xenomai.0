Message-ID: <53090AA4.4000903@xenomai.org>
Date: Sat, 22 Feb 2014 21:37:56 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <CAKKWdtfmWoZPjDmiqd2wVq2GOZEA0==iwv=KTcBHBn+wB3nZxw@mail.gmail.com>
In-Reply-To: <CAKKWdtfmWoZPjDmiqd2wVq2GOZEA0==iwv=KTcBHBn+wB3nZxw@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: Re: [Xenomai] Virtual terminal does not work
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

Le 22/02/2014 09:35, ali hagigat a écrit :
> I have installed:
> 
> xenomai-2.6.3
> linux-3.5.7
> x86, 32 bits Intel-quad-core machine@2.4GHZ
> Fedora 13
> GNOME 2
> Motherboard: ASUS Commando
> 
> Once I logged in as root graphically and then i used "switch user" icon and
> then i logged in as a regular user and pressed, <CTRL-ALT-F2> and i pressed
> some <CTRL_ALT-Fx> suddenly computer froze and i had a black screen, no
> key-presses or mouse movements were seen and the computer started beeping
> repeatedly.
> When i pressed <CTRL-ALT-F2> to see a Linux text-based virtual terminal,
> there is a black screen and no terminal and no key presses are seen
> 
> My kernel config file is attached, i thought to share this experience.

Doesn't the same kernel configuration, only without Xenomai patch, and
without enabling Xenomai, show the same behaviour?


-- 
Gilles.

