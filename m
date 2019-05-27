Date: Mon, 27 May 2019 02:27:57 -0500 (CDT)
From: Per Oberg <pero@wolfram.com>
Message-ID: <1472936151.691343.1558942077593.JavaMail.zimbra@wolfram.com>
Subject: RTUdp incoming msg are ok but unable to send UDP
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai <xenomai@xenomai.org>

Hi folks=20

I am having some troubles with UDP and rtnet. I think it used to work, but =
I'm not sure in what configuration. I had to update to meet some driver dem=
ands and now i am using the following versions:

Xenomai 3.0.7
ipipe-core-4.9.90-x86-6
Kernel 4.9.90


When trying to send a UDP message I got a kernel paging request error so I =
tried adding nosmap to the boot parameters. This solved the kernel paging b=
ug but no messages are coming out.=20


Does anyone know if there went in some patches to rtudp lately that would f=
ix this?

Any other tips out there ?

Best regards
Per =C3=96berg=20

