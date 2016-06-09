References: <AM4PR05MB17479649FDCD91F251E66DB991740@AM4PR05MB1747.eurprd05.prod.outlook.com>
 <37e28fa0-0e14-6b84-dc43-e0f64c16c226@xenomai.org>
 <AM4PR05MB17470B585705C4680E3DF0EC915C0@AM4PR05MB1747.eurprd05.prod.outlook.com>
 <de32dcc4-3237-3686-779d-3cdf280eba2d@xenomai.org>
 <AM4PR05MB1747728DA27DE760AD5DF39E915E0@AM4PR05MB1747.eurprd05.prod.outlook.com>
 <ea3404f2-5b96-b8b3-3909-de21a52844aa@xenomai.org>
 <AM4PR05MB1747644DF813E01D46B00B4D915F0@AM4PR05MB1747.eurprd05.prod.outlook.com>
From: Philippe Gerum <rpm@xenomai.org>
Message-ID: <293f005f-5312-0bc8-4ca0-e8affcecac40@xenomai.org>
Date: Thu, 9 Jun 2016 14:52:13 +0200
MIME-Version: 1.0
In-Reply-To: <AM4PR05MB1747644DF813E01D46B00B4D915F0@AM4PR05MB1747.eurprd05.prod.outlook.com>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] what limits number of pSOS tasks using t_create?
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Marcel Van Mierlo <Marcel.VanMierlo@marel.com>, "xenomai@xenomai.org" <xenomai@xenomai.org>

On 06/09/2016 02:45 PM, Marcel Van Mierlo wrote:
> OK, yep that sorted it. Thanks.
> 
> MaxThreadsLimit_Pre and MaxThreadsLimit_Post now always succeed, and MaxThreads(5000) fails consistently on 847 every time (which seems about right for the parameters I am using).
> 
> root@WPL:/var/wpl# ./wpl.bin --dump-config
> based on Xenomai/cobalt v3.0.2 -- #83d7bfb (2016-06-08 10:51:06 +0200)
> 
> 
> I noticed that after building Xenomai 3.0.2, updating kernel with prepare-kernel.sh, building kernel and installing Xenomai 3.0.2, dmesg still reports v3.0 (Exact Zero) - would have expected v3.0.2 to be reported?
> 
> root@WPL:~# dmesg | grep -i Xen
> [    2.123665] [Xenomai] scheduling class idle registered.
> [    2.123675] [Xenomai] scheduling class rt registered.
> [    2.123815] I-pipe: head domain Xenomai registered.
> [    2.127095] [Xenomai] Cobalt v3.0 (Exact Zero)

You need to start from a fresh, un-prepared kernel tree.

-- 
Philippe.

