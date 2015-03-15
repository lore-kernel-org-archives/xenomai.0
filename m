From: "Yogi A. Patel" <yapatel@gatech.edu>
Date: Sun, 15 Mar 2015 13:36:05 -0400
Message-Id: <8863A7ED-4603-4043-8777-74B3867F9BDE@gatech.edu>
Mime-Version: 1.0 (Mac OS X Mail 8.2 \(2070.6\))
Content-Type: text/plain;
	charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: [Xenomai] Graphics Iissues only after loading analogy
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

Hi -

I have multiple systems running Ubuntu 14.04 with Xenomai 2.6.3 or =
2.6.4. Each system has a PCI/PCIe graphics card and an NI DAQ card.

On some machines, the system runs great - however on some of my machines =
the GUI becomes sluggish ONLY after the DAQ card has been loaded and =
attached using analogy_config. The mouse and keyboard interactions are =
affected. I=E2=80=99ve also noticed that dropping to a shell using =
CTRL+ALT+F1 is affected (the shell is slow to respond).

I=E2=80=99ve seen this on a variety of machines using ATI or Nvidia =
cards and with both proprietary and open-source drivers. On all of my =
machines, I have DRM/DKMS enabled for the appropriate graphics drivers =
and I=E2=80=99ve checked the DMESG and XORG logs - but nothing stands =
out/reveals why loading the DAQ leads to this behavior.

Has anyone else experienced this?

Yogi A. Patel
@yapatel525 <https://twitter.com/yapatel525>
