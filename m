From: Giulio Moro <g.moro@qmul.ac.uk>
Subject: "cheap", RT-safe way of detecting if a thread is Xenomai or Linux
Date: Sun, 13 Jan 2019 02:33:04 +0000
Message-ID: <AM0PR07MB5572ECC01EEA3054C3B02A59B5870@AM0PR07MB5572.eurprd07.prod.outlook.com>
Content-Language: en-GB
Content-Type: text/plain; charset="iso-8859-1"
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
To: "Xenomai@xenomai.org" <Xenomai@xenomai.org>

Hi all,
is there a "cheap", RT-safe call that can be made in order to find out if t=
he current thread is a Xenomai thread or a Linux thread? Also, to detect wh=
ether the Xenomai thread is in primary or secondary mode?

It seems that cobalt_thread_mode() gives some (all?) of these details. Is i=
t RT-safe? How much overhead does it incur? Is it the recommended way?

Thanks,
Giulio=

