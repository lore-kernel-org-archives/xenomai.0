From: Edouard Tisserant <edouard.tisserant@gmail.com>
Message-ID: <91652cf8-9e03-50c0-bee0-06d0bc315a91@gmail.com>
Date: Sat, 15 Sep 2018 15:02:45 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Content-Language: en-US
Subject: [Xenomai] RTSKB_SIZE
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: "Xenomai (xenomai@xenomai.org)" <xenomai@xenomai.org>, Jan Kiszka <jan.kiszka@siemens.com>

Hi all.

I'd like to send proper patches to fix RTNet's rt_fec, but I can't
decide if this change of RTSKB_SIZE is acceptable.

RTSKB_SIZE=3D1533 was having a nasty influence on RX ring
allocation/handling. With RTSKB_SIZE set to the next power of 2 (2048),
it works better. It might simply be another bug in rt_fec, but I stopped
searching for now.

In rtskb.h RTSKB_SIZE is hard-coded to 1533. Why such value ?

Should RTSKB_SIZE be defined with KConfig, and then depend on what
driver is selected ?

Regards

Edouard




