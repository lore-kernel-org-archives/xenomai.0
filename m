From: "Pham, Phong" <phamp@ddc-web.com>
Date: Fri, 5 Oct 2018 01:02:46 +0000
Message-ID: <C2EC5BA46D13CD44B5915A8FEEB4C44ED1819D8C@DDCEXCH.ddc-ny.com>
Content-Language: en-US
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Subject: [Xenomai] Does RTNET supports TCP?
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: "xenomai@xenomai.org" <xenomai@xenomai.org>
Cc: "Hillman, Robert" <hillman@ddc-web.com>


Hi,

I noticed starting Xenomai 3.0.1 until now (3.0.7), there is net/ in .../ke=
rnel/drivers/ and in ../kernel/drivers/net/stack/ipv4/Kconfig

# source "drivers/xenomai/net/stack/ipv4/tcp/Kconfig"

If I uncomment out the above line, it leads to compilation error in tcp.c.

Questions:

1)      Is the commented out line intentional? (short run and long run)

2)      When will TCP be supported in RTnet?

3)      Will it ever be supported?

4)      Will this statement still holds true in tcp/Kconfig? "When the RTne=
t IPv4 is enabled while this feature is disabled, TCP will be forwarded to =
the Linux network stack."

5)      When I created a socket with rt_dev_socket(AF_INET, SOCK_STREAM, 0)=
; and attempting to rt_dev_connect(fd, server_ip_addr, sizeof(server_ip_add=
r)), I get errno =3D 25 (Inappropriate ioctl for device).  Does it mean b/c=
 TCP is not supported in RTnet and I attempt to connect via TCP (w/ socket =
SOCK_STREAM)?

Phong.

Notice: This e-mail and any files transmitted with it may contain Data Devi=
ce Corporation's and its subsidiaries privileged and proprietary informatio=
n. It is intended solely for the use of the individual or entity to whom it=
 is addressed. If you are not the named recipient of this transmission, any=
 disclosure, copying, distribution or reliance on the contents of this mess=
age is prohibited. If you received this e-mail in error, please destroy it =
and any attached files and notify me immediately.

Click Here<http://www.ddc-web.com/Profile/EmailPrivacy.aspx> to view our pr=
ivacy statement.
