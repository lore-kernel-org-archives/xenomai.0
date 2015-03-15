Date: Sun, 15 Mar 2015 19:37:57 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Message-ID: <20150315183757.GJ1497@hermes.click-hack.org>
References: <8863A7ED-4603-4043-8777-74B3867F9BDE@gatech.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <8863A7ED-4603-4043-8777-74B3867F9BDE@gatech.edu>
Subject: Re: [Xenomai] Graphics Iissues only after loading analogy
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: "Yogi A. Patel" <yapatel@gatech.edu>
Cc: xenomai@xenomai.org

On Sun, Mar 15, 2015 at 01:36:05PM -0400, Yogi A. Patel wrote:
> Hi -
> 
> I have multiple systems running Ubuntu 14.04 with Xenomai 2.6.3 or 2.6.4. Each system has a PCI/PCIe graphics card and an NI DAQ card.
> 
> On some machines, the system runs great - however on some of my machines the GUI becomes sluggish ONLY after the DAQ card has been loaded and attached using analogy_config. The mouse and keyboard interactions are affected. I’ve also noticed that dropping to a shell using CTRL+ALT+F1 is affected (the shell is slow to respond).
> 
> I’ve seen this on a variety of machines using ATI or Nvidia cards and with both proprietary and open-source drivers. On all of my machines, I have DRM/DKMS enabled for the appropriate graphics drivers and I’ve checked the DMESG and XORG logs - but nothing stands out/reveals why loading the DAQ leads to this behavior.
> 
> Has anyone else experienced this?

Are you sure this is not the well known irq conflicts issue?

-- 
					    Gilles.

