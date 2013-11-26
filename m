Message-ID: <1385464837.54248.YahooMailNeo@web122606.mail.ne1.yahoo.com>
Date: Tue, 26 Nov 2013 03:20:37 -0800 (PST)
From: Giuseppe Iellamo <peppedx@yahoo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: [Xenomai] mmap and domain switch
Reply-To: Giuseppe Iellamo <peppedx@gmail.com>
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: "xenomai@xenomai.org" <xenomai@xenomai.org>

Hi all,=0A=0AIn my project I'm accessing a device using a linux device driv=
er (via sysfs) . In order to speedup the control loop I've mmapped the regi=
ster i need to read. The question is: If I access a device register using m=
map from a xenomai task am i triggering a domain switch ?=0A=0ABR,=0AGiusep=
pe
