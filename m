From: Jouko Haapaluoma <jouko.haapaluoma@wapice.com>
Subject: net/rtdev: Commit e972e78e reintroduces memory corruption fixed by
 74464ee3
Date: Fri, 8 Mar 2019 12:47:19 +0000
Message-ID: <HE1PR0301MB2140C55227286ADD137B6D56E54D0@HE1PR0301MB2140.eurprd03.prod.outlook.com>
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: "Philippe Gerum <rpm@xenomai.org> (rpm@xenomai.org)" <rpm@xenomai.org>, "'xenomai@xenomai.org'" <xenomai@xenomai.org>, "jan.kiszka@siemens.com" <jan.kiszka@siemens.com>

Hello

I have been investigating kernel memory corruption issues in our system (Xe=
nomai 2.6.4 and RTnet 0.9.13.2).
I traced the root cause into the rtdev_map_rtskb() function where a linked =
list is always grown but not shrinked.
You have recently created a patch that fixes this: 74464ee3.

Additionally, there seemed to be a regression and that was fixed in e972e78=
e. However, this regression fix
reintroduces the memory corruption in cases where the rtdev does not have t=
he rtdev->map_rtskb function defined.
Therefore we end up in the situation that was before the 74464ee3: The rtsk=
b_mapwait_list will grow but not shrink.
If sockets are destroyed and recreated, the rtskb_mapwait_list->next will p=
oint to a destroyed skb object which causes a
use-after-free memory corruption when calling list_add().

Best Regards,
Jouko Haapaluoma
Senior Software Designer
Embedded Linux Technology Specialist
Wapice Ltd, Finland

