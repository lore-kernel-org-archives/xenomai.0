From: Marcel Van Mierlo <Marcel.VanMierlo@marel.com>
Date: Thu, 9 Jun 2016 12:45:33 +0000
Message-ID: <AM4PR05MB1747644DF813E01D46B00B4D915F0@AM4PR05MB1747.eurprd05.prod.outlook.com>
References: <AM4PR05MB17479649FDCD91F251E66DB991740@AM4PR05MB1747.eurprd05.prod.outlook.com>
 <37e28fa0-0e14-6b84-dc43-e0f64c16c226@xenomai.org>
 <AM4PR05MB17470B585705C4680E3DF0EC915C0@AM4PR05MB1747.eurprd05.prod.outlook.com>
 <de32dcc4-3237-3686-779d-3cdf280eba2d@xenomai.org>
 <AM4PR05MB1747728DA27DE760AD5DF39E915E0@AM4PR05MB1747.eurprd05.prod.outlook.com>,
 <ea3404f2-5b96-b8b3-3909-de21a52844aa@xenomai.org>
In-Reply-To: <ea3404f2-5b96-b8b3-3909-de21a52844aa@xenomai.org>
Content-Language: en-GB
Content-Type: text/plain; charset="Windows-1252"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: Re: [Xenomai] what limits number of pSOS tasks using t_create?
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Philippe Gerum <rpm@xenomai.org>, "xenomai@xenomai.org" <xenomai@xenomai.org>

OK, yep that sorted it. Thanks.

MaxThreadsLimit_Pre and MaxThreadsLimit_Post now always succeed, and MaxThr=
eads(5000) fails consistently on 847 every time (which seems about right fo=
r the parameters I am using).

root@WPL:/var/wpl# ./wpl.bin --dump-config
based on Xenomai/cobalt v3.0.2 -- #83d7bfb (2016-06-08 10:51:06 +0200)


I noticed that after building Xenomai 3.0.2, updating kernel with prepare-k=
ernel.sh, building kernel and installing Xenomai 3.0.2, dmesg still reports=
 v3.0 (Exact Zero) - would have expected v3.0.2 to be reported?

root@WPL:~# dmesg | grep -i Xen
[    2.123665] [Xenomai] scheduling class idle registered.
[    2.123675] [Xenomai] scheduling class rt registered.
[    2.123815] I-pipe: head domain Xenomai registered.
[    2.127095] [Xenomai] Cobalt v3.0 (Exact Zero)

________________________________________
From: Philippe Gerum <rpm@xenomai.org>
Sent: 09 June 2016 08:17:35
To: Marcel Van Mierlo; xenomai@xenomai.org
Subject: Re: [Xenomai] what limits number of pSOS tasks using t_create?

On 06/08/2016 11:11 AM, Marcel Van Mierlo wrote:

> root@WPL:/var/wpl# ./wpl.bin --dump-config
> based on Xenomai/cobalt v3.0 -- #5f6b32f (2015-10-31 20:57:40 +0100)

Before anything else, could you rebase your tests over the stable-3.0.x
branch from our git tree? The version you have been testing with so far
is obsolete; there is no point in debugging issues which have
potentially been fixed already.

--
Philippe.

