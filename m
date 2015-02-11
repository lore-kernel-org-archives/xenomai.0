Message-ID: <54DBC8E2.5000906@grandegger.com>
Date: Wed, 11 Feb 2015 22:25:54 +0100
From: Wolfgang Grandegger <wg@grandegger.com>
MIME-Version: 1.0
References: <CAEMXjGxixe5fgX-7uijpcGkNoPzoZcocJxEK-D+VqBdopx4puQ@mail.gmail.com>	<loom.20150210T153230-142@post.gmane.org>	<421c45d170f050857f0863b592dc2faa@grandegger.com>	<CAEMXjGyaBzbBm5v4=ibG-__EuE6gXFGKXXw=MaYQm_ueGVg+_Q@mail.gmail.com>	<6e21b08b682a0f43d1264fc203d376c8@grandegger.com>
 <CAEMXjGwfFdizDPWPyiwA9Wq6OiXrcn4Nb1zvNqpbCfxHXc-SQw@mail.gmail.com>
In-Reply-To: <CAEMXjGwfFdizDPWPyiwA9Wq6OiXrcn4Nb1zvNqpbCfxHXc-SQw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] Bosch CCAN/DCAN driver for RTDM
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Steve B <sbattazzo@gmail.com>
Cc: akoegel@gmx.de, "Xenomai@xenomai.org" <Xenomai@xenomai.org>

Hi Steve,

I re-added the Xenomai ML...

On 02/11/2015 04:22 PM, Steve B wrote:
> Thanks!
> One more thing, it seems to only work if the regular CAN driver was loaded
> once and then taken away with rmmod.
> I think I saw on the mailing list somebody else had experienced the same
> with the flexcan or another driver... I wonder if we can find the solution
> to that as well!

There are various options:

- use rmmod to unload the old driver (as you already did)
- use "unbind" to disconnect the Linux driver and "bind" to connect
  the RT-variant
- do not build the Linux driver at all
- use /etc/modprobe.d/blacklist

Wolfgang.


