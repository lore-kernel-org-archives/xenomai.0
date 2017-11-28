References: <DB6PR0701MB2456EB08FE752DA5BF73FF6DB53A0@DB6PR0701MB2456.eurprd07.prod.outlook.com>
From: Philippe Gerum <rpm@xenomai.org>
Message-ID: <f76137b1-16c4-5a7d-fc21-98dfb541066b@xenomai.org>
Date: Tue, 28 Nov 2017 17:27:31 +0100
MIME-Version: 1.0
In-Reply-To: <DB6PR0701MB2456EB08FE752DA5BF73FF6DB53A0@DB6PR0701MB2456.eurprd07.prod.outlook.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] Linking shared library which relies on bootstrap.o
 fails
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Giulio Moro <g.moro@qmul.ac.uk>, "xenomai@xenomai.org" <xenomai@xenomai.org>

On 11/28/2017 05:18 PM, Giulio Moro wrote:
> armv7 (BeagleBone Black), Xenomai 3.0.5.
> 
> When linking a shared library with something like 
>   gcc `/usr/xenomai/bin/xeno-config --skin=alchemy --ldflags` -rdynamic -shared -o libmylib.so 
> 
> I get 
> 
> /usr/bin/ld: /usr/xenomai/lib/xenomai/bootstrap.o: relocation R_ARM_THM_MOVW_ABS_NC against `a local symbol' can not be used when making a shared object; recompile with -fPIC
> /usr/xenomai/lib/xenomai/bootstrap.o: error adding symbols: Bad value
> 
> I understand this can be fixed by compiling the Xenomai library (or at least boostrap.o) with -fPIC. 
> 

No, please see the documentation about --auto-init, --auto-init-solib:
https://xenomai.org/documentation/xenomai-3/html/man1/xeno-config/index.html

> Should this not be made the default setting?

No, we need a non-PIC version for pure execs too. This is why we have
two builds of bootstrap.o - PIC and non-PIC, selected by the proper
xeno-config switch, depending on the link target.

-- 
Philippe.

