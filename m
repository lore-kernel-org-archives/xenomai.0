From: Michael Pustylnik <MichaelPustylnik@ruggedcom.com>
Date: Wed, 10 Oct 2012 15:36:02 -0400
Message-ID: <990B36E792F1A4488D3E2B1C46FD62D6943CBA5BD8@corpmail2>
Content-Language: en-US
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Subject: [Xenomai] Xenomai does not recognize changed system time
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: "xenomai@xenomai.org" <xenomai@xenomai.org>

I get system time from Xenomai by calling rt_timer_inquire() and examining =
the 'date' field of RT_TIMER_INFO.
After system bootup, Xenomai reports the same system time as Linux (which i=
s expected). However, if I change Linux system time with the 'date' command=
, Linux starts reporting the new time, while Xenomai keeps reporting the ol=
d time, as if the system time was not changed.

Am I doing something wrong? Is this the expected behavior? How to get updat=
ed system time from Xenomai?



Michael Pustylnik, P.Eng.
Senior Software Engineer
RuggedCom Inc.
www.ruggedcom.com<http://www.ruggedcom.com/>
300 Applewood Crescent
Concord, Ontario, L4K 5C7
Tel:  (905)482-4523
Fax: (905)856-1995



