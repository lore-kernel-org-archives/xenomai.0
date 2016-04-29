From: Umair Ali <ali.umair@tut.fi>
Date: Fri, 29 Apr 2016 13:45:53 +0000
Message-ID: <2396B4D2166B62479FBBE370D4A7C1F30A731FEF@mb2010-3.intra.tut.fi>
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: [Xenomai] rtdm_socket() error -97 for sending UDP or RAW packets
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: "xenomai@xenomai.org" <xenomai@xenomai.org>

Hello there,

I am working to make a module which will uses the Rtnet module to send the =
UDP or RAW pakets. My aim is to use the interface 'rteth0' in kernel space =
same like in userspace. Therefore I think I should create the socket and th=
en using the created socket link the interface rteth0 with it. But when I u=
se the function 'rtdm_socket(PF_INET, SOCK_RAW,0)' or 'rtdm_socket(PF_PACKE=
T, SOCK_RAW,0)' or 'rtdm_socket(PF_INET, SOCK_DGRAM,0)' or anything with av=
ailable options i.e also with sock_stream. I got the error -97. Which I hav=
e looked in google means the family of protocol is not supported. Please te=
ll me if it is possible to send the UDP packets from the kernel space using=
 interface rteth0 and socket or not. Can u guide me how I can solve the err=
or -97. Thanks in advance

Regards
Ali

