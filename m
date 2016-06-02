References: <AM4PR05MB17479649FDCD91F251E66DB991740@AM4PR05MB1747.eurprd05.prod.outlook.com>
From: Philippe Gerum <rpm@xenomai.org>
Message-ID: <37e28fa0-0e14-6b84-dc43-e0f64c16c226@xenomai.org>
Date: Thu, 2 Jun 2016 15:44:44 +0200
MIME-Version: 1.0
In-Reply-To: <AM4PR05MB17479649FDCD91F251E66DB991740@AM4PR05MB1747.eurprd05.prod.outlook.com>
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

On 05/13/2016 03:27 PM, Marcel Van Mierlo wrote:
> Hi,
> 
> 
> Which parameters limit the number of psos skin tasks that can be created using t_create()? (ARM (Beagle), Xenomai 3.0).
> 
> At the moment I am getting ERR_NOTCB back after creating about 118 tasks (just calling t_create not t_start). In production we are hitting the limit at about 70 tasks...though sometimes we can go a bit higher.
> 
>>From the documentation I see:
> 
> * t_create() returns ERR_NOTCB upon memory allocation failure when
> trying to get a task control block from the nucleus heap. There is
> no control block limit for tasks.
> 
> 
> So I adjusted the following:
> 
> CONFIG_XENO_OPT_SYS_HEAPSZ=1024
> CONFIG_XENO_OPT_PRIVATE_HEAPSZ=128
> CONFIG_XENO_OPT_SHARED_HEAPSZ=128
> 

You likely need to raise CONFIG_XENO_OPT_REGISTRY_NRSLOTS.

-- 
Philippe.

