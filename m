References: <AM4PR05MB17479649FDCD91F251E66DB991740@AM4PR05MB1747.eurprd05.prod.outlook.com>
 <37e28fa0-0e14-6b84-dc43-e0f64c16c226@xenomai.org>
 <AM4PR05MB17470B585705C4680E3DF0EC915C0@AM4PR05MB1747.eurprd05.prod.outlook.com>
 <de32dcc4-3237-3686-779d-3cdf280eba2d@xenomai.org>
 <AM4PR05MB1747728DA27DE760AD5DF39E915E0@AM4PR05MB1747.eurprd05.prod.outlook.com>
From: Philippe Gerum <rpm@xenomai.org>
Message-ID: <ea3404f2-5b96-b8b3-3909-de21a52844aa@xenomai.org>
Date: Thu, 9 Jun 2016 09:17:35 +0200
MIME-Version: 1.0
In-Reply-To: <AM4PR05MB1747728DA27DE760AD5DF39E915E0@AM4PR05MB1747.eurprd05.prod.outlook.com>
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

On 06/08/2016 11:11 AM, Marcel Van Mierlo wrote:

> root@WPL:/var/wpl# ./wpl.bin --dump-config
> based on Xenomai/cobalt v3.0 -- #5f6b32f (2015-10-31 20:57:40 +0100)

Before anything else, could you rebase your tests over the stable-3.0.x
branch from our git tree? The version you have been testing with so far
is obsolete; there is no point in debugging issues which have
potentially been fixed already.

-- 
Philippe.

