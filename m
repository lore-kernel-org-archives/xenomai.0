References: <DB6PR0701MB2456EB08FE752DA5BF73FF6DB53A0@DB6PR0701MB2456.eurprd07.prod.outlook.com>
 <DB6PR0701MB24569056BAB353E42210D9CAB53A0@DB6PR0701MB2456.eurprd07.prod.outlook.com>
From: Philippe Gerum <rpm@xenomai.org>
Message-ID: <b095c725-4e15-6618-5af2-1790c0a0926c@xenomai.org>
Date: Wed, 29 Nov 2017 10:08:08 +0100
MIME-Version: 1.0
In-Reply-To: <DB6PR0701MB24569056BAB353E42210D9CAB53A0@DB6PR0701MB2456.eurprd07.prod.outlook.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] Library cannot be dlopen()ed
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Giulio Moro <g.moro@qmul.ac.uk>, "xenomai@xenomai.org" <xenomai@xenomai.org>

On 11/29/2017 12:24 AM, Giulio Moro wrote:
> Again, armv7 BeagleBone Black, Xenomai 3.0.5
> 
> My main executable uses the posix API, hence ldd tells me :
> 	libcobalt.so.2 => /usr/xenomai/lib/libcobalt.so.2 (0xb6ed3000)
> 	libmodechk.so.0 => /usr/xenomai/lib/libmodechk.so.0 (0xb6f39000)
> 
> I am trying to dlopen() a library which uses the native API (alchemy+transition kit):
> 	libtrank.so.0 => /usr/xenomai/lib/libtrank.so.0 (0xb6e71000)
> 	libalchemy.so.0 => /usr/xenomai/lib/libalchemy.so.0 (0xb6e58000)
> 	libcopperplate.so.0 => /usr/xenomai/lib/libcopperplate.so.0 (0xb6e3d000)
> 	libcobalt.so.2 => /usr/xenomai/lib/libcobalt.so.2 (0xb6e18000)
> 	libmodechk.so.0 => /usr/xenomai/lib/libmodechk.so.0 (0xb6e07000)
> 
> the call to dlopen() fails with the following message:
> libtrank.so.0: shared object cannot be dlopen()ed
> 
> grepping the configured Xenomai source for "nodlopen" shows that all (or most) of the libraries are compiled with -Wl,nodlopen, which is what is preventing dlopen() from working.
> 
> I have two questions:
> - is it possible to dynamically load a library which uses the alchemy API from a program that uses the cobalt API?
> - is it at all possible to dynamically load a library that uses xenomai in a program that was not linked against xenomai?
> 
> Thanks,
> Giulio
> 
> _______________________________________________
> Xenomai mailing list
> Xenomai@xenomai.org
> https://xenomai.org/mailman/listinfo/xenomai
> 

As mentioned in the documentation, --enable-dlopen-libs is needed when
configuring:

https://xenomai.org/installing-xenomai-3-x/#Generic_configuration_options_both_cores

-- 
Philippe.

