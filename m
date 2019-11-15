Date: Fri, 15 Nov 2019 23:26:50 +0000
From: Jeff Webb <w1@codecraftsmen.org>
Reply-To: Jeff Webb <w1@codecraftsmen.org>
Subject: RE: --print-buffer-syncdelay, lib/cobalt/init.c:cobalt_help()
Message-ID: <QIcz_Mzq1NwSy9algHOLkalGdSrxCxR8JSS5SI26yJvRItYmsYtDt9IL7tU309_Ay6lREUUPzcuAuGmuNVbIBQFAw0HRCYKEKEofo9VRHDM=@codecraftsmen.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

I was converting an old Xenomai 2.6 application to 3.1, and had to adjust t=
he RT print buffer settings from environment variables to command-line opti=
ons.  I had trouble with xenomai_init() not removing one of the command-lin=
e arguments it should have processed.  After doing a web search, I came acr=
oss this:

  https://www.xenomai.org/pipermail/xenomai/2019-May/040883.html

It looks like a fix for this hasn't made it into 3.1 yet.

To summarize, a xenomai application's --help output says:

  --print-buffer-syncdelay=3D<ms>   max delay of output synchronization (10=
0 ms)

But xenomai_init() doesn't remove this option from argv, so I don't think i=
t recognizes it.  Based on the above mailing list post, I tried:

  --print-sync-delay=3D100

and it then removes the option from argv, so I assume this is the option na=
me it is looking for.  I didn't try the patch posted in the original email =
to see if it worked.

-Jeff


