From: Jerry Huang <jerry.huang@nxp.com>
Subject: latency: negative value?
Date: Sun, 24 Apr 2022 08:13:06 +0000
Message-ID: <VE1PR04MB6477905B7CC4E6A6F5D769BEFEF99@VE1PR04MB6477.eurprd04.prod.outlook.com>
Content-Language: en-US
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: "xenomai@xenomai.org" <xenomai@xenomai.org>

Hi, all guys,
Now I am using linux-dovetail/v5.15.6-dovetail1-rebase on my RDB board.
1 . I am running latency command, but when I running command:
latency -t 1 -T 30
I got the negative value:
RTD|     -2.760|     -2.654|     -1.800|       0|     0|     -2.760|     -1=
.400

2. Then, I got the solution from google:
Run command: xeno latency -T 20
I got:
RTD|     -1.360|     -1.235|     -0.040|       0|     0|     -1.440|      0=
.440

3. then I update /proc/xenomai/latency value
echo -1440 > /proc/xenomai/latency

4. when I run xeno latency again, I got below result:
RTD|      5.240|      5.389|      6.640|       0|     0|      5.040|      7=
.600

5. but when I run command again: latency -t 1 -T 30,
I still got the negative value:
RTD|     -2.760|     -2.652|     -1.760|       0|     0|     -2.760|     -1=
.400

So, How to fix the issue?
And how to check the xenomai interrupt? I remember I can get the interrupt =
number through "cat /proc/xenomai/irq",but now I can't find it.

Best Regards
Jerry Huang

