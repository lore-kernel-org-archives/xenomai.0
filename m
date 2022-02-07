From: Russell Johnson <russell.johnson@kratosdefense.com>
Subject: Shared memory in evl driver
Date: Mon, 7 Feb 2022 20:59:55 +0000
Message-ID: <PH1P110MB1050B0A0FEC4B2688FA36C01E22C9@PH1P110MB1050.NAMP110.PROD.OUTLOOK.COM>
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

Hello,

I currently have a linux driver used by my application that contains some g=
lobal buffers that are updated based on various ioctl calls. If I add the E=
VL ioctl file descriptor to the driver, can I access the same buffer that i=
s referenced by the normal ioctl call? As in, can both ioctl() and oob_ioct=
l() reference the same memory? If so, what would I need to keep in mind? Ho=
w would mutexes work since there is an interaction between evl and non-evl =
calls?

Thanks,
Russell
