MIME-Version: 1.0
Date: Wed, 13 May 2015 00:55:46 -0700
Message-ID: <CAKC9m6cqL6vFttH3QJM9Z64YqHscF1QGCeP6dq5w=XepGDXgeQ@mail.gmail.com>
From: Hongfei Cheng <hongfei@mperpetuo.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Xenomai] =?utf-8?b?SVJRIGZsb3cgaGFuZGxlcjog4oCcaGFuZGxlX2VkZ2Vf?=
	=?utf-8?b?aXJx4oCdIHZzIOKAnGhhbmRsZV9sZXZlbF9pcnHigJ0=?=
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

Hi All,

In the document of "Porting Xenomai dual kernel to a new ARM SoC",
section "flow handler" states: If the flow handler is
=E2=80=9Chandle_edge_irq=E2=80=9D, and the system locks up when the first i=
nterrupt
happens, try replacing =E2=80=9Chandle_edge_irq=E2=80=9D with =E2=80=9Chand=
le_level_irq=E2=80=9D.

Could anyone explain why =E2=80=9Chandle_edge_irq=E2=80=9D can cause system=
 to hang
while =E2=80=9Chandle_level_irq=E2=80=9D doesn't? I searched the archives b=
ut failed
to find any discussion on this topic.

Thanks!
Hongfei

