References: <DB6PR0701MB2456FE5A9F080B3BE39375E0B5A40@DB6PR0701MB2456.eurprd07.prod.outlook.com>
From: Philippe Gerum <rpm@xenomai.org>
Message-ID: <08c2ad36-f2c4-952f-5372-bd95146943cf@xenomai.org>
Date: Thu, 5 Apr 2018 08:36:33 +0200
MIME-Version: 1.0
In-Reply-To: <DB6PR0701MB2456FE5A9F080B3BE39375E0B5A40@DB6PR0701MB2456.eurprd07.prod.outlook.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] doc for xeno-config skins
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Giulio Moro <g.moro@qmul.ac.uk>, "xenomai@xenomai.org" <xenomai@xenomai.org>

On 04/04/2018 10:15 PM, Giulio Moro wrote:
> What is the difference between the Posix and Cobalt skin, as far as xeno-config is concerned??
> 
> Difference between
>   xeno-config --skin posix --cflags
>   xeno-config --skin cobalt --cflags
> is that the former declares -D__COBALT_WRAP__ (which in turn adds fwd declarations for clock_nanosleep() and pthread_setname_np() in boilerplate/libc.h).
> 
> difference between 
>   xeno-config --skin posix --ldflags
>   xeno-config --skin cobalt --ldflags
> is that the former adds `-Wl,@/usr/xenomai/lib/cobalt.wrappers`
> 
> So it seems to me that `--skin posix` expects you to call, e.g.: pthread_create(), while `--skin cobalt` expects you to call, e.g.: __wrap_pthread_create()
> 
> Is this correct?
> Is that it?
> What are the intended uses?
> I don't think this is documented anywhere? Where would be the best place to have this written down? Perhaps the --help of xeno-config? Also, while we are at it, --skin alchemy vs --skin native and the effect of --compat could use some description.
> 

http://www.xenomai.org/documentation/xenomai-3/html/man1/xeno-config/index.html



-- 
Philippe.

