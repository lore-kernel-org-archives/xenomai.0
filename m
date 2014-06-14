Message-ID: <539CCDDC.7000809@konstantin-schauwecker.de>
Date: Sun, 15 Jun 2014 00:34:04 +0200
From: Konstantin Schauwecker <hi@konstantin-schauwecker.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Subject: [Xenomai] Missing patch for Zynq
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

Hi all,

I was trying to get xenomai running on my zynq board. Unfortunately 
there seems to be a patch missing in the current 2.6.3 release. 
According to the installation instructions, I should apply patch

pipe-core-3.8.13-arm-1.patch

Unfortunately, that patch is nowhere to be found. There's a patch called 
ipipe-core-3.8.13-arm-3.patch, but that fails on several files.

Older versions of xenomai don't seem to support zynq, so I'm kind of 
stuck. I tried googling for that file, but it seems to be non-existent.

Does anybode have an idea where I could find it?

Thanks,
Konstantin

