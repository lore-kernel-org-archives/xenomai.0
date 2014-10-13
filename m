From: =?iso-8859-1?Q?H=E4nel-Baas=2C_Alexander?=
 <alexander.haenel-baas@sieb-meyer.de>
Date: Mon, 13 Oct 2014 08:47:05 +0000
Message-ID: <9BA84827B30CBE4996725F98F7DC9123428E2849@SMExchange01.siebmeyer.org>
Content-Language: de-DE
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Subject: [Xenomai] Threadnames not equal?
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: "xenomai@xenomai.org" <xenomai@xenomai.org>

Hi,

i have a main thread witch creates 3 other threads, this other thread was n=
amed
with:  pthread_setname_np(hThread, "myName");.

Ps shows:

-sh(581)--{WrapperThread}(641) --+--{Frameworktest}(644)
                                                                      |--{H=
ello}(642)
                                                                      |--{T=
imerThread}(643)

In /proc/xenomai/stat:
PID  NAME
641 Hello
643 Hello
644 WrapperThread

I'm a little confused about that. Has anyone an idea what's going wrong her=
e?

Kernel 3.14, xenomai 2.6 git with posix skin and busybox v1.20.2.

--

Alexander H=E4nel-Baas

