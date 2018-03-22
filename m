From: "PRADHAN, MAKARAND" <makarand.pradhan@siemens.com>
Date: Thu, 22 Mar 2018 17:09:42 +0000
Message-ID: <B89CCBE86D4F62448EE4F6367C6D3C894359247F@USIRVA0EM24MSX.ww017.siemens.net>
Content-Language: en-US
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Subject: [Xenomai] Question about using UDD in Xenomai-3
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: "xenomai@xenomai.org" <xenomai@xenomai.org>

Hi All,

I am working on upgrading our device from Xenomai 2 to Xenomai 3. I have be=
en consulting the Xenomai web page. Based on reading the online documentati=
on, I have a fair understanding of the UDD, All the same, I would highly ap=
preciate a second opinion.

We have a user space interrupt handler and the Xenomai 3 documentation sugg=
ests use of UDD. So, I have tried to list down the things I should do.

In kernel space:
Register with the udd using udd_register_device.
I think, the udd_register_device would create /dev/udd/device_name which ca=
n be opened for ioctl. Can someone confirm this?

In User space:
Open device /dev/udd/device_name
ioctl to this device UDD_RTIOC_IRQSIG, providing the pid and the signal to =
be received by the User space process.
ioctl to this device UDD_RTIOC_IRQEN to enable the int.
Wait on the signal using sigwaitinfo or sigtimedwait.

Am I on the right path?

Thanks for your help.

Rgds,
Makarand.
