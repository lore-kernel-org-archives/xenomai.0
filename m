Message-ID: <48C2E5A5.8030403@domain.hid>
Date: Sat, 06 Sep 2008 22:18:45 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <C4E7FEAF.8C9%samf48@domain.hid>
In-Reply-To: <C4E7FEAF.8C9%samf48@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] Xenomai kernel compile issue
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Sam Ferguson <samf48@domain.hid>
Cc: Xenomai help <xenomai@xenomai.org>

Sam Ferguson wrote:
> No, I get the same error as before. Am I using the right patch?  I have an
> HP laptop with an AMD chipset in it, should I be using i386 or x86.  I've
> tried both now with the same problem as before.  I start the script, then
> after 2 seconds it returns me to the terminal.  I am now using xenomai-2.4.5
> and linux-2.6.26.3 with no luck.  Is there a log file generated from the
> prepare-kernel.sh script I can look at?

Ok. Since I already had the .config you used, I did a small experiment.
I created a temporary directory, went to it, copied your .config to it,
then did:

tar -xvjf /home/gilles/files/downloads/xenomai-2.4.5.tar.bz2
tar -xvjf /home/gilles/files/downloads/linux-2.6.26.3.tar.bz2
./xenomai-2.4.5/scripts/prepare-kernel.sh # Answered the questions here
cd linux-2.6.26.3/
cp ../.config  .
make ARCH=i386 oldconfig # Hit enter for all questions
make ARCH=i386

And the kernel compiled just fine. I had to use ARCH=i386, because I am
compiling on an x86_64.

-- 
					    Gilles.

