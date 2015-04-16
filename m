From: =?iso-8859-1?Q?H=E4nel-Baas=2C_Alexander?=
 <alexander.haenel-baas@sieb-meyer.de>
Date: Thu, 16 Apr 2015 06:59:37 +0000
Message-ID: <9BA84827B30CBE4996725F98F7DC912342962F15@SMExchange01.siebmeyer.org>
Content-Language: de-DE
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
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

Thank you for your reply.

I know this document. In the section "Using the Transition Kit" is describe=
d how to use the xeno-config script.
So I call the script with:
usr/xenomai/bin/xeno-config --skin=3Dnative --cflags

and get:
-I/usr/xenomai/include/trank -D__XENO_COMPAT__ -I/usr/xenomai/include/cobal=
t -I/usr/xenomai/include -march=3Darmv7-a -mfpu=3Dvfp3 -D_GNU_SOURCE -D_REE=
NTRANT -D__COBALT__ -I/usr/xenomai/include/alchemy

I get this info to set the right cflags/ldflags in my own environment.

In the document stands alchemy is the native skin, so I set the include pat=
h to alchemy. In this case I get some undefined errors.
When I changed the include path to trank the compiler are lucky. Because th=
e trank/native/timer.h include the /alchemy/timer too.

Now I am not sure which is the right include path when I will used the nati=
ve api alchemy.

Sorry for that detailed question, but I can't use the xeno-config script in=
 my cross environment directly. I need a sysroot directive to
set the include path correct to the installed xenomai headers under my sysr=
oot path, and not to the host path.

With best regards,
Alexander

