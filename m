From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-2022-kr
Content-Transfer-Encoding: 7bit
Message-ID: <16174.49149.530010.827577@domain.hid>
Date: Mon, 4 Aug 2003 22:20:13 +0200
Subject: [Adeos-main] sched.c ?
In-Reply-To: <20030804231051.HM.G00000000060kMp@domain.hid>
References: <20030804231051.HM.G00000000060kMp@domain.hid>
List-Id: <adeos-main.nongnu.org>
List-Unsubscribe: <http://mail.nongnu.org/mailman/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
List-Archive: <http://mail.gnu.org/pipermail/adeos-main>
List-Post: <mailto:adeos-main@gna.org>
List-Help: <mailto:adeos-main-request@domain.hid>
List-Subscribe: <http://mail.nongnu.org/mailman/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
To: =?EUC-KR?B?yLK8rsGk?= <to_infinity@domain.hid>
Cc: adeos-main@gna.org

황석정 writes:

 > <P>I'm a newbie to Adeos.</P>
 > <P>I downloaded m3 version of Adeos and check a source tree.</P>
 > <P>I found that Adoes has files such as printk.c, sched.c and other files</P>
 > <P>similar to files contained in linux kernel.</P>
 > <P>And I think their contexts seem to be almost same with kernel's.</P>
 > <P>What are their purpose or functionality?</P>

The m3 archive contains the entire development tree, with all the
kernel files which include the Adeos-related changes, for readability
(and reference) purpose. So yes, sched.c and printk.c used to be the
original Linux files, but now also include the Adeos changes. If you
only need a working self-contained patch to apply to a vanilla kernel,
you can find it into patches/linux.

PS: please do not send HTML-formatted mails, they are hardly readable
by most of the civilized mail clients ;o)

Philippe.


