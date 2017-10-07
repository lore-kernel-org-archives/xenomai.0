From: Giulio Moro <g.moro@qmul.ac.uk>
Date: Sat, 7 Oct 2017 01:33:06 +0000
Message-ID: <DB6PR0701MB2456035E412673C8D6A78F47B5760@DB6PR0701MB2456.eurprd07.prod.outlook.com>
References: <DB6PR0701MB24565343D7707462B972F1ACB5710@DB6PR0701MB2456.eurprd07.prod.outlook.com>,
 <b846b4f5-2bdc-1540-1504-6973e65d6a80@xenomai.org>
In-Reply-To: <b846b4f5-2bdc-1540-1504-6973e65d6a80@xenomai.org>
Content-Language: en-GB
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: Re: [Xenomai] --session= is not a recognized option when using
 Posix skin
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Philippe Gerum <rpm@xenomai.org>, "xenomai@xenomai.org" <xenomai@xenomai.org>

> The POSIX API does not depend on copperplate, so
> you don't have support for multi-process sessions when linking against
> libcobalt exclusively.=20

Ok. All we need this for is to prevent multiple instances of our program to=
 be started at the same time. What would you suggest as the best way to che=
ck for the existence of a given real-time task using the POSIX API? We coul=
d just grep /proc/xenomai/sched/stat, or is there a better solution?

Thanks,
Giulio=

