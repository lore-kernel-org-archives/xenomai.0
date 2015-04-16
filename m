From: =?iso-8859-1?Q?H=E4nel-Baas=2C_Alexander?=
 <alexander.haenel-baas@sieb-meyer.de>
Date: Thu, 16 Apr 2015 10:24:57 +0000
Message-ID: <9BA84827B30CBE4996725F98F7DC912342962FE6@SMExchange01.siebmeyer.org>
Content-Language: de-DE
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: [Xenomai] porting issue Xeno2 Xeno3
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: "xenomai@xenomai.org" <xenomai@xenomai.org>

Hi Philippe

Thank you for your clarifying reply.

I have read the document, and you are right i was confused what shall I use=
: cobalt, alchemy, trank???

So, I know: I'm a typical  trank guy:=20
-D __XENO_COMPAT__=20
-I/xenomai /include/trank
-I/xenomai /include/alchemy
-I/xenomai /include

and the most work comes with the implement a UDD driver.

Thank you very much.
---
Alexander

