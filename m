From: =?iso-8859-1?Q?H=E4nel-Baas=2C_Alexander?=
 <alexander.haenel-baas@sieb-meyer.de>
Date: Wed, 10 Dec 2014 14:22:10 +0000
Message-ID: <9BA84827B30CBE4996725F98F7DC9123428F9E0E@SMExchange01.siebmeyer.org>
Content-Language: de-DE
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Subject: [Xenomai] CPU time limit exceeded SIGXCPU
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

i get the message "CPU time limit exceeded"  when my main thread is startin=
g.

The thread mod Bit "T_WARNSW" is not set.
ulimit -a shows cpu time is unlimited.

Now I installed the sigdebug handler and get the message:

SIGDEBUG received, reason 7<unknown>

My question is: why is the reason value 7? These value has only max 6 entri=
es?

I used the posix skin with 3.8.18 and xenomai 2.6.4.

Regard
Alexander

