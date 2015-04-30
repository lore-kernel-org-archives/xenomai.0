Message-ID: <5541E66D.2050303@xenomai.org>
Date: Thu, 30 Apr 2015 10:23:09 +0200
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
References: <5541BFA1.40101@bmwedler.de> <5541DB07.4050304@xenomai.org>
 <5541E1F2.1090908@bmwedler.de>
In-Reply-To: <5541E1F2.1090908@bmwedler.de>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] Xenomai 3.0rc creating alchemy task in a shared object
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Registrierungen <regist@bmwedler.de>, xenomai@xenomai.org

On 04/30/2015 10:04 AM, Registrierungen wrote:
> Thanks for your reply.
> 
> Please not that it works fine for the standalone application.
> 
> Just in case, the task is created inside a staticaly linked shared
> object the error occurs.

Could you sketch how this app is organized, and how the compilation
units are linked together? e.g. is this something like this?

main executable (foo.c somelib.so)
	calls do_task_init()

somelib.so (bar.c)
	do_task_init() => calls rt_task_create()

Or are you doing late binding via dlopen()?

> 
> Here ist the config:
> 
> CONFIG_XENO_VERSION_STRING="3.0-rc1"

Please upgrade to -rc4 at the very least before more time is spent on
any issue involving xenomai3.

-- 
Philippe.

