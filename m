References: <C2EC5BA46D13CD44B5915A8FEEB4C44E8488E31A@DDCEXCH.ddc-ny.com>
 <2fa46484-f8e1-ffbd-5e67-79d6345d08d2@xenomai.org>
 <C2EC5BA46D13CD44B5915A8FEEB4C44E8489E1E1@DDCEXCH.ddc-ny.com>
From: Philippe Gerum <rpm@xenomai.org>
Message-ID: <b72099ab-d43f-ae57-7cea-fa801cd98d1c@xenomai.org>
Date: Wed, 18 Apr 2018 21:58:03 +0200
MIME-Version: 1.0
In-Reply-To: <C2EC5BA46D13CD44B5915A8FEEB4C44E8489E1E1@DDCEXCH.ddc-ny.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] mmap when using in conjunction with mapper to
 retrieve memory mapped IO space
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: "Pham, Phong" <phamp@ddc-web.com>, "xenomai@xenomai.org" <xenomai@xenomai.org>
Cc: "Hillman, Robert" <hillman@ddc-web.com>

On 04/18/2018 09:33 PM, Pham, Phong wrote:
> 
> Hi,
> 
> Instead of  symbol `mmap' out of range, I now have symbol `malloc' out of range.  I removed  all the -fPIC in my environment.  I have to recompile libc???  I never compiled libc and wants to avoid it.

Of course not.

> 
> Any suggestion on
> R_PPC_REL24 relocation at 0x0ffacd3c for symbol `mmap/malloc' out of range
> 

This is likely happening because the default auto-init glue module for a
final executable is mentioned in the flags, you either want to pass
--auto-init-solib if you do need auto-init for bootstrapping a DSO, or
--no-auto-init if you don't care about auto-bootstrap, along with
--ldflags to xeno-config.

http://www.xenomai.org/documentation/xenomai-3/html/man1/xeno-config/index.html

> 
> I suggest you add the missing --posix in the LDFLAGS as well.  After all, I copied my app from this very snippet and that's why I get the error.
> 

As mentioned in the doc you are referring to, this example is about
building a trivial VxWorks app, not a POSIX one.

-- 
Philippe.

