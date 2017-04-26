From: Johann Obermayr <johann.obermayr@sigmatek.at>
Date: Wed, 26 Apr 2017 14:59:20 +0000
Message-ID: <AM4PR0801MB15879E1D2256FFB403D89242F5110@AM4PR0801MB1587.eurprd08.prod.outlook.com>
Content-Language: de-DE
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Subject: [Xenomai] rtdm_mmap_to_user with default mapping address
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: "xenomai@xenomai.org" <xenomai@xenomai.org>

Hallo,

We are using Xenomai V2.6.4 (i know, this is a old version)

we are using rtdm_mmap_to_user to map a kmalloc memory  to user space over =
ioctl

Is there a way to tell rtdm_mmap_to_user, that he use a default address.

At mmap you can add a default address at the first parameter.

Best regards
  Johann

