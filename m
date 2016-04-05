Date: Tue, 5 Apr 2016 09:02:32 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Message-ID: <20160405070232.GI20399@hermes.click-hack.org>
References: <DB5PR06MB1287CCF7EAF55DA6F95ED4A68F9D0@DB5PR06MB1287.eurprd06.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DB5PR06MB1287CCF7EAF55DA6F95ED4A68F9D0@DB5PR06MB1287.eurprd06.prod.outlook.com>
Subject: Re: [Xenomai] Mixing Posix RT APIs and vxWorks APIs
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Alex Plits <alex_plits@radwin.com>
Cc: "xenomai@xenomai.org" <xenomai@xenomai.org>

On Mon, Apr 04, 2016 at 01:42:11PM +0000, Alex Plits wrote:
> Hi,
> 
> We are currently porting some of our vxWorks  xenomai (copperplate) APIs we use in our application to
> Posix (cobalt I guess).

Well, if you do not know whether you are using Cobalt or Mercury, we
can not know it for you...

> We have started with the VxWorks "tasks" but it seems that we're getting strange behavior on
> The remaining VxWorks APIs when used from the POSIX generated tasks (threads is the right word in posix) e.g. MsqQRecv function gets segfault but when it is used From a VxWorks generated task it works fine.
> I understand from the comments in code it should work but I was wondering if there are known issues.
> 
> We are using currently xenomai 3 rc-6 (I saw there were fixes in xenomai 3.0.2).

Could you send a self-contained, simplest possible test case which
causes the problem for you, that we can test on the latest Xenomai
release to see if the problem has not been already fixed?

Regards.

-- 
					    Gilles.
https://click-hack.org

